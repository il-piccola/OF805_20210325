library(shiny)
library(shinyWidgets)
library(shinyjs)
library(DT)
library(shinyBS)
library(readr)
library(dplyr)

# 一覧表の項目名
dataItem_name <- c(
  "date",
  "lot",
  "pH",
  "Color(L)",
  "Color(b)",
  "Gel strength 4mm 345 NH apple",
  "Setting T° 345 NH apple PH/WIP",
  "DE",
  "time(min)OF805(sep1)",
  "time(min)OF805(sep2)",
  "area(%)OF805(sep1)",
  "area(%)OF805(sep2)",
  "Mn(n)OF805(sep1)",
  "Mn(n)OF805(sep2)",
  "Mn(n)Glucose",
  "Mn(w)OF805(sep1)",
  "Mn(w)Glucose",
  "viscosity(500 1/s)",
  "viscosity(100 1/s)",
  "Estimated Gel Strength",
  "Estimated DB"
)