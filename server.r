library(shiny)
library(shinyWidgets)
library(shinyjs)
library(DT)
library(readr)
library(dplyr)


#### 初期設定 ####
## 保存データ
dir_path <- "./www/"
file_name <- "results.csv"
file_location <- paste0(dir_path, file_name)


shinyServer(function(input, output, session) {
  
  ## データ保存ファイルの有無を確認する
  if(!file.exists(file_location)){
    # ファイルが無い場合
    showModal(
      modalDialog(
        title = "FILE NOT FOUND",
        HTML(paste0("History data file, '",file_name, "' was not found in '", dir_path, "' folder.<br>"),
             paste0("New file, '", file_name, "' will be created in '", dir_path, "' folder.<br>"),
             ("If you have any issues for this, stop this application now and check file name etc. before proceeding any operations.")),
        easyClose = TRUE,
        footer = tagList(
          modalButton("Ok")
        )
      )
    )
    history_data <- NULL
  } else {
    # ファイルがある場合は読み込む。
    history_data <- read_delim(file_location, delim = ",", col_names = T, skip = 0)
    history_data <- history_data %>% 
      mutate_at(vars(-date), as.numeric) %>% 
      mutate_at(vars(date), as.character)
  }
  

  #### Predictionボタン押下時の処理 ####
  Estimated_value <- eventReactive(input$button01, {
    
    # 変数の定義
    numInput <- NULL
    BlankCHK <- 0
    
    ### データ入力有無の確認
    for (i in 1:17) {
      if(!isTruthy(eval(parse(text=paste0("input$textIn",sprintf("%02d",i)))))){color <- "solid red"; BlankCHK <- BlankCHK + 1} else {color <- ""}
      runjs(paste0("document.getElementById('textIn", sprintf("%02d",i), "').style.border ='", color ,"'"))
    }
    if(!isTruthy(input$date)){color <- "solid red"; BlankCHK <- BlankCHK + 1} else {color <- ""}
    runjs(paste0("document.getElementById('date').style.border ='", color ,"'"))
    if(!isTruthy(input$textInLot)){color <- "solid red"; BlankCHK <- BlankCHK + 1} else {color <- ""}
    runjs(paste0("document.getElementById('textInLot').style.border ='", color ,"'"))
    
    # textInputからデータ取得。textIn01〜17
      n.01 <- as.numeric(input$textIn01)
      n.02 <- as.numeric(input$textIn02)
      n.03 <- as.numeric(input$textIn03)
      n.04 <- as.numeric(input$textIn04)
      n.05 <- as.numeric(input$textIn05)
      n.06 <- as.numeric(input$textIn06)
      n.07 <- as.numeric(input$textIn07)
      n.08 <- as.numeric(input$textIn08)
      n.09 <- as.numeric(input$textIn09)
      n.10 <- as.numeric(input$textIn10)
      n.11 <- as.numeric(input$textIn11)
      n.12 <- as.numeric(input$textIn12)
      n.13 <- as.numeric(input$textIn13)
      n.14 <- as.numeric(input$textIn14)
      n.15 <- as.numeric(input$textIn15)
      n.16 <- as.numeric(input$textIn16)
      n.17 <- as.numeric(input$textIn17)
      
    numInput <- c(
      as.character(input$date),
      as.numeric(input$textInLot),
      n.01,
      n.02,
      n.03,
      n.04,
      n.05,
      n.06,
      n.07,
      n.08,
      n.09,
      n.10,
      n.11,
      n.12,
      n.13,
      n.14,
      n.15,
      n.16,
      n.17
    )
    
    # ゲル強度予測値をnumInput[20]、DB予測値をnumInput[21]に入れる　####
    numInput[20] <- (-8626.150968) +
                   (-257.544288484785) *  n.01 +
                  (3.90887935980917) *  n.02 +
                  (-3.48697162479036) *  n.04 +
                  (5.25312598536068) *  n.05 +
                  (-4.66854850605137) *  n.06 +
                  (553.358734001001) *  n.07 +
                  (-4.25167249009321) *  n.08 +
                  (22.4104509052532) *  n.09 +
                  (-0.000830882745665852) *  n.12 +
                  (-32.8332947335144) * n.13 +
                  (0.000996283319907581) *  n.14 +
                  (-0.123387421749259) *  n.15 +
                  (-39.39279218946) * n.16 +
                  (n.06+  (-31.5156626506024)) *  ((n.04+  (-89.9036144578313)) * (-4.02207225076705)) +
                  (n.06+  (-31.5156626506024)) *  ((n.08+  (-26.8953132530121)) * (743.552424877663)) +
                  (n.01+ (-4.75903614457831)) *  ((n.08+  (-26.8953132530121)) * (3841.07240411657)) +
                  (n.04+  (-89.9036144578313)) *  ((n.07+  (-24.4800120481928)) * (54.1522140068262)) +
                  (n.05+ (-69.2530120481928)) *  ((n.13+  (-137.55421686747)) * (18.8472386693445)) +
                  (n.08+  (-26.8953132530121)) *  ((n.09+  (-14.4121927710843)) * (-429.127131351226)) +
                  (n.09+  (-14.4121927710843)) *  ((n.14+  (-1613253.31325301)) * (0.000297543810056397)) +
                  (n.12+  (-63221.3373493976)) *  ((n.14+  (-1613253.31325301)) * (0.0000000701922740107)) +
                  (n.14+  (-1613253.31325301)) *  ((n.16+  (-11.2987951807229)) * (-0.000263301386632649)) +
                  (n.15+  (-145.156626506024)) *  ((n.16+  (-11.2987951807229)) * (-63.3619775966322))
    numInput[21] <- (-302.2969926) +
                  (35.2506089137789) * n.01 +
                  (0.855941923473227) * n.03 +
                  (0.509249334737319) * n.04 +
                  (0.724946163759483) * n.10 +
                  (-0.0001737428633552) * n.11 +
                  (-1.5665250581062) * n.13 +
                  (2.40931180335421) * n.15 +
                  (16.3714915101507) * n.17 +
                  (-3.03107337424536) * n.16 +
                  (n.01+ (-4.76829268292683)) *  ((n.13  -137.90243902439) * (19.8146110641124)) +
                  (n.03+ (-16.8292682926829)) *  ((n.13  -137.90243902439) * (3.23787575439118)) +
                  (n.04+ (-89.6585365853659)) *  ((n.13  -137.90243902439) * (1.47510988361813)) +
                  (n.04+ (-89.6585365853659)) *  ((n.16  -11.190243902439) * (-0.993980798299267)) +
                  (n.10+ (-63.6349268292683)) *  ((n.15  -145.560975609756) * (1.84761257454434)) +
                  (n.10+ (-63.6349268292683)) *  ((n.17  -14.1951219512195) * (-0.356828595700079)) +
                  (n.10+ (-63.6349268292683)) *  ((n.16  -11.190243902439) * (3.00559809936927))
    text_reactive$Est_gelSTR <- numInput[20]
    text_reactive$Est_DB <- numInput[21]
    
    # 空欄がある場合は警告を表示
    if(BlankCHK > 0){
      showModal(modalDialog(
        title = "Input fields empty.",
        span("Input fields must not be empty."),
        footer = modalButton("Ok")
      ))
      numInput[20] <- NA
      numInput[21] <- NA
      # Dialogを一定時間表示後に非表示にする
      Sys.sleep(3)
      removeModal()
    }
    # 全ての入力値・算出値をまとめて出力する
    numOutput <- numInput
  })
  
  #### ゲル強度推測値、DB推測値の初期設定 ####
  text_reactive <- reactiveValues(
    Est_gelSTR = NA,
    Est_DB = NA
  )
  
  #### ゲル強度予測値の算出・描画 ####
  output$textOut01 <- renderText({
    # ゲル強度推測値
    Est_gelSTR <- as.numeric(text_reactive$Est_gelSTR)
    # 下限値と上限値の定義
    min_gelSTR <- 700
    tole_gelSTR <- 30.5
    # 合否判定
    if (is.na(Est_gelSTR)){
      Est_gelSTR <- NULL
    } else if (Est_gelSTR >= min_gelSTR && Est_gelSTR-tole_gelSTR >= min_gelSTR){
      paste(
        Est_gelSTR, " ( ", Est_gelSTR-tole_gelSTR, " - ", Est_gelSTR+tole_gelSTR, " ) ",
        ' ',
        '<font color="green"><b>Accept</b></font>', collapse=' '
      )
    } else if (Est_gelSTR >= min_gelSTR && Est_gelSTR-tole_gelSTR < min_gelSTR) {
      paste0(
        Est_gelSTR, " ( ", Est_gelSTR-tole_gelSTR, " - ", Est_gelSTR+tole_gelSTR, " ) ",
        ' ',
        '<font color="yellow"><b>Accept</b></font>', collapse=' '
      )
    } else if (Est_gelSTR < min_gelSTR) {
    paste0(
      Est_gelSTR, " ( ", Est_gelSTR-tole_gelSTR, " - ", Est_gelSTR+tole_gelSTR, " ) ",
      ' ',
      '<font color="red"><b>Reject</b></font>', collapse=' '
    )
  }
  })
  
  #### DB予測値の算出・描画 ####
  output$textOut02 <- renderText({ #?????????????????????    
    # DB推測値       
    Est_DB <- as.numeric(text_reactive$Est_DB)
    # 下限値と上限値の定義
    min_DB <- 80
    tole_DB <- 3.6
    # 合否判定
    if (is.na(Est_DB)){
      Est_DB <- NULL
    } else if (Est_DB >= min_DB && Est_DB-tole_DB >= min_DB){
      paste(
        Est_DB, " ( ", Est_DB-tole_DB, " - ", Est_DB+tole_DB, " ) ",
        ' ',
        '<font color="green"><b>Accept</b></font>', collapse=' '
      )
    } else if (Est_DB >= min_DB && Est_DB-tole_DB < min_DB){
      paste(
        Est_DB, " ( ", Est_DB-tole_DB, " - ", Est_DB+tole_DB, " ) ", 
        ' ',
        '<font color="yellow"><b>Accept</b></font>', collapse=' '
      )
    } else if (Est_DB < min_DB){
      paste(
        Est_DB, " ( ", Est_DB-tole_DB, " - ", Est_DB+tole_DB, " ) ",
        ' ',
        '<font color="red"><b>Reject</b></font>', collapse=' '
      )
    }
  })
  
  #### リセットボタン押下時の処理 ####
  observeEvent(input$reset, { #?????????????????????
    shinyjs::reset("OF805")
    shinyjs::reset("textInLot")
    updateAirDateInput(session, "date", clear = TRUE)
    for (i in 1:17) {
      runjs(paste0("document.getElementById('textIn", sprintf("%02d",i), "').style.border ='", '', "'"))
    }
    runjs(paste0("document.getElementById('date').style.border ='", '' ,"'"))
    runjs(paste0("document.getElementById('textInLot').style.border ='", '' ,"'"))
    text_reactive$Est_gelSTR <- NA
    text_reactive$Est_DB <- NA
    Table_reactive$data <- history_data
  })
  
  #### Save to csvボタン押下時の処理 ####
  observeEvent(input$button03, {
    # 入力欄と予測値が全て埋まっているか確認する。埋まっていなければ保存不可にする。
    numOutput <- Estimated_value()
    if(anyNA(numOutput)){
        showModal(modalDialog(
          title = "Cannot save the file",
          span("Fill out all input fields and predict accept/reject",
            "before save the file."),
          footer = modalButton("Ok")
        ))
        # Dialogを一定時間表示後に非表示にする
        Sys.sleep(3)
        removeModal()
    } else {
      # saveするか確認する
        showModal(
          modalDialog(
          span(paste0('Do you want to save the results to ', file_location, ' ?')),
          easyClose = TRUE,
          footer = tagList(
            modalButton("Cancel"),
            actionButton("oktosave", "Yes")
            )
          )
        )
    }
  })
  
  
  #### Yes to Saveボタン押下時の処理 ####
  observeEvent(input$oktosave, {
    # データ保存の準備
    numOutput <- Estimated_value()
    numOutput <- matrix(numOutput,1,length(numOutput))
    numOutput <- data.frame(numOutput, stringsAsFactors = F)
    colnames(numOutput) <- dataItem_name
    
    #CSV出力
    # エラーチェックの準備
    messageAfterSave <- NULL
    messageAfterSave <- try(
      
      # 新規保存か過去の保存データへの追加かを判定し、それに応じた保存を行う。
      if(!file.exists(file_location)){
        write_delim(numOutput,file_location,delim=",",append=F)
      } else {
        write_delim(numOutput,file_location,delim=",",append=T)
      },
      silent = FALSE)
    
    # データ保存中にエラーが発生したかを確認する。
    if (class(messageAfterSave) == "try-error"){
      # エラーが発生した場合
      messageAfterSave <- "<font color='red'><b>Failed</b></font> to save due to an unexpected error."
    } else {
      # エラーが発生しなかった場合
      messageAfterSave <- "Result data saved <font color='green'><b>successfully</b></font>."
      history_data <<- rbind(numOutput, history_data)
    }
    
    # 保存完了の確認表示
    showModal(
      modalDialog(
        HTML(messageAfterSave),
        easyClose = TRUE,
        footer = tagList(
          modalButton("Ok")
        )
      )
    )
  })
  
  # 一覧表の初期設定
  Table_reactive <- reactiveValues(
    data = history_data
  )
  
  # 一覧表へのデータ受け渡し
  observe({
    numOutput <- Estimated_value()
    numOutput <- matrix(numOutput,1,length(numOutput))
    numOutput <- data.frame(numOutput, stringsAsFactors = F)
    colnames(numOutput) <- dataItem_name
    numOutput <- numOutput %>% 
      mutate_at(vars(-date), as.numeric) %>% 
      mutate_at(vars(date), as.character)
    
    # 既存データの下に過去データを追加する
    if(!is.null(history_data) && !is.na(numOutput)){
      numOutput <- rbind(numOutput, history_data)
      Table_reactive$data <- numOutput
    } else if(!is.null(history_data) && is.na(numOutput)){
      Table_reactive$data <- history_data
    } else if(is.null(history_data) && !is.na(numOutput)){
      Table_reactive$data <- numOutput
    }
  })

  #### 入力・算出データ一覧表の作成 ####
  output$table_History <- DT::renderDT({
    Table_reactive$data
  },
  # 表の設定
  options = list(
    # X方向へのスクロール可
    scrollX=TRUE,
    # DropDown menuの選択肢
    lengthMenu = c(25, 50, 100), 
    # DropDown menuの初期値
    pageLength = 25
  ),
  rownames = FALSE
  )
})