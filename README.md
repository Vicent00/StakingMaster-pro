# StakeMaster Pro 🚀💎

¡Bienvenido a **StakeMaster Pro**! Esta avanzada aplicación de staking, desarrollada en Solidity para el ecosistema DeFi, te permite stakear un único token ERC20 con múltiples opciones de lock (¡sí, 30, 60 y 90 días!) y aplicar penalizaciones en caso de retiro anticipado ⏱️💰. ¡Todo esto con una lógica modular y escalable para que siempre puedas mejorar sin complicaciones! 😎

---

## Tabla de Contenidos 📚

- [Características](#caracteristicas)
- [Arquitectura](#arquitectura)
- [Requisitos](#requisitos)
- [Instalación](#instalacion)
- [Uso](#uso)
- [Testing](#testing)
- [Contribuciones](#contribuciones)
- [Licencia](#licencia)
- [Contacto](#contacto)

---

<a name="caracteristicas"></a>
## Características ✨

- **Múltiples Opciones de Lock:**  
  Elige entre distintos períodos de bloqueo (30, 60 o 90 días) para maximizar tu estrategia de staking. ⏳🔒

- **Cálculo de Recompensas Basado en APR:**  
  Obtén recompensas de forma lineal utilizando una tasa anual fija (APR). ¡Tus ganancias crecen mientras más tiempo te comprometas! 📈💸

- **Penalización por Retiro Anticipado:**  
  Retirar tus fondos antes de tiempo aplicará una penalización sobre las recompensas, incentivándote a cumplir el lock. ⚠️⛔

- **Gestión Avanzada de Roles:**  
  Con `AccessControl`, solo el administrador (`ADMIN_ROLE`) puede modificar parámetros clave como la APR o el porcentaje de penalización. 🔐👑

- **Código Modular y Escalable:**  
  Una estructura preparada para futuras mejoras y extensiones, sin complicar la base inicial. ¡Listo para evolucionar con el tiempo! 🔧🚀

---

<a name="arquitectura"></a>
## Arquitectura 🏗️

El proyecto se compone de dos contratos principales:

1. **MyToken.sol:**  
   Un token ERC20 con capacidad de mint restringida al administrador. Este token se utiliza tanto para el staking como para el pago de recompensas.

2. **StakingContract.sol:**  
   Contrato inteligente que gestiona el staking de tokens. Permite a los usuarios depositar tokens, elegir entre tres opciones de lock (30, 60 y 90 días), calcular recompensas basadas en una APR global y aplicar penalizaciones sobre las recompensas si se retira antes de tiempo.


---

<a name="requisitos"></a>
## Requisitos

- **Solidity:** v0.8.19 o superior.
- **Foundry:** Para compilar y testear los contratos inteligentes.
- **Node.js y npm (opcional):** Si se desea utilizar herramientas auxiliares o scripts adicionales.
- **Herramientas de línea de comandos:** Como Git y un editor de código (por ejemplo, VSCode).

---

<a name="instalacion"></a>
## Instalación

### Contratos Inteligentes

1. **Instala Foundry** (si aún no lo has hecho).

2. **Clona el repositorio** desde GitHub.

3. **Compila los contratos** utilizando Foundry.

> **Nota:** Actualmente, este proyecto se centra únicamente en el backend (contratos inteligentes) sin interfaz de usuario.

---

<a name="uso"></a>
## Uso

StakeMaster Pro permite interactuar directamente con los contratos inteligentes a través de herramientas como Remix, scripts de línea de comandos o cualquier otra herramienta que permita realizar llamadas a la blockchain.

### Funcionalidades Principales

- **Stake:**  
  Los usuarios pueden stakear tokens ERC20 mediante la función de `stake`, donde se especifica el monto y el índice de lock elegido (por ejemplo, 0 para 30 días, 1 para 60 días o 2 para 90 días).  
  **Importante:** Antes de stakear, el usuario debe aprobar que el contrato pueda transferir sus tokens.

- **Cálculo de Recompensas:**  
  La función de recompensas pendientes calcula de forma lineal las recompensas acumuladas basadas en la APR y el tiempo transcurrido desde el inicio del stake.

- **Tiempo Restante para Lock:**  
  La función que indica el tiempo restante devuelve la cantidad de segundos que faltan para cumplir el período de bloqueo seleccionado.

- **Unstake:**  
  La función de `unstake` permite a los usuarios retirar sus tokens. Si el retiro se realiza antes de que termine el lock, se aplica la penalización correspondiente sobre las recompensas generadas.

- **Actualización de Parámetros (Admin):**  
  El administrador, a través de funciones específicas, puede actualizar la APR y la penalización.

### Ejemplo de Interacción

1. **Aprobar y Stakear:**
   - Llama a la función de aprobación en el token ERC20 para permitir que el contrato de staking transfiera los tokens.
   - Llama a la función de `stake` para depositar los tokens en el contrato de staking.

2. **Consultar Datos:**
   - Llama a las funciones de recompensas pendientes y tiempo restante para ver la información del staking.

3. **Unstake:**
   - Al llamar a la función de `unstake`, se retira el principal junto con las recompensas netas, aplicándose la penalización en caso de retiro anticipado.

---

<a name="testing"></a>
## Testing

- Se han desarrollado tests unitarios y de integración utilizando Foundry para asegurar el correcto funcionamiento de todas las funcionalidades del contrato.
- Para ejecutar los tests, se utiliza el comando de Foundry correspondiente.
- Es posible obtener un reporte detallado de gas y logs utilizando las opciones de alta verbosidad de Foundry.

---

<a name="contribuciones"></a>
## Contribuciones

Las contribuciones son bienvenidas. Para mejorar StakeMaster Pro o agregar nuevas funcionalidades, sigue estos pasos:

1. **Haz un fork** de este repositorio.
2. **Crea una rama** para tu feature.
3. **Realiza los cambios** y envía un pull request explicando las modificaciones.

---

<a name="licencia"></a>
## Licencia

Este proyecto se distribuye bajo la Licencia MIT.

---

<a name="contacto"></a>
## Contacto

- **Autor:** Vicent00
- **Email:** [info@vicenteaguilar.com](mailto:infol@vicenteaguilar.com)








