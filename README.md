# ai-banker

## Setup project environment

Create environmental variable file for R and add your real API details.

    $ cp .Renviron.example .Renviron
    
If you have RStudio open with the project, restart it.

To verify working API details, check variable in R console:

    > Sys.getenv("OP_API_KEY")

## Install requirements

Packrat will handle the dependencies. To install packrat:

    > install.packages("packrat")
    
After that check the status and it will tell if need to restore.

    > packrat::status()
    > packrat::restore() # only if not up-to-date
    
## What to put where

Project follows combination of shiny and basic R library structure.

    | app.R = shiny application, this is what makes app "tick"
    |-> R = this is where most of the R code belongs
    |-> modules = place custom shiny modules here, these are the ways to show info in shiny app
    |-> layout = HTML-templates are located here
    |-> www = this is exposed in web, so static pictures, css- and js-files
    |-> data = all your data belongs to us

## Deployment

This is for shinyapps.io only in mind.

Create account on the site and follow getting started section with step 1 and step 2.

To deploy app you just need to load rsconnect library and deploy it:

    > source("deploy.R")
    
After that you can just run the ```rsconnect::deployApp()``` line in same session to deploy.
