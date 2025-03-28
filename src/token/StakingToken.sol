// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "../../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "../../lib/openzeppelin-contracts/contracts/access/AccessControl.sol";


/**
 * @title MyToken
 * @dev ERC20 token con capacidad de mint restringida al ADMIN_ROLE
 */
contract StakingToken is ERC20, AccessControl {
    // Definimos una constante para el rol de administrador
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");

    /**
     * @dev Constructor:
     *   - Asigna nombre y símbolo al token (por ejemplo, "MyToken", "MTK").
     *   - Otorga el ADMIN_ROLE a la dirección que despliega el contrato (msg.sender).
     */
    constructor(string memory name_, string memory symbol_) ERC20(name_, symbol_) {
        // Otorgamos ADMIN_ROLE al deployer (la cuenta que hace el "new MyToken(...)")
        _grantRole(ADMIN_ROLE, msg.sender);

        // (Opcional) Con esta línea definimos que el ADMIN_ROLE es el propio administrador 
        // de sí mismo, de modo que puede otorgarse a otras direcciones si así se desea.
        _setRoleAdmin(ADMIN_ROLE, ADMIN_ROLE);
    }

    /**
     * @notice Mintea (crea) `amount` tokens y se los asigna a la dirección `to`.
     * @dev Solo puede ser llamado por una cuenta con ADMIN_ROLE.
     */
    function mint(address to, uint256 amount) external onlyRole(ADMIN_ROLE) {
        _mint(to, amount);
    }
}





