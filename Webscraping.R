library(rvest)
library(data.table)
library(stringr)
library(readtext)

file_dir <- "H:/Techstrat/Projects/Created/Music web scraping"

#Get the list of year hit pages
yearpages.dt <- pages_per_year("https://sacharts.wordpress.com")

#Get the list of weekly hit pages
weekpages.dt <- data.table(hit_year=character(),week=character(),page=character())
for (row in 1:nrow(yearpages.dt)){
  l = list(weekpages.dt,pages_per_week(yearpages.dt[row]$year,yearpages.dt[row]$page))
  weekpages.dt <- rbindlist(l,use.names=TRUE)
}
rm(l)

#Get the weekly hits
weeklyhits.dt <- data.table(Pos=numeric(), LW=numeric(), Weeks=numeric(),
                            Song=character(), Artist=character(), 
                            hit_week=rep(as.Date(Sys.time(),format="%d %B %Y"),0))
for (row in 1:nrow(weekpages.dt)){
  print(weekpages.dt[row]$week)
  week_date <- as.Date(weekpages.dt[row]$week,format="%d %B %Y")
  l = list(weeklyhits.dt,hits_per_week(week_date,weekpages.dt[row]$page))
  weeklyhits.dt <- rbindlist(l,use.names=FALSE)
}
rm(l)

#Save to file
writeTofile(weeklyhits.dt,"weeklyhits.csv",file_dir)
#Read from file
weeklyhits.dt <- readTextFile("weeklyhits.csv",file_dir)


### Test
#no headers
week_url <- "https://sacharts.wordpress.com/2016/02/14/8-august-1969-2/"
dt <- hits_per_week("1969","8-august-1969",week_url)
#with headers
week_url <- "https://sacharts.wordpress.com/2016/02/12/1-august-1969-2/"
dt <- hits_per_week("1969","1-august-1969",week_url)
#with extra columns
week_url <- "https://sacharts.wordpress.com/2018/04/02/3-december-1976/"
dt <- hits_per_week("1976","3-december-1976",week_url)
