## Quiz 2 - q1



# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
# Need packages Rcpp & HTTPUV

library(httr)
oauth_endpoints("github")

# 2. Register an application at https://github.com/settings/applications;
#    Use any URL you would like for the homepage URL (http://github.com is fine)
#    and http://localhost:1410 as the callback url
#
#    Insert your client ID and secret below - if secret is omitted, it will
#    look it up in the GITHUB_CONSUMER_SECRET environmental variable.

myapp <- oauth_app("github", key="3b1f96d85737b4daac8f", secret="e3bb52ec3c4ea70db4b7964a24d1f5bea82b0436")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)

req <- GET("https://api.github.com/users/jtleek/repos", gtoken)

library(jsonlite)
drepo <- fromJSON(toJSON(content(req)))
names(drepo)
drepo[drepo$name == "datasharing",]$created_at

## Quiz 2 - q2 & q3

# Basic SQL code - no need to download the file


## Quiz 2 - q4 
jph <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(jph)
nchar(htmlCode[c(10,20,30,100)])
close(jph)


## Quiz 2 - q5
setInternet2(TRUE)
download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for", destfile="./cpc.for")
cpc <- read.fwf(file="./cpc.for",widths=c(15,4,9,4,9,4,9,4,9),skip=4)
sum(cpc[,4])



