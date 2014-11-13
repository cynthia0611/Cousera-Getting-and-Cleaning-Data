# Question 1
library(httr)
# 1. Find OAuth settings for github:
# http://developer.github.com/v3/oauth/
# if you register your own application on Github and got Client ID and Client Secret already,
# it's fine to skip this step to find OAth
oauth_endpoints("github")

# 2. Register an application at https://github.com/settings/applications;
# Use any URL you would like for the homepage URL (http://github.com is fine)
# and http://localhost:1410 as the callback url

# Insert your client ID and secret below - if secret is omitted, it will
# look it up in the GITHUB_CONSUMER_SECRET environmental variable.
# it means here it should set 3 parameters
myapp <- oauth_app("github", "your Client ID on your Github application page","Client Secret")

# 3. Get OAuth credentials
# if here pop up error, maybe it needed to import more package into R
# look at the error message
# it should looks like this:
#Use a local file to cache OAuth access credentials between R sessions?
#1: Yes
#2: No

#Selection: 1
#Adding .httr-oauth to .gitignore
#Waiting for authentication in browser...
#Press Esc/Ctrl + C to abort
#Authentication complete.
#github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
# get the repo weblink: https://api.github.com/users/jtleek/repos using token
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
content(req)

# get answer:
# [[30]]$created_at
# [1] "2013-12-30T17:43:29Z"

# OR:
req <- with_config(gtoken, GET("https://api.github.com/rate_limit"))
stop_for_status(req)
content(req)
