# ==============================================
# 1. CARGA DE LIBRERIAS
# ==============================================
library(shiny)
library(shinydashboard)
library(DT)
library(dplyr)

# ==============================================
# 2. DATA: 40 PLATOS AROMA Y TIERRA
# ==============================================
menu_datos <- data.frame(
  id = 1:40,
  Plato = c(
    "Aguadito de Pollo","Tequenos de Lomo","Pollo Saltado","Adobo de Res con Frijol","Pollo Pachamanquero",
    "Chuleta Frita + Menestra","Pollo Frito + Papas","Pollada Completa","Milanesa de Pollo","Spaguetty Huancaina con Lomo",
    "Lomo Saltado","Tallarin Saltado de Pollo","Arroz Chaufa de Pollo","Seco de Res con Frijol","Cau Cau de Mondongo",
    "Aji de Gallina","Estofado de Pollo","Chicharron de Cerdo","Ceviche de Pescado","Arroz con Mariscos",
    "Jalea Mixta","Parihuela","Sudado de Pescado","Tacu Tacu con Lomo","Anticuchos de Corazon",
    "Rocoto Relleno Arequipeno","Carapulcra con Sopa Seca","Papa a la Huancaina","Ocopa Arequipena","Solterito de Queso",
    "Caldo de Gallina","Sancochado Limeno","Chupe de Camarones","Escabeche de Pescado","Olluquito con Charqui",
    "Locro de Zapallo","Chanfainita","Arroz con Pato","Cabrito a la Nortena","Pachamanca a la Olla"
  ),
  Precio_Salon = c(
    13,13,13,15,15,15,27,25,16,16,
    18,16,16,20,25,24,28,30,26,22,
    24,18,20,19,12,14,15,14,20,32,
    18,17,16,15,25,26,23,24,22,25
  ),
  Precio_Llevar = c(
    14,14,14,16,16,16,28,26,17,17,
    19,17,17,21,26,25,29,31,27,23,
    25,19,21,20,13,15,16,15,21,33,
    19,18,17,16,26,27,24,25,23,26
  ),
  Categoria = c(
    "Entrada","Entrada","Menu del Dia","Ejecutivo",
    "Especial","Especial","Menu del Dia","Carta","Carta",
    "Carta","Carta","Carta","Especial","Especial",
    "Criollo","Criollo","Especial","Marino","Marino",
    "Marino","Marino","Marino","Criollo","Entrada",
    "Regional","Regional","Entrada","Entrada","Entrada",
    "Sopa","Sopa","Sopa","Marino","Criollo",
    "Regional","Criollo","Especial","Especial","Especial"
  ),
  stringsAsFactors = FALSE
)

