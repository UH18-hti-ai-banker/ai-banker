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