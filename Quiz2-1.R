library(httr)
oauth_endpoints("github")

DataScience <- oauth_app("github", key="3b1f96d85737b4daac8f", secret="e3bb52ec3c4ea70db4b7964a24d1f5bea82b0436")
github_token <- oauth2.0_token(oauth_endpoints("github"), DataScience)
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)

library(jsonlite)
drepo <- fromJSON(toJSON(content(req)))
names(drepo)
drepo[drepo$name == "datasharing",]$created_at