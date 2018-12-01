###############################################################
### Creates a new .Renviron file to the specified directory ###
###############################################################

wd <- "WORKING_DIRECTORY"
key <- "KEY"
token <- "TOKEN"

#NOTES: 
#(I) Enviromental variables in the new .Renviron are always loaded in the startup if the WORKING_DIRECTORY 
#    is the one specified in .Rprofile
#(II) If not, then they can be loaded in Rstudio after running this file and choosing: Session -> New Session

setwd(wd)
user_renviron = path.expand(file.path(getwd(), ".Renviron"))
if(!file.exists(user_renviron)) {
  file.create(user_renviron)
} # check to see if the file already exists
writeLines(c(paste0("OP_API_KEY=", key), paste0("OP_API_TOKEN=", token)), con = ".Renviron")
testline13
