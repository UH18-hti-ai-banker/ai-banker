# ai-banker

## Setup project environment

Create environmental variable file for R and add your real API details.

    cp .Renviron.example .Renviron
    
If you have RStudio open with the project, restart it.

To verify working API details, check variable in R console:

    Sys.getenv("OP_API_TOKEN")

## Install requirements

In R console:

    install.packages("shiny")
    
## Deployment

This is for shinyapps.io only in mind.

Create account on the site and follow getting started section with step 1 and step 2.

To deploy app you just need to load rsconnect library and deploy it:

    library(rsconnect)
    rsconnect::deployApp()
    
After that you can just run the ```rsconnect::deployApp()``` line in same session to deploy.