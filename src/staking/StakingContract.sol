// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "../../lib/openzeppelin-contracts/contracts/access/AccessControl.sol";
import "../../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

/**
 * @title StakingContract
 * @notice Permite a los usuarios stakear un token ERC20 y recibir recompensas 
 *         con una APR global. Ofrece tres opciones de bloqueo (lock), y penaliza 
 *         las recompensas si se retiran antes de tiempo.
 *
 * @dev - Usa AccessControl para roles:
 *       ADMIN_ROLE puede cambiar la APR, la penalización, etc.
 *     - No depende de la librería Math (hace los cálculos de forma manual).
 *     - Supone que el contrato dispone de saldo suficiente (o capacidad de 
 *       minteo) para pagar recompensas al retirar.
 */
contract StakingContract is AccessControl {
    // Rol de administrador
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");

    // Token que se stakea y se usa para las recompensas
    IERC20 public stakingToken;

    // Tres opciones de tiempo de lock (en segundos). Ej: 30, 60, 90 días
    uint256[] public lockOptions;

    // APR (porcentaje anual). Si apr=10, implica 10% anual.
    uint256 public apr;

    // Penalización sobre las recompensas (en %). 
    // Ej: si penaltyFee=50 => se pierde el 50% de las recompensas si se retira antes de lockEnd.
    uint256 public penaltyFee;

    // Estructura que describe la información de cada usuario
    struct UserInfo {
        uint256 amountStaked;    // cuántos tokens tiene staked
        uint256 startTimestamp;  // momento en que comenzó el stake
        uint8 lockIndex;         // la opción de lock elegida (0, 1, 2)
    }

    // Mapeo de usuario -> UserInfo
    mapping(address => UserInfo) public userInfo;

    // Eventos para seguimiento de acciones
    event Staked(address indexed user, uint256 amount, uint8 lockIndex);
    event Unstaked(address indexed user, uint256 amount, uint256 rewardsClaimed, bool penalized);
    event ParametersUpdated(uint256 newApr, uint256 newPenaltyFee);

    /**
     * @dev Constructor:
     *      - Recibe la dirección del token ERC20 que se usará para stake y recompensas.
     *      - Recibe un array con las lockOptions (por ejemplo: [2592000, 5184000, 7776000]).
     *      - Recibe el APR inicial (apr) y la penalización inicial (penaltyFee).
     *      - Asigna ADMIN_ROLE a la cuenta que despliega el contrato.
     */
    constructor(
        address _stakingToken,
        uint256[] memory _lockOptions,
        uint256 _initialApr,
        uint256 _initialPenaltyFee
    ) {
        // Configuramos roles
        _grantRole(ADMIN_ROLE, msg.sender);
        _setRoleAdmin(ADMIN_ROLE, ADMIN_ROLE);

        // Seteamos las variables de configuración inicial
        stakingToken = IERC20(_stakingToken);
        lockOptions = _lockOptions;
        apr = _initialApr;
        penaltyFee = _initialPenaltyFee;
    }

    /**
     * @notice Permite al usuario stakear `amount` tokens escogiendo una de las 
     *         opciones de lock (0, 1 o 2).
     * @dev    Antes, el usuario debe hacer `approve` al stakingToken 
     *         para que este contrato pueda transferir sus tokens.
     */
    function stake(uint256 amount, uint8 lockIndex) external {
        require(amount > 0, "Cannot stake 0");
        require(lockIndex < lockOptions.length, "Invalid lock option");

// CEI PATTERN (Checks-Effects-Interactions)

// Actualizamos la información de staking del usuario
        UserInfo storage user = userInfo[msg.sender];
        user.amountStaked += amount;
        user.startTimestamp = block.timestamp;
        user.lockIndex = lockIndex;



        // Transferimos tokens desde el usuario al contrato
       stakingToken.transferFrom(msg.sender, address(this), amount);


        emit Staked(msg.sender, amount, lockIndex);
    }

    /**
     * @notice Calcula las recompensas pendientes de un usuario basadas en:
     *         - Monto staked
     *         - APR (apr)
     *         - Tiempo transcurrido desde startTimestamp
     * @dev    No aplica penalización aquí; la penalización se descuenta en `unstake()`
     */
    function pendingRewards(address _user) public view returns (uint256) {
        UserInfo memory user = userInfo[_user];

        // Si no tiene nada staked, retorna 0
        if (user.amountStaked == 0) {
            return 0;
        }

        // Tiempo transcurrido en segundos
        uint256 timeDiff = block.timestamp - user.startTimestamp;

        // Cálculo simplificado:
        //  - Recompensa anual = (monto staked * apr) / 100
        //  - Recompensa final = recompensa anual * (timeDiff / 365 días)
        //
        // Asumimos 365 días = 31536000s
        uint256 YEAR_IN_SECONDS = 365 days;

        // Recompensa anual
        uint256 annualReward = (user.amountStaked * apr) / 100;
        // Recompensa acumulada en base al tiempo
        uint256 totalReward = (annualReward * timeDiff) / YEAR_IN_SECONDS;

        return totalReward;
    }

    /**
     * @notice Devuelve cuántos segundos faltan para que venza el lock 
     *         (si el usuario eligió 30, 60 o 90 días).
     */
    function timeLeft(address _user) external view returns (uint256) {
        UserInfo memory user = userInfo[_user];

        // Si no tiene nada staked, consideramos 0
        if (user.amountStaked == 0) {
            return 0;
        }

        uint256 duration = lockOptions[user.lockIndex];
        uint256 endTime = user.startTimestamp + duration;

        if (block.timestamp >= endTime) {
            return 0;
        } else {
            return endTime - block.timestamp;
        }
    }

    /**
     * @notice Unstake total de los tokens. Calcula y transfiere las recompensas.
     *         Aplica penalización sobre las recompensas si no se cumplió el lock.
     */
    function unstake() external {
        UserInfo storage user = userInfo[msg.sender];
        uint256 staked = user.amountStaked;

        require(staked > 0, "Nothing to unstake");

        // Calculamos las recompensas brutas
        uint256 reward = pendingRewards(msg.sender);

        // Verificamos si el lock ha expirado
        uint256 duration = lockOptions[user.lockIndex];
        uint256 lockEnd = user.startTimestamp + duration;
        bool penalized = false;

        if (block.timestamp < lockEnd) {
            // Aún no se cumple el lock => penalizar recompensas
            uint256 penaltyAmount = (reward * penaltyFee) / 100;
            reward = reward - penaltyAmount;
            penalized = true;
        }

        // Reseteamos la info del usuario para que no siga generando recompensas
        user.amountStaked = 0;
        user.startTimestamp = 0;

        // Transferimos el principal de vuelta al usuario
        stakingToken.transfer(msg.sender, staked);

        // Transferimos las recompensas netas
        if (reward > 0) {
            stakingToken.transfer(msg.sender, reward);
        }

        emit Unstaked(msg.sender, staked, reward, penalized);
    }

    /**
     * @notice Permite al ADMIN_ROLE actualizar la APR o la penalización.
     * @dev    Ej.: updateParameters(12, 40) => apr=12%, penaltyFee=40%
     */
    function updateParameters(uint256 _newApr, uint256 _newPenaltyFee)
        external
        onlyRole(ADMIN_ROLE)
    {
        apr = _newApr;
        penaltyFee = _newPenaltyFee;

        emit ParametersUpdated(_newApr, _newPenaltyFee);
    }
}