# ==============================================
# 3. INTERFAZ DE USUARIO (UI)
# ==============================================
ui <- dashboardPage(
  skin = "red",
  dashboardHeader(title = "Aroma y Tierra v1.0", titleWidth = 250),

  dashboardSidebar(
    width = 250,
    sidebarMenu(
      id = "sidebar",
      menuItem("Menu Completo", tabName = "data", icon = icon("utensils")),
      menuItem("Filtros y Busqueda", tabName = "explore", icon = icon("search")),
      menuItem("Carrito de Compras", tabName = "descriptive", icon = icon("shopping-cart")),
      menuItem("Pedido WhatsApp", tabName = "hypothesis", icon = icon("whatsapp")),
      menuItem("Dashboard Ventas", tabName = "modeling", icon = icon("chart-line"))
    ),
    conditionalPanel(
      condition = "input.sidebar == 'explore'",
      h4("Opciones de Filtro", style = "padding-left: 20px;"),
      selectInput("cat", "Categoria:", choices = c("Todos", sort(unique(menu_datos$Categoria)))),
      radioButtons("tipo_precio", "Tipo Precio:", choices = c("Salon" = "salon", "Para Llevar" = "llevar"), selected = "llevar"),
      sliderInput("precio_max", "Precio Maximo:", min = 10, max = 35, value = 35, pre = "S/. ")
    )
  ),

  dashboardBody(
    tabItems(
      tabItem(tabName = "data",
              fluidRow(
                valueBoxOutput("total_platos", width = 4),
                valueBoxOutput("precio_min", width = 4),
                valueBoxOutput("precio_max", width = 4)
              ),
              box(title = "Vista Previa - 40 Platos", width = 12, DTOutput("data_preview"))
      ),

      tabItem(tabName = "explore",
              box(title = "Menu Filtrado - Click en + para Agregar", width = 12,
                  DTOutput("tabla_filtrada"))
      ),

      tabItem(tabName = "descriptive",
              box(width = 12,
                  h3("Tu Carrito de Compras"),
                  DTOutput("tabla_carrito"),
                  hr(),
                  h2(textOutput("total_pagar"))
              )
      ),

      tabItem(tabName = "hypothesis",
              box(width = 12,
                  h3("Datos para Delivery"),
                  textInput("nombre", "Nombre Cliente:"),
                  textInput("celular", "Celular:"),
                  textInput("direccion", "Direccion:"),
                  actionButton("run_whatsapp", "Enviar Pedido por WhatsApp", class = "btn-success btn-lg", icon = icon("whatsapp")),
                  hr(),
                  verbatimTextOutput("pedido_final"))
      ),

      tabItem(tabName = "modeling",
              box(title = "Estadisticas del Menu", status = "primary", solidHeader = TRUE, width = 12,
                  tabsetPanel(
                    tabPanel("Resumen", verbatimTextOutput("resumen_menu")),
                    tabPanel("Grafico Categorias", plotOutput("grafico_cat")),
                    tabPanel("Top Precios", DTOutput("top_precios"))
                  )
              )
      )
    )
  )
)

