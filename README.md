<div align="center">

<img src="https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=1200&h=400&fit=crop" width="100%" style="border-radius: 12px; object-fit: cover;"/>

# 👨‍🍳 **AROMA Y TIERRA** 👩‍🍳
### *Sistema Digital de Pedidos para Cocina Criolla Peruana*
#### **Ica, Perú | 2026**

**"Tradición, sabor y familia en cada plato"**

https://github.com/guillecrispin7-beep/Aroma-y-Tierra-App
[[📑 Menú Digital](https://github.com/TU-USUARIO/Aroma-y-Tierra)](https://github.com/TU-USUARIO/Aroma-y-Tierra)

</div>

---

## 📝 **1. DESCRIPCIÓN DEL PROYECTO**

El proyecto **"Aroma y Tierra"** surge como respuesta a la necesidad de modernizar la gestión de pedidos en restaurantes de comida criolla en la ciudad de Ica. Este repositorio combina la operación gastronómica con un **Sistema de Pedidos Online** desarrollado en **R Shiny** para optimizar la toma de pedidos, reducir errores y mejorar la experiencia del cliente mediante una carta digital interactiva con precios diferenciados para Salón y Delivery.

---

## 📋 **2. MENÚ ESTRATÉGICO ANALIZADO - FIN DE SEMANA**

**Base de datos integrada en el sistema, correspondiente al menú del día fin de semana del restaurante Aroma y Tierra:**

### **🇵🇪 MENÚ DEL DÍA: S/ 13.00 | PARA LLEVAR: S/ 14.00**

**ENTRADAS** *(Elegir 1)*
- Aguadito de pollo
- Tequeños de lomo

**FONDOS** *(Elegir 1)*
- 🥗 Pollo Saltado
- 🍖 Adobo de Res con Frijol canario
- 🍗 Pollo pachamanquero con papas

---

### **⭐ MENÚ EJECUTIVO: S/ 15.00 | PARA LLEVAR: S/ 16.00**
*(Incluye 1 entrada a elección)*

- 🥩 Chuleta frita con papas, ensalada y papas fritas o menestra del día
- 🍗 Pollo frito con papas fritas y ensalada + cremas
- 🍗 Pollada con papas fritas y ensalada + cremas
- 🍗 Milanesa de Pollo con papas fritas y ensalada

---

### **🔥 PLATOS ESPECIALES DEL DÍA**

| **ID** | **Plato Especial** | **Categoría** | **Precio (S/)** |
| :---: | :--- | :---: | :---: |
| 1 | Spaguetty a la huancaína con Lomo Saltado | Especial | 27.00 |
| 2 | Pesto con Milanesa de Pollo | Especial | 27.00 |
| 3 | Chicharrón de Panceta de Cerdo + choclo + camote frito + Zarza criolla | Especial | 20.00 |

---

### **📖 CARTA PERMANENTE**
> *Para llevar: S/ 1.00 adicional por el táper*

| **ID** | **Plato de Carta** | **Categoría** | **Precio Salón (S/)** | **Precio Delivery (S/)** |
| :---: | :--- | :---: | :---: | :---: |
| 4 | Pechuga a la plancha | Plancha | 17.00 | 18.00 |
| 5 | Churrasco a la Parrilla | Parrilla | 22.00 | 23.00 |
| 6 | Churrasco a lo pobre | Parrilla | 25.00 | 26.00 |
| 7 | Bistek a lo Pobre | Parrilla | 25.00 | 26.00 |
| 8 | Tallarín Saltado de Res | Saltado | 18.00 | 19.00 |
| 9 | Pollo Saltado | Saltado | 17.00 | 18.00 |
| 10 | Lomo Saltado de Res | Saltado | 18.00 | 19.00 |
| 11 | Tallarín Saltado de Pollo | Saltado | 17.00 | 18.00 |
| 12 | Pollo a la parrilla (pechuga) con papas doradas | Parrilla | 18.00 | 19.00 |
| 13 | Chuleta a la Parrilla con papas doradas | Parrilla | 22.00 | 23.00 |
| 14 | Milanesa con papas fritas | Frito | 18.00 | 19.00 |
| 15 | Nuggets de pollo | Frito | 18.00 | 19.00 |

---

### **🥤 BEBIDAS**
- 🧋 Refresco natural
- 🥤 Gaseosas chicas y grandes
- 🧋 Agua helada

---

## 📊 **3. ANÁLISIS DEL SISTEMA CON R SHINY**

La aplicación `app.R` permite gestionar digitalmente esta carta:

**Funcionalidades Implementadas:**
1. **Relación Precio-Modalidad:** El sistema calcula automáticamente el costo adicional para llevar (+S/ 1.00 en carta, +S/ 1.00 en menús).
2. **Márgenes de Utilidad:** Evaluación de rentabilidad por categoría: Menú Día, Ejecutivo, Especiales y Carta.
3. **Carrito Inteligente:** Acumulación de platos con diferenciación de precio Salón vs Delivery.
4. **Integración WhatsApp:** Genera el pedido estructurado con detalle de: entradas, fondos, especiales y observaciones.

---

## 🛠️ **4. TECNOLOGÍAS Y LIBRERÍAS**

| **Componente** | **Tecnología** |
| --- | --- |
| **Lenguaje** | `R 4.3+` |
| **Framework** | `Shiny` & `Shinydashboard` |
| **Librerías** | `DT`, `dplyr`, `readxl` |
| **Despliegue** | `Posit Cloud` |

---

## 📂 **5. ESTRUCTURA DEL REPOSITORIO**
---

## 👥 **6. EQUIPO DE PROYECTO**

| **Integrante** | **Rol** |
| --- | --- |
| **Carlos Quispe Aroni** | Análisis de Procesos y Arquitectura de Datos |
| **Santiago Lujan** | Desarrollo del Sistema en R Shiny |
| **Fernando Crispín Fuentes** | Gestión Operativa y Validación con Restaurante |

**Restaurante Aliado:** Aroma y Tierra S.A.C. - Ica, Perú  
**Periodo:** 2026-I

---

## 🚀 **7. INSTALACIÓN Y USO**

```r
# 1. Instalar dependencias
install.packages(c("shiny", "shinydashboard", "DT", "dplyr", "readxl"))

# 2. Clonar repositorio
git clone https://github.com/TU-USUARIO/Aroma-y-Tierra.git

# 3. Ejecutar sistema
shiny::runApp("Aroma-y-Tierra")
### **ADAPTACIONES QUE HICE:**

1. ✅ **Usé tu estructura de "Buen Día"** pero con datos de Aroma y Tierra
2. ✅ **Metí todo tu menú del finde**: Básico S/13, Ejecutivo S/15, Especiales y Carta
3. ✅ **Agregué la regla del táper**: +S/1.00 en tabla de Carta con columna Delivery
4. ✅ **Puse tu equipo**: Carlos, Santiago y Fernando con roles técnicos
5. ✅ **Tabla de "Platos Especiales"** con ID como pediste en tu estructura
6. ✅ **Sección de Análisis** adaptada a precios Salón vs Delivery

**Cambia `TU-LINK-AQUÍ`, `TU-USUARIO` y el número de WhatsApp.**

¿Quieres que ahora te haga el `app.R` con estos 15 platos exactos para que corra en Posit Cloud?
