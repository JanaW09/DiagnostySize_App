#Packages must be installed with install.packages("name")
library(shiny)
library(shinydashboard)
library(shinyBS)
library(markdown)
library(DT)


source("ui.R",local = TRUE)
source("server.R")
source("optimal_paper1.R") #calculation sample size single-arm trial
source("power_calculation.R") #calculation power (single-arm)
source("plausibility.R") #plausibility checks for the entry values all designs
source("sample_size_function.R") # sample size calculation comparative design superiority, non-inferiority, mixed 
source("power_calc_comparative.R") #Power calculation comparative design

shinyApp(ui=ui,
         server=server)

     