# ==============================================
# 4. SERVIDOR (LOGICA)
# ==============================================
server <- function(input, output, session) {

  carrito <- reactiveVal(data.frame(id=numeric(), Plato=character(), Precio=numeric(), Cant=numeric(), stringsAsFactors = FALSE))

  menu_filtrado <- reactive({
    df <- menu_datos
    if(input$cat!= "Todos") df <- df[df$Categoria == input$cat, ]
    precio_col <- ifelse(input$tipo_precio == "llevar", "Precio_Llevar", "Precio_Salon")
    df <- df[df[[precio_col]] <= input$precio_max, ]
    df
  })

  output$data_preview <- renderDT({
    datatable(menu_datos[, c("Plato", "Categoria", "Precio_Salon", "Precio_Llevar")],
              options = list(scrollX = TRUE, pageLength = 10))
  })

  output$total_platos <- renderValueBox({
    valueBox(nrow(menu_datos), "Platos en Carta", icon = icon("concierge-bell"), color = "red")
  })
  output$precio_min <- renderValueBox({
    valueBox(paste0("S/. ", min(menu_datos$Precio_Salon)), "Plato Economico", icon = icon("dollar-sign"), color = "green")
  })
  output$precio_max <- renderValueBox({
    valueBox(paste0("S/. ", max(menu_datos$Precio_Salon)), "Plato Premium", icon = icon("star"), color = "yellow")
  })

  output$tabla_filtrada <- renderDT({
    df <- menu_filtrado()
    precio_col <- ifelse(input$tipo_precio == "llevar", "Precio_Llevar", "Precio_Salon")
    df_tabla <- data.frame(
      Plato = df$Plato,
      Categoria = df$Categoria,
      Precio = paste0("S/. ", df[[precio_col]]),
      Agregar = paste0('<button id="add_', df$id,'" type="button" class="btn btn-warning btn-sm" onclick="Shiny.setInputValue(\'add_click\', this.id, {priority: \'event\'})">+</button>')
    )
    datatable(df_tabla, escape = FALSE, options = list(dom = 'tp', pageLength = 10),
              rownames = FALSE, selection = 'none')
  })

  observeEvent(input$add_click, {
    id_plato <- as.numeric(gsub("add_", "", input$add_click))
    fila <- menu_datos[menu_datos$id == id_plato, ]
    precio <- ifelse(input$tipo_precio == "llevar", fila$Precio_Llevar, fila$Precio_Salon)

    actual <- carrito()
    if(id_plato %in% actual$id){
      actual$Cant[actual$id == id_plato] <- actual$Cant[actual$id == id_plato] + 1
    } else {
      actual <- rbind(actual, data.frame(id=id_plato, Plato=fila$Plato, Precio=precio, Cant=1, stringsAsFactors = FALSE))
    }
    carrito(actual)
    showNotification(paste("Agregado:", fila$Plato), type = "message", duration = 2)
  })

  output$tabla_carrito <- renderDT({
    df <- carrito()
    if(nrow(df) > 0){
      df <- df[, c("Plato", "Precio", "Cant")]
      df$Subtotal <- paste0("S/. ", df$Precio * df$Cant)
      df$Precio <- paste0("S/. ", df$Precio)
    }
    datatable(df, options = list(dom = 't', paging = FALSE), rownames = FALSE)
  })

  total <- reactive({
    sum(carrito()$Precio * carrito()$Cant)
  })

  output$total_pagar <- renderText({ paste0("TOTAL A PAGAR: S/. ", total()) })

  output$pedido_final <- renderPrint({
    req(input$run_whatsapp, nrow(carrito()) > 0)
    cat("CLIENTE:", input$nombre, "\n")
    cat("CELULAR:", input$celular, "\n")
    cat("DIRECCION:", input$direccion, "\n\n")
    cat("PEDIDO:\n")
    apply(carrito(), 1, function(x) cat(x[4],"x",x[2],"S/.",x[3],"\n"))
    cat("\nTOTAL: S/.", total())
  })

  observeEvent(input$run_whatsapp, {
    req(nrow(carrito()) > 0, input$nombre!= "", input$celular!= "")

    items <- paste(apply(carrito(), 1, function(x) paste0(x[4],"x ",x[2]," S/.",x[3])), collapse = "%0A")
    tipo <- ifelse(input$tipo_precio == "llevar", "PARA LLEVAR", "COMER EN LOCAL")

    texto <- paste0("Hola Aroma y Tierra! 👋%0A",
                    "*PEDIDO DESDE APP*%0A%0A",
                    "*Cliente:* ", input$nombre, "%0A",
                    "*Celular:* ", input$celular, "%0A",
                    "*Tipo:* ", tipo, "%0A",
                    if(input$tipo_precio == "llevar") paste0("*Direccion:* ", input$direccion, "%0A") else "",
                    "%0A*PEDIDO:*%0A", items,
                    "%0A%0A*TOTAL: S/. ", total(), "*")

    url <- paste0("https://wa.me/51987654321?text=", texto)

    showModal(modalDialog(
      title = "Pedido Listo para Enviar",
      tags$a(href=url, "Abrir WhatsApp", target="_blank", class="btn btn-success btn-lg"),
      easyClose = TRUE
    ))
  })

  output$resumen_menu <- renderPrint({ summary(menu_datos[, c("Precio_Salon", "Precio_Llevar")]) })
  output$grafico_cat <- renderPlot({
    barplot(table(menu_datos$Categoria), col = "#D9232D", main = "Platos por Categoria", las = 2, cex.names = 0.8)
  })
  output$top_precios <- renderDT({
    datatable(menu_datos[order(-menu_datos$Precio_Salon), c("Plato", "Precio_Salon")], options = list(pageLength = 5))
  })
}

# ==============================================
# 5. LANZAR APP
# ==============================================
shinyApp(ui = ui, server = server)
