library(shiny)
library(shinyWidgets)
library(shinyjs)
library(DT)
library(shinyBS)
shinyUI(fluidPage(
  shinyjs::useShinyjs(),
  
　 # 入力欄の説明用ポップアップの色定義
  tags$style(HTML("
                  .tooltip > .tooltip-inner {
                    width: 400px;
                    text-color:white;
                    background-color: #3c8dbc;
                    }
                  .tooltip.top .tooltip-arrow {
                    bottom: 0;
                    left: 50%;
                    margin-left: -5px;
                    border-top:5px solid #3c8dbc
                  }
                  ")),
  
  #### UI画面の設定 ####
  titlePanel("OF805 App"),
  
    #### Data部 ####
          fluidRow(
          # h3("Data"),
          column(2, h3("Data"))
        ),
  
      #### Information ####
            fluidRow(
              column(1, offset = 1, h4("Information")),
              br(),
              br(),
              column(2, offset = 2,
                     airDatepickerInput(
                       "date",
                       label = NULL,
                       placeholder = "date",
                       autoClose = TRUE,
                       addon = "none"
                       )
                     ),
              column(2, 
                     textInput(
                       "textInLot", 
                       label = NULL,
                       value = "", 
                       placeholder ="lot"
                       )
                     ),
              # 入力欄の説明用ポップアップ
              bsTooltip("date", "date",
                        "top", options = list(container = "body")),
              bsTooltip("textInLot", "lot",
                        "top", options = list(container = "body"))
              ),
            
  #IDを定義。まとめてリセット用
  div(id = "OF805",
      
      #### COA ####
            fluidRow(
              column(1, offset = 1, h4("COA")),
              br(),
              column(2, textInput("textIn01", label = NULL, placeholder = "pH",  value = "")),
              column(2, textInput("textIn02", label = NULL, placeholder =  "Color(L)", value = "")),
              column(2, textInput("textIn03", label = NULL, placeholder =  "Color(b)", value = "")),
              column(2, textInput("textIn04", label = NULL, placeholder =  "Gel strength 4mm 345 NH apple", value = "")),
              column(2, textInput("textIn05", label = NULL, placeholder =  "Setting T° 345 NH apple PH/WIP", value = "")),
              bsTooltip("textIn01", "pH",
                        "top", options = list(container = "body")),
              bsTooltip("textIn02", "Color(L)",
                        "top", options = list(container = "body")),
              bsTooltip("textIn03", "Color(b)",
                        "top", options = list(container = "body")),
              bsTooltip("textIn04", "Gel strength 4mm 345 NH apple",
                        "top", options = list(container = "body")),
              bsTooltip("textIn05", "Setting T° 345 NH apple PH/WIP",
                        "top", options = list(container = "body"))
            ),
         
      #### FT-IR ####
            fluidRow(
              column(1, offset = 1, h4("FT-IR")),
              br(),
              column(2, textInput("textIn06", label = NULL, placeholder = "DE", value = "")),
              bsTooltip("textIn06", "DE",
                        "top", options = list(container = "body"))
            ),
      
      #### GPC ####
            fluidRow(
              column(1, offset = 1, h4("GPC")),
              br(),
              column(2, textInput("textIn07", label = NULL, placeholder = "time(min)OF805(sep1)", value = "")),
              column(2, textInput("textIn08", label = NULL, placeholder = "time(min)OF805(sep2)", value = "")),
              column(2, textInput("textIn09", label = NULL, placeholder = "area(%)OF805(sep1)", value = "")),
              column(2, textInput("textIn10", label = NULL, placeholder = "area(%)OF805(sep2)", value = "")),
              bsTooltip("textIn07", "time(min)OF805(sep1)",
                        "top", options = list(container = "body")),
              bsTooltip("textIn08", "time(min)OF805(sep2)",
                        "top", options = list(container = "body")),
              bsTooltip("textIn09", "area(%)OF805(sep1)",
                        "top", options = list(container = "body")),
              bsTooltip("textIn10", "area(%)OF805(sep2)",
                        "top", options = list(container = "body"))
              ),
            fluidRow(
              column(2, offset = 2, textInput("textIn11", label = NULL, placeholder = "Mn(n)OF805(sep1)", value = "")),
              column(2, textInput("textIn12", label = NULL, placeholder = "Mn(n)OF805(sep2)", value = "")),
              column(2, textInput("textIn13", label = NULL, placeholder = "Mn(n)Glucose", value = "")), 
              column(2, textInput("textIn14", label = NULL, placeholder = "Mn(w)OF805(sep1)", value = "")),
              column(2, textInput("textIn15", label = NULL, placeholder = "Mn(w)Glucose", value = "")),
              bsTooltip("textIn11", "Mn(n)OF805(sep1)",
                        "top", options = list(container = "body")),
              bsTooltip("textIn12", "Mn(n)OF805(sep2)",
                        "top", options = list(container = "body")),
              bsTooltip("textIn13", "Mn(n)Glucose",
                        "top", options = list(container = "body")),
              bsTooltip("textIn14", "Mn(w)OF805(sep1)",
                        "top", options = list(container = "body")),
              bsTooltip("textIn15", "Mn(w)Glucose",
                        "top", options = list(container = "body"))
            ),
      
      #### MCR ####
            fluidRow(
              column(1, offset = 1, h4("MCR")),
              br(),
              column(2, textInput("textIn16", label = NULL, placeholder = "viscosity(500 1/s)", value = "")),
              column(2, textInput("textIn17", label = NULL, placeholder = "viscosity(100 1/s)", value = "")),
              bsTooltip("textIn16", "viscosity(500 1/s)",
                        "top", options = list(container = "body")),
              bsTooltip("textIn17", "viscosity(100 1/s)",
                        "top", options = list(container = "body"))
            ),
            br(),
            
        #### dataセクション内ボタン ####
            fluidRow(    
              column(2, offset = 2, 
                     actionButton(
                       "button01", 
                       label = "Predict",
                       icon("flask"), 
                       style="color: #fff; background-color: #337ab7; border-color: #2e6da4"
                       )
                     ),
              column(2, 
                     actionButton(
                       "reset", 
                       label = "Clear",
                       icon("eraser"), 
                       style="color: #fff; background-color: #337ab7; border-color: #2e6da4"
                       )
                     )
            )
      ),

        ## 罫線
            hr(),
      
    #### Prediction部 ####
        fluidRow(
          column(2, h3("Prediction"))
        ),
        
      #### Result ####
        # ゲル強度予測値
            fluidRow(
              column(11, offset =1,
                     h4("Estimated Gel Strength: ", style="display:inline"), 
                     # textOutput("textOut01", inline = TRUE)
                     htmlOutput("textOut01", inline = TRUE)),
              column(11, offset = 1,
                     h5("(Minimum requirement: 700)", style="display:inline"),
                     
                     bsTooltip("textOut01", "Tolerance for Gel strength: +/- 30.5",
                               "top", options = list(container = "body"))
              ),
              br(),
              br(),
              br()
            ),
    
        # DB予測値
            fluidRow(
              column(11, offset =1,
                     h4("Estimated DB: ", style="display:inline"), 
                     htmlOutput("textOut02", inline = TRUE)),
              column(11, offset = 1,
                     h5("(Minimum requirement: 80)"), style="display:inline"),
              bsTooltip("textOut02", "Tolerance for DB: +/- 3.6",
                        "top", options = list(container = "body"))
            ),
        
            # br(),
        
        #### Predictionセクション内ボタン ####
            fluidRow(
              column(2, offset = 4, 
                     actionButton(
                       "button03", 
                       label = "Save results",
                       icon("save"), 
                       style="color: #fff; background-color: #337ab7; border-color: #2e6da4"
                     )
              )
              ),

            ## 罫線
            hr(),
            hr(),
  
    #### 入力・算出データ一覧表 表示部 ####
            fluidRow(
              column(12, h3("Inspection History")),
              br(),
              column(12,
                     DT::DTOutput("table_History")
              )
            ),
        br()
      )
    )