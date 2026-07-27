library(shiny)
library(shinydashboard)
library(shinyBS) 
library(DT)


ui <- fluidPage( 
  
  title <- "",tags$img(src="DiagnostySize2.png", height = "150px", width = "150px", alt = "something went wrong, here would be the app logo", deleteFiler = FALSE),
  'Sample size calculation tool',
  
  tags$a(href='https://www.uke.de/',
         tags$img(src="signature_dachmarke_2017.jpg",height ="30px", width = "30px", alt = "something went wrong, here would be the uke logo", deleteFile = FALSE)),
  
  tags$a(href='https://www.uke.de/kliniken-institute/institute/medizinische-biometrie-und-epidemiologie/index.html',
         tags$img(src="logo_final.png", height = "35px",width = "70px", alt = "something went wrong, here would be the IMBE logo", deleteFile = FALSE)),
  
  tags$script(HTML(  #deactivates the scrolling for a numeric input field
    "document.addEventListener('wheel', function(event){
    if(document.activeElement.type == 'number'){
        document.activeElement.blur();
    }
    });"
  )),
  dashboardPage(title="diagnostysize",skin = "purple",
                dashboardHeader(title = title, titleWidth = 500),
  
                dashboardSidebar(collapsed = FALSE, disable = FALSE,
                                
                radioButtons("endpoint",
                "Please select the parameter to be solved:",
                choices = c("Sample size"= "sample_size",
                                                          "Power" ="power")),
                                   #power
                                   conditionalPanel(
                                     condition = "input.endpoint == 'power'",
                                     fluidRow(
                                       column( 8, radioButtons("studydesigns_p",
                                                               "Please choose a study design",
                                                               choices = c("single-arm trial"= "single_p", 
                                                                           "comparative trial"= "comparative_p")),),
                                       column(1, bsButton("designhelp","?"))
                                       
                                     ),
                                   #power single-------------------------------------------------------------------------------------------------------------------------------
                                   conditionalPanel(
                                     condition ="input.studydesigns_p =='single_p'",
                                     numericInput("prev_pow", #prevalence
                                                  "Prevalence:",
                                                  value = 0.5,
                                                  min = 0,
                                                  max = 1,
                                                  step = 0.01 ),
                                     bsTooltip(id = "prev_pow", #Tooltip shown while hovering over the input field
                                               title = "The prevalence is the proportion of individuals with the target condition.",
                                               trigger = "hover"),
                                     numericInput("samplesize", 
                                                  "Sample size:",
                                                  value = 1500,
                                                  min = 0,
                                                  max = 99999999,
                                                  step = 1),
                                     bsTooltip(id = "samplesize", 
                                               title = "The sample size is the number of subjects selected for a study.",
                                               trigger = "hover"),
                                     numericInput("alpha_pow", 
                                                  "Two-sided type-one error (alpha):",
                                                  value = 0.05,
                                                  min = 0,
                                                  max = 1,
                                                  step = 0.01),
                                     bsTooltip(id = "alpha_pow", 
                                               title = "The type-one error is the probability of incorrectly rejecting the null hypothesis.",
                                               trigger = "hover"),
                                     numericInput("se_ni_pow", #sensitivity minimum sensitivity (non inferiority)
                                                  "Minimum sensitivity:",
                                                  value = 0.75,
                                                  min = 0,
                                                  max = 1,
                                                  step = 0.01),
                                     bsTooltip(id = "se__ni_pow", #sensitivity non inferiority
                                               title = "The sensitivity of a test is the rate of true positive test results.",
                                               trigger = "hover"),
                                     numericInput("se_pow", #sensitivity new test
                                                  "Expected sensitivity for the new test: :",
                                                  value = 0.8,
                                                  min = 0,
                                                  max = 1,
                                                  step = 0.01),
                                     bsTooltip(id = "se_pow", 
                                               title = "The sensitivity of a test is the rate of true positive test results.",
                                               trigger = "hover"),
                                     numericInput("sp_ni_pow",  #specificity minimum specificity non inferiority
                                                  "Minimum specificity:",
                                                  value = 0.6,
                                                  min = 0,
                                                  max = 1,
                                                  step = 0.01),
                                     bsTooltip(id = "sp_ni_pow", 
                                               title = "The specificity of a test is the rate of true negative test results.",
                                               trigger = "hover"),
                                     numericInput("sp_pow", #specificity new intervention / experimental
                                                  "Expected specificity for the new test: ",
                                                  value = 0.66,
                                                  min = 0,
                                                  max = 1,
                                                  step = 0.01),
                                     bsTooltip(id = "sp_pow", 
                                               title = "The specificity of the new intervention is the rate of true negative test results.",
                                               trigger = "hover"),
                                     numericInput( "drop_s_pow", #dropout single design pow- power
                                                   "Dropout rate: ",
                                                   value = 0,
                                                   min = 0,
                                                   max = 1,
                                                   step = 0.01),
                                     bsTooltip(id = "drop_s_pow",
                                               title = "The rate of estimated dropouts from the study.",
                                               trigger = "hover")
                                     
                                     
                                   ),
                                   #comparative design power
                                   conditionalPanel(
                                     condition ="input.studydesigns_p =='comparative_p'",
                                     fluidRow(
                                       column( 8, radioButtons("designs_p",
                                                               "Please choose a design",
                                                               choices = c("unpaired design"= "unpaired_p", "paired design"= "paired_p")),),
                                       column(1, bsButton("designhelp_comparative_p","?")) #Button for additional explanaitions
                                       
                                     ),
                                     #non-inferiotiy--------------------------------------------------------------------------------------------------------------
                                     numericInput("noninf_se_pow",
                                                  "Non-inferiority margin for sensitivity, for superiority hypothesis equal to 0:",
                                                  value = 0, #superiority = 0
                                                  min = 0, #must be positive
                                                  max = 1, 
                                                  step = 0.01
                                     ),
                                     numericInput("noninf_sp_pow",
                                                  "Non-inferiority margin for specificity, for superiority hypothesis equal to 0:",
                                                  value = 0,
                                                  min = 0,
                                                  max =1,
                                                  step = 0.01),
                                     #power unpaired-----------------------------------------------------------------------------------------------------------------------------
                                     conditionalPanel(
                                       condition= "input.designs_p =='unpaired_p'",
                                       numericInput("prev_up_pow", #up = unpaired 
                                                    "Prevalence:",
                                                    value = 0.5,
                                                    min = 0,
                                                    max = 1,
                                                    step = 0.01
                                       ),
                                       bsTooltip(id = "prev_up_pow", 
                                                 title = "The prevalence is the proportion of individuals with the target condition.",
                                                 trigger = "hover"),
                                       numericInput("samplesize_up", 
                                                    "Sample size:",
                                                    value = 1500,
                                                    min = 0,
                                                    max = 99999999,
                                                    step = 1),
                                       bsTooltip(id = "samplesize_up", 
                                                 title = "The sample size is the number of subjects selected for a study.",
                                                 trigger = "hover"),
                                       numericInput("alpha_up_pow", 
                                                    "Two-sided type-one error (alpha):",
                                                    value = 0.05,
                                                    min = 0,
                                                    max = 1,
                                                    step = 0.01
                                       ),
                                       bsTooltip(id = "alpha_up_pow", 
                                                 title = "The type-one error is the probability of incorrectly rejecting the null hypothesis.",
                                                 trigger = "hover"
                                       ),
                                       numericInput("se_up_pow", #sensitivity experimental test
                                                    "Expected sensitivity for the new test: ",
                                                    value = 0.8,
                                                    min = 0,
                                                    max = 1,
                                                    step = 0.01
                                       ),
                                       bsTooltip(id = "se_up_pow", 
                                                 title = "The sensitivity of a test is the rate of true positive test results.",
                                                 trigger = "hover"
                                       ),
                                       numericInput("se_ni_up_pow", #sensitivity comparator test non inferiority
                                                    "Sensitivity of the comparator test:",
                                                    value = 0.75,
                                                    min = 0,
                                                    max = 1,
                                                    step = 0.01
                                       ),
                                       bsTooltip(id = "se_ni_up_pow", 
                                                 title = "The sensitivity of a test is the rate of true positive test results.",
                                                 trigger = "hover"
                                       ),
                                       numericInput("sp_up_pow", #specificity new experimental test
                                                    "Expected specificity for the new test: ",
                                                    value = 0.66,
                                                    min = 0,
                                                    max = 1,
                                                    step = 0.01
                                       ),
                                       bsTooltip(id = "sp_up_pow", 
                                                 title = "The specificity of a test is the rate of true negative test results.",
                                                 trigger = "hover"),
                                       
                                       numericInput("sp_ni_up_pow",  #specificity comparator test non inferiority
                                                    "Specificity of the comparator test:",
                                                    value = 0.6,
                                                    min = 0,
                                                    max = 1,
                                                    step = 0.01),  
                                       bsTooltip(id = "sp_up_pow", 
                                                 title = "The specificity of a test is the rate of true negative test results.",
                                                 trigger = "hover"),
                                       numericInput( "drop_up_pow", #dropout 
                                                     "Dropout rate: ",
                                                     value = 0,
                                                     min = 0,
                                                     max = 1,
                                                     step = 0.01),
                                       bsTooltip(id = "drop_up_pow",
                                                 title = "The rate of estimated dropouts from the study.",
                                                 trigger = "hover")
                                       
                                     ),
                                     #power paired------------------------------------------------------------------------------------------------------------------------------
                                     conditionalPanel(
                                       condition= "input.designs_p =='paired_p'",
                                       numericInput("prev_p_pow",
                                                    "Prevalence:",
                                                    value = 0.5,
                                                    min = 0,
                                                    max = 1,
                                                    step = 0.01
                                       ),
                                       bsTooltip(id = "prev_p_pow", 
                                                 title = "The prevalence is the proportion of individuals with the target condition.",
                                                 trigger = "hover"),
                                       numericInput("samplesize_p", 
                                                    "Sample size:",
                                                    value = 1500,
                                                    min = 0,
                                                    max = 99999999,
                                                    step = 1),
                                       bsTooltip(id = "samplesize_p", 
                                                 title = "The sample size is the number of subjects selected for a study.",
                                                 trigger = "hover"),
                                       numericInput("alpha_p_pow", 
                                                    "Two-sided type-one error (alpha):",
                                                    value = 0.05,
                                                    min = 0,
                                                    max = 1,
                                                    step = 0.01
                                       ),
                                       bsTooltip(id = "alpha_p_pow", 
                                                 title = "The type-one error is the probability of incorrectly rejecting the null hypothesis..",
                                                 trigger = "hover"),
                                       numericInput("se_ni_p_pow", #sensitivity comparator test non inferiority
                                                    "Sensitivity of the comparator test:",
                                                    value = 0.75,
                                                    min = 0,
                                                    max = 1,
                                                    step = 0.01
                                       ),
                                       bsTooltip(id = "se__ni_p_pow", 
                                                 title = "The sensitivity of a test is the rate of true positive test results.",
                                                 trigger = "hover"),
                                       
                                       numericInput("se_p_pow", #sensitivity new intervention
                                                    "Expectedsen sitivity for the new test: ",
                                                    value = 0.8,
                                                    min = 0,
                                                    max = 1,
                                                    step = 0.01
                                       ),
                                       bsTooltip(id = "se_p_pow", 
                                                 title = "The sensitivity of a test is the rate of true positive test results.",
                                                 trigger = "hover"),
                                       
                                       numericInput("sp_ni_p_pow",  #specificity comparator test / reference standard non inferiority
                                                    "Specificity for the comparator test:",
                                                    value = 0.6,
                                                    min = 0,
                                                    max = 1,
                                                    step = 0.01),
                                       bsTooltip(id = "sp_ni_p_pow", 
                                                 title = "The specificity of a test is the rate of true negative test results.",
                                                 trigger = "hover"),
                                       
                                       numericInput("sp_p_pow", #specificity new intervention / experimental
                                                    "Expected specificity for the new test: ",
                                                    value = 0.66,
                                                    min = 0,
                                                    max = 1,
                                                    step = 0.01
                                       ),
                                       bsTooltip(id = "sp_p_pow", 
                                                 title = "The specificity of a test is the rate of true negative test results.",
                                                 trigger = "hover"),
                                       
                                       numericInput("psi_d_p_pow",  #discordant test results diseased 
                                                    "Proportion of discordant test results (diseased)",
                                                    value = 0.15,
                                                    min = 0,
                                                    max = 1,
                                                    step = 0.01),
                                       
                                       bsTooltip(id = "psi_d_p_pow", 
                                                 title = "The proportion of discordant test results is a proportion where the two diagnostic test give differnt results in the diseased population.",
                                                 trigger = "hover"),
                                       
                                       numericInput("psi_nd_p_pow",  # discordant test results non-diseased
                                                    "Proportion of discordant test results (non-diseased)",
                                                    value = 0.2,
                                                    min = 0,
                                                    max = 1,
                                                    step = 0.01),
                                       
                                       bsTooltip(id = "psi_nd_p_pow", 
                                                 title = "The proportion of discordant test results is a proportion where the two diagnostic test give differnt results in the non-diseased population.",
                                                 trigger = "hover"),
                                       numericInput( "drop_p_pow", 
                                                     "Dropout rate: ",
                                                     value = 0,
                                                     min = 0,
                                                     max = 1,
                                                     step = 0.01),
                                       bsTooltip(id = "drop_p_pow",
                                                 title = "The rate of estimated dropouts from the study.",
                                                 trigger = "hover")
                                       
                                       
                                     )# inner bracket conditional panel paired 
                                   )#second level bracket conditional panel comparative 
                                 ),# outer bracket conditional panel endpoint
                                 #sample size ##########################################################################################################################################
                                 conditionalPanel(
                                   condition = "input.endpoint== 'sample_size'",
                                   fluidRow(
                                     column( 8, radioButtons("studydesigns",
                                                             "Please choose a study design",
                                                             choices = c("single-arm trial"= "single", 
                                                                         "comparative trial"= "comparative")),),
                                     column(1, bsButton("designhelp_samplesize","?"))
                                     
                                   ),
                                   # choice between paired and unpaired shows only if comparative is selected
                                   #single-arm trial sample size 
                                   conditionalPanel(
                                     condition ="input.studydesigns =='single'",
                                     numericInput("prev", #prevalence
                                                  "Prevalence:",
                                                  value = 0.5,
                                                  min = 0,
                                                  max = 1,
                                                  step = 0.01),
                                     bsTooltip(id = "prev", 
                                               title = "The prevalence is the proportion of individuals with the target condition.",
                                               trigger = "hover"),
                                     numericInput("power", 
                                                  "Overall power (1-beta):",
                                                  value = 0.8,
                                                  min = 0,
                                                  max = 1,
                                                  step = 0.01),
                                     bsTooltip(id = "power", 
                                               title = "The power is the probability of detecting an existing effect.",
                                               trigger = "hover"),
                                     numericInput("alpha", 
                                                  "Two-sided type-one error (alpha):",
                                                  value = 0.05,
                                                  min = 0,
                                                  max = 1,
                                                  step = 0.01),
                                     bsTooltip(id = "alpha", 
                                               title = "The type-one error is the probability of incorrectly rejecting the null hypothesis.",
                                               trigger = "hover"),
                                     numericInput("se_ni", #sensitivity minimum sensitivity non inferiority
                                                  "Minimum sensitivity:",
                                                  value = 0.75,
                                                  min = 0,
                                                  max = 1,
                                                  step = 0.01),
                                     bsTooltip(id = "se_ni", 
                                               title = "The sensitivity of a test is the rate of true positive test results.",
                                               trigger = "hover"),
                                     numericInput("se", #sensitivity new intervention
                                                  "Expected sensitivity for the new test: ",
                                                  value = 0.81,
                                                  min = 0,
                                                  max = 1,
                                                  step = 0.01),
                                     bsTooltip(id = "se", 
                                               title = "The sensitivity  of the new test is the rate of true positive test results.",
                                               trigger = "hover"),
                                     
                                     numericInput("sp_ni",  #specificity minimum specificity
                                                  "Minimum specificity:",
                                                  value = 0.6,
                                                  min = 0,
                                                  max = 1,
                                                  step = 0.01),
                                     
                                     bsTooltip(id = "sp_ni", 
                                               title = "The specificity of a test is the rate of true negative test results.",
                                               trigger = "hover"),
                                     
                                     numericInput("sp", #specificity new intervention / experimental test
                                                  "Expected specificity for the new test: ",
                                                  value = 0.66,
                                                  min = 0,
                                                  max = 1,
                                                  step = 0.01),
                                     bsTooltip(id = "sp", 
                                               title = "The specificity of the new intervention is the rate of true negative test results.",
                                               trigger = "hover"),
                                     numericInput( "drop_s_n", #dropout single design n-samplesize
                                                 "Dropout rate: ",
                                                 value = 0,
                                                 min = 0,
                                                 max = 1,
                                                 step = 0.01),
                                     bsTooltip(id = "drop_s_n",
                                               title = "The rate of estimated dropouts from the study.",
                                               trigger = "hover")
                                     
                                   ),
                                   #comparative design sample size 
                                   
                                   conditionalPanel(
                                     condition ="input.studydesigns =='comparative'",
                                     fluidRow(
                                       column( 8, radioButtons("designs",
                                                               "Please choose a design",
                                                               choices = c("unpaired design"= "unpaired", "paired design"= "paired")),),
                                       column(1, bsButton("designhelp_comparative","?"))
                                       
                                     ),
                                     #non-inferiotiy------------------------------------------------------------------------------------------------------------------
                                     numericInput("noninf_se",
                                                  "Non-inferiority margin for sensitivity, for superiority hypothesis equal to 0:",
                                                  value = 0, #superiority 
                                                  min = 0, #must be positiv 
                                                  max = 1, #
                                                  step = 0.01
                                     ),
                                     
                                     numericInput("noninf_sp",
                                                  "Non-inferiority margin for specificity, for superiority hypothesis equal to 0:",
                                                  value = 0,
                                                  min = 0,
                                                  max =1,
                                                  step = 0.01),
                                     
                                     # unpaired comparative sample size ----------------------------------------------------------------------------------------------------
                                     conditionalPanel(
                                       condition= "input.designs =='unpaired'",
                                       numericInput("prev_up", #up = unpaired 
                                                    "Prevalence:",
                                                    value = 0.5,
                                                    min = 0,
                                                    max = 1,
                                                    step = 0.01
                                       ),
                                       bsTooltip(id = "prev_up", 
                                                 title = "The prevalence is the proportion of individuals with the target condition.",
                                                 trigger = "hover"),
                                       
                                       numericInput("power_up", 
                                                    "Overall power (1-beta):",
                                                    value = 0.8,
                                                    min = 0,
                                                    max = 1,
                                                    step = 0.01
                                       ),
                                       bsTooltip(id = "power_up", 
                                                 title = "The power is the probability of detecting an existing effect.",
                                                 trigger = "hover"),
                                       
                                       numericInput("alpha_up", 
                                                    "Two-sided type-one error (alpha):",
                                                    value = 0.05,
                                                    min = 0,
                                                    max = 1,
                                                    step = 0.01
                                       ),
                                       bsTooltip(id = "alpha_up", 
                                                 title = "The type-one error is the probability of incorrectly rejecting the null hypothesis.",
                                                 trigger = "hover"
                                       ),
                                       numericInput("se_up", #sensitivity experimental test
                                                    "Expected sensitivity for the new test:",
                                                    value = 0.75,
                                                    min = 0,
                                                    max = 1,
                                                    step = 0.01
                                       ),
                                       bsTooltip(id = "se_up", 
                                                 title = "The sensitivity of a test is the rate of true positive test results.",
                                                 trigger = "hover"
                                       ),
                                       numericInput("se_ni_up", #sensitivity comparator test non inferiority
                                                    "Sensitivity of the comparator test:",
                                                    value = 0.7,
                                                    min = 0,
                                                    max = 1,
                                                    step = 0.01
                                       ),
                                       bsTooltip(id = "se_ni_up", 
                                                 title = "The sensitivity of a test is the rate of true positive test results.",
                                                 trigger = "hover"
                                       ),
                                       numericInput("sp_up", #specificity new experimental test
                                                    "Expected specificity for the new test: ",
                                                    value = 0.66,
                                                    min = 0,
                                                    max = 1,
                                                    step = 0.01
                                       ),
                                       bsTooltip(id = "sp_up", 
                                                 title = "The specificity of a test is the rate of true negative test results.",
                                                 trigger = "hover"),
                                       
                                       numericInput("sp_ni_up",  #specificity comparator test non inferiority
                                                    "Specificity of the comparator test:",
                                                    value = 0.6,
                                                    min = 0,
                                                    max = 1,
                                                    step = 0.01),  
                                       
                                       bsTooltip(id = "sp_ni_up", 
                                                 title = "The specificity of a test is the rate of true negative test results.",
                                                 trigger = "hover"),
                                       numericInput( "drop_up_n", #dropout unpaired design n-samplesize
                                                     "Dropout rate: ",
                                                     value = 0,
                                                     min = 0,
                                                     max = 1,
                                                     step = 0.01),
                                       bsTooltip(id = "drop_up_n",
                                                 title = "The rate of estimated dropouts from the study.",
                                                 trigger = "hover")
                                     ),
                                     # Paired comparative sample size ---------------------------------------------------------------------------------------------------------
                                     conditionalPanel(
                                       condition= "input.designs =='paired'",
                                       numericInput("prev_p",
                                                    "Prevalence:",
                                                    value = 0.5,
                                                    min = 0,
                                                    max = 1,
                                                    step = 0.01
                                       ),
                                       bsTooltip(id = "prev_p", 
                                                 title = "The prevalence is the proportion of individuals with the target condition.",
                                                 trigger = "hover"),
                                       
                                       numericInput("power_p", 
                                                    "Overall power (1-beta):",
                                                    value = 0.8,
                                                    min = 0,
                                                    max = 1,
                                                    step = 0.01
                                       ),
                                       bsTooltip(id = "power_p", 
                                                 title = "The power is the probability of detecting an existing effect.",
                                                 trigger = "hover"),
                                       
                                       numericInput("alpha_p", 
                                                    "Two-sided type-one error (alpha):",
                                                    value = 0.05,
                                                    min = 0,
                                                    max = 1,
                                                    step = 0.01
                                       ),
                                       bsTooltip(id = "alpha_p", 
                                                 title = "The type-one error is the probability of incorrectly rejecting the null hypothesis.",
                                                 trigger = "hover"
                                       ),
                                       numericInput("se_ni_p", #sensitivity comparator test non inferiority
                                                    "Sensitivity of the comparator test:",
                                                    value = 0.75,
                                                    min = 0,
                                                    max = 1,
                                                    step = 0.01
                                       ),
                                       bsTooltip(id = "se_ni_p", 
                                                 title = "The sensitivity of a test is the rate of true positive test results.",
                                                 trigger = "hover"
                                       ),
                                       numericInput("se_p", #sensitivity new intervention
                                                    "Expected sensitivity for the new test: ",
                                                    value = 0.8,
                                                    min = 0,
                                                    max = 1,
                                                    step = 0.01
                                       ),
                                       bsTooltip(id = "se_p", 
                                                 title = "The sensitivity of a test is the rate of true positive test results.",
                                                 trigger = "hover"
                                       ),
                                       numericInput("sp_ni_p",  #specificity comparator test / reference standard non inferiority
                                                    "Specificity for the comparator test:",
                                                    value = 0.6,
                                                    min = 0,
                                                    max = 1,
                                                    step = 0.01),
                                       
                                       bsTooltip(id = "sp_ni_p", 
                                                 title = "The specificity of a test is the rate of true negative test results.",
                                                 trigger = "hover"),
                                       
                                       numericInput("sp_p", #specificity new intervention / experimental
                                                    "Expected specificity for the new test: ",
                                                    value = 0.66,
                                                    min = 0,
                                                    max = 1,
                                                    step = 0.01
                                       ),
                                       bsTooltip(id = "sp_p", 
                                                 title = "The specificity of a test is the rate of true negative test results.",
                                                 trigger = "hover"),
                                       
                                       numericInput("psi_d_p",  #discordant test results diseased
                                                    "Proportion of discordant test results (diseased)",
                                                    value = 0.15,
                                                    min = 0,
                                                    max = 1,
                                                    step = 0.01),
                                       
                                       bsTooltip(id = "psi_d_p", 
                                                 title = "The proportion of discordant test results is a proportion where the two diagnostic test give differnt results in the diseased population.",
                                                 trigger = "hover"),
                                       
                                       numericInput("psi_nd_p",  #discordant non-diseased
                                                    "Proportion of discordant test results (non-diseased)",
                                                    value = 0.2,
                                                    min = 0,
                                                    max = 1,
                                                    step = 0.01),
                                       
                                       bsTooltip(id = "psi_nd_p", 
                                                 title = "he proportion of discordant test results is a proportion where the two diagnostic test give differnt results in the non-diseased population.",
                                                 trigger = "hover"),
                                       numericInput( "drop_p_n", #dropout unpaired design n-samplesize
                                                     "Dropout rate: ",
                                                     value = 0,
                                                     min = 0,
                                                     max = 1,
                                                     step = 0.01),
                                       bsTooltip(id = "drop_p_n",
                                                 title = "The rate of estimated dropouts from the study.",
                                                 trigger = "hover")
                                       
                                     )#conditional panel bracket- paired
                                   ) #conditional panel bracket -comparative 
                                 ) #outer bracket conditonal panel endpoint-sample size
                ),# dashboard sidebar bracket
                 #Right side - output###########################################################################
                
                # Power- Results--------------------------------------------------------------------------------------------------
                dashboardBody(
                  tabsetPanel( #Tabs for results and documentation
                    tabPanel("Results",
                             conditionalPanel(
                               condition= "input.endpoint =='power'",
                               #single
                               conditionalPanel(
                                 condition = "input.studydesigns_p =='single_p'",
                                 verbatimTextOutput("power_single"),#Calculation results
                                 htmlOutput("singlepowerresult" ),# Results in text
                                 DT::DTOutput("singlepowtable"),
                                 htmlOutput("singleexact")# Informations about paper with url
                               ),
                               #comparative
                               conditionalPanel(
                                 condition = "input.studydesigns_p =='comparative_p'",
                                 conditionalPanel(
                                   #paired
                                   condition = "input.designs_p =='paired_p'",
                                   verbatimTextOutput("power_paired"),#Calculation results
                                   htmlOutput("pairedpower"), # Results in text
                                   DT::DTOutput("pairedpowtable"),
                                   htmlOutput("compow") # Informations about paper with url
                                 ),
                                 #unpaired
                                 conditionalPanel(
                                   condition = "input.designs_p =='unpaired_p'",
                                   verbatimTextOutput("power_unpaired"),#calculation results
                                   htmlOutput("unpairedpower"),# Results in text
                                   DT::DTOutput("unpairedpowtable"),
                                   htmlOutput("compow1"), # Informations about paper with url
                                 )
                               )
                             ),
                             #Sample size-----------------------------------------------------------------------------------------------
                             #single
                             conditionalPanel(
                               condition = "input.endpoint =='sample_size'",
                               conditionalPanel(
                                 condition ="input.studydesigns =='single'",
                                 verbatimTextOutput("exact"), #calculation results
                                 htmlOutput("singleresult"), # Results in text
                                 DT::DTOutput("singletable"),
                                 htmlOutput("singlearmtxt") #Informations about paper with url
                               ),
                               #comparative
                               conditionalPanel(
                                 condition = "input.studydesigns =='comparative'",
                                 conditionalPanel(
                                   #paired
                                   condition= "input.designs =='paired'",
                                   verbatimTextOutput("paired"), #calculation results
                                   htmlOutput("comp_presult"),# Results in text
                                   DT::DTOutput("pairedtable"),
                                   htmlOutput("comptxt") #Informations about paper with url
                                 ),
                                 #unpaired
                                 conditionalPanel(
                                   condition = "input.designs =='unpaired'",
                                   verbatimTextOutput("unpaired"),  #calculation results
                                   htmlOutput("comp_upresult"),# Results in text
                                   DT::DTOutput("unpairedtable"),
                                   htmlOutput("comptxt2"), #Informations about paper with url (needed other variable name otherwise error, same text as comptxt)
                                 )# conditional panel bracket unpaired
                               )#conditional pannel bracket comparative
                             )#conditional panel bracket sample-size
                    ),#tabpanel
                    tabPanel("Documentation",
                             fluidPage(
                               tags$head(
                                 tags$style(HTML(  # CSS code to style of the table 
                                   ".table-scroll{
                                   overflow-x:auto;
                                   width:100%;
                                   }
                                  table {
                                   border-collapse:collapse;
                                   width: 100%;
                                   }
                                    table th,td  {
                                   border: 1px solid black;
                                   padding: 6px;
                                   }
                                   "))
                               ),
                               withMathJax(), #for latex in markdown
                               includeMarkdown("documentation.md")
                             )#fluidpage
                    )# tabpanel
                  )#tabsetPanel
                )#dashboard body
  ), #dashboardpage

  #footer mit Logo
  tags$footer(
    div(style = "text-align: center; padding: 10px; background-color:#f8f9fa;", "2025 DiagnostySize funded by DFG project number 333052698",tags$a(href='https://www.dfg.de/de',
      tags$img(src="dfg_logo.png", height="30px",width = "150px", alt= "something went wrong, here would be the dfg logo",deleteFile =FALSE)))
  )#footer bracket

) #ui fluid page