#carregando e arrumando o pacote do drive
install.packages("googledrive")
library(tidyverse)
library("googledrive")

drive_auth()
drive_download("Exportar(2).xlsx")
drive_download("Exportar.csv")
#glicemias <- read_csv("E:/Users/pedro/Documents/ADM/ESTATISTICA/R/GLICEMIAS/export(0).csv") essa maneira seria errada por conter o path pessoal

glicemias <- read_csv("Exportar.csv") #usando here::here para carregar o csv da pasta do projeto, independente do pc usado
#glicemiast <- read_csv("E:/Users/pedro/Downloads/export(0).csv", col_names = TRUE, cols_only(Data = col_date(format = "%d/%b/%Y"), Hora = "t", `Medi??o da glicemia (mg/dL)` = "d"))

#glicemiast2 <- read_csv("E:/Users/pedro/Downloads/export(0).csv", col_names = TRUE, col_types = "?t_d_____________________")

View(glicemias)

#install.packages("data.table")
#library(data.table)
#glicemiasf <- fread("E:/Users/pedro/Downloads/export(0).csv")

library(lubridate)

glicemias %>% 
  select(Data, Hora, Identificadores, `Medição da glicemia (mg/dL)`) %>%
  rename(Glicemia = `Medição da glicemia (mg/dL)`) %>% 
  mutate(Data = as_date(glicemias$Data, format = "%d/%b/%Y")) -> glicemias_filtd

#no lugadr do mutate 
##glicemias$Data <- as.date(glicemias$Data)

View(glicemias_filtd)

#glicemias_filtd %>% 
#  write_excel_csv2("E:/Users/pedro/Documents/ADM/ESTATISTICA/R/GLICEMIAS/glicemias_filtradas.csv", col_names = TRUE, na = " ")

id_principais_refeições <- c("Jejuar", "Antes da refeição, Jantar", "Almoço, Antes da refeição")
glicemias_filtd %>% 
  filter(Data >= "2020-10-11") %>% 
  pivot_wider(names_from = c(Identificadores), values_from = Glicemia) -> glicemias_pivot_wider
View(glicemias_pivot_wider)

glicemias_pivot_wider %>% 
    select(Data, Hora, Jejuar, `Antes da refeição, Jantar`)

glicemias_pivot_wider %>% 
  group_by(Data)
glicemias_filtd %>% 
  write_excel_csv2(here::here("planilhas salvas", "glicemias_filtradas.csv", na = " ")) # mesmo caso do primeiro read_csv


#glicemias_filtd %>% 
#  write_excel_csv("E:/Users/pedro/Downloads/glicemias_filtradas_2.csv")


#salvando
install.packages("writexl")
library(writexl)


#glicemias_filtd %>% 
#  write_xlsx("E:/Users/pedro/Documents/ADM/ESTATISTICA/R/GLICEMIAS/glicemias_filtradas_x.xlsx")

glicemias_filtd %>% 
  write_xlsx(here::here("planilhas salvas", "glicemias_filtradas_x.xlsx")) # mesmissimo caso do wd pessoal



#alternativa usando xlsx
library(readxl)
#glicemias_x <- read_excel("E:/Users/pedro/Documents/ADM/ESTATISTICA/R/GLICEMIAS/export(1).xls", col_types = c("date", "t", "skip", "d", "skip"))
glicemias_x <- read_excel("Exportar(2).xlsx", col_types = c("date", "t", "skip", "d", "skip"))
glicemias_x <- read_excel("Exportar(2).xlsx")
View(glicemias_x)
