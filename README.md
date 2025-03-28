# StakeMaster Pro 🚀💎

¡Bienvenido a **StakeMaster Pro**! Esta avanzada aplicación de staking, desarrollada en Solidity para el ecosistema DeFi, te permite stakear un único token ERC20 con múltiples opciones de lock (¡sí, 30, 60 y 90 días!) y aplicar penalizaciones en caso de retiro anticipado ⏱️💰. ¡Todo esto con una lógica modular y escalable para que siempre puedas mejorar sin complicaciones! 😎

---

## Tabla de Contenidos 📚

- [Características](#características)
- [Arquitectura](#arquitectura)
- [Requisitos](#requisitos)
- [Instalación](#instalación)
- [Uso](#uso)
- [Testing](#testing)
- [Contribuciones](#contribuciones)
- [Licencia](#licencia)
- [Contacto](#contacto)

---

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

## Arquitectura 🏗️

El proyecto se compone de dos contratos principales:

1. **MyToken.sol:**  
   Un token ERC20 con capacidad de mint restringida al administrador. Se utiliza tanto para el staking como para el pago de recompensas. 💎

2. **StakingContract.sol:**  
   Gestiona el staking de tokens. Permite a los usuarios depositar tokens, elegir entre tres opciones de lock (30, 60 y 90 días), calcular recompensas basadas en una APR global y aplicar penalizaciones en caso de retiro anticipado. 🔄💰


---

## Requisitos ✅

- **Solidity:** v0.8.19 o superior.
- **Foundry:** Para compilar y testear los contratos inteligentes.
- **Node.js y npm (opcional):** Útiles para herramientas auxiliares o scripts.
- **Herramientas de línea de comandos:** Como Git y un editor de código (por ejemplo, VSCode).

---

## Instalación 🛠️

### Contratos Inteligentes

1. **Instala Foundry** (si aún no lo has hecho) 🔥.
2. **Clona el repositorio** desde GitHub 📥.
3. **Compila los contratos** utilizando Foundry. ⚙️

> **Nota:** Actualmente, este proyecto se centra únicamente en el backend (contratos inteligentes) sin interfaz de usuario. ¡Pero la magia ya está en tus manos! ✨

---

## Uso 🚀

StakeMaster Pro te permite interactuar directamente con los contratos inteligentes a través de Remix, scripts de línea de comandos o cualquier otra herramienta que te conecte a la blockchain.

### Funcionalidades Principales

- **Stake:**  
  Deposita tus tokens ERC20 usando la función `stake`, especificando el monto y el índice de lock (por ejemplo, 0 para 30 días, 1 para 60 días o 2 para 90 días).  
  **Importante:** Antes de stakear, debes aprobar que el contrato transfiera tus tokens. ✅

- **Cálculo de Recompensas:**  
  La función de recompensas pendientes calcula de forma lineal las ganancias basadas en la APR y el tiempo transcurrido. ¡Gana mientras esperas! 💸📈

- **Tiempo Restante para Lock:**  
  Consulta la cantidad de segundos que faltan para completar el período de bloqueo. ⏲️

- **Unstake:**  
  Retira tus tokens con la función `unstake`. Si lo haces antes de que termine el lock, se aplicará la penalización correspondiente sobre las recompensas generadas. ⚠️💔

- **Actualización de Parámetros (Admin):**  
  El administrador puede actualizar la APR y la penalización mediante funciones específicas. 🔧👑

### Ejemplo de Interacción

1. **Aprobar y Stakear:**
   - Llama a la función de aprobación en el token ERC20 para permitir que el contrato de staking transfiera tus tokens. 🔓
   - Luego, llama a la función `stake` para depositar los tokens en el contrato de staking. 🚀

2. **Consultar Datos:**
   - Usa las funciones de recompensas pendientes y tiempo restante para ver la información de tu staking. 👀

3. **Unstake:**
   - Llama a la función `unstake` para retirar el principal junto con las recompensas netas (¡recuerda la penalización si es anticipado!). 🏦

---

## Testing 🧪

- Se han desarrollado tests unitarios y de integración utilizando Foundry para garantizar el correcto funcionamiento de todas las funcionalidades del contrato.
- Ejecuta los tests con el comando correspondiente de Foundry.
- ¡Obtén reportes detallados de gas y logs usando las opciones de alta verbosidad de Foundry! 🔍📊

---

## Contribuciones 🤝

¡Las contribuciones son más que bienvenidas! Si deseas mejorar StakeMaster Pro o agregar nuevas funcionalidades, sigue estos pasos:

1. **Haz un fork** del repositorio.
2. **Crea una rama** para tu feature.
3. **Realiza los cambios** y envía un pull request explicando las modificaciones.

¡Juntos haremos que este proyecto brille! 💫

---

## Licencia 📜

Este proyecto se distribuye bajo la **Licencia MIT**. ¡Comparte y colabora libremente! 👐

---

## Contacto 📞

- **Autor:** Vicent00
- **Email:** [tuemail@ejemplo.com](mailto:info@vicenteaguilar.com)

¡Gracias por explorar StakeMaster Pro! Si tienes alguna duda o sugerencia, no dudes en contactarnos. ¡Estamos aquí para ayudarte a crecer en el mundo DeFi! 🚀💥






