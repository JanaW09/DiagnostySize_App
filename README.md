# DiagnostySize Shiny app for optimal sample size calculation for diagnostic accuracy studies

The optimal sample size approach ensures that no endpoint (sensitivity or specificity) is overpowered. This approach was until now just available via R-scripts. This apps allows the use of the optimal sample size and power calculation with an user interface. In the shiny App you find additionally help buttons, error messages, further information and the link to the paper from Stark & Zapf, 2020 and Stark et al., 2022, who developed the statistical methods.

# Installation:

Download the repository and open the **.Rproj** file in R-Studio. Open the **app.R** file and install all packages listed there, with the command: **install.packages("name")**. Than click "Run App" or enter the command: **shiny::runApp()** in the console.
### Install packages (R-code):
Copy and paste the following code to your consol in R-Studio:

install.packages("shiny")<br>
install.packages("shinydashboard")<br>
install.packages("shinyBS")<br>
install.packeges("markdown")<br>
install.packages("DT")

### Example from Paper
Download the repository, install the packages, and run the app.
First choose single-arm trial and sample size, than enter the following values: <br>
prevalence: 0.38 <br>
power: 0.8 <br>
alpha: 0.05 <br>
minimum sensitivity: 0.8 <br>
expected sensitivity new test: 0.85 <br>
minimum specificity: 0.7 <br>
expected specificity new test: 0.75 <br>
dropout rate: 0.1 <br>

(Note, that the decimal delimiter appearance depends on your browser language settings (englisch= ".""; german= ","))
## Contributors:

**Jana Wiesner** - University Medical Center Hamburg-Eppendorf (UKE) & University of Applied Sciences and Arts Hannover


### References:

Stark M, Zapf A (2020). “Sample size calculation and re-estimation based on the prevalence in a single-arm confirmatory diagnostic accuracy study.” Statistical Methods in Medical Research, 29(10), 2958–2971. <doi:10.1177/0962280220913588>

Stark M, Hesse M, Brannath W, Zapf A (2022). “Blinded sample size re-estimation in a comparative diagnostic accuracy study.” BMC Medical Research Methodology, 22(1), 115. <doi:10.1186/s12874-022-01564-2>.
