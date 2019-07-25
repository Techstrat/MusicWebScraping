pages_per_year <- function(master_url) {
  #Get years and their respective pages and save to year_and_page data.table
  sacharts_webpage <- read_html(master_url) 
  year_page_html <- html_nodes(sacharts_webpage, ".menu-item-object-page")
  year_page_href <- html_attr(html_children(year_page_html),"href")
  year_page_href <- year_page_href[!is.na(year_page_href)]
  year_page <- html_text(year_page_html)
  year_and_page <- data.table(year = year_page,page = year_page_href)
  year_and_page <- year_and_page[nchar(year_and_page$year)==4]
  n <- nrow(year_and_page)/2 
  year_and_page <- year_and_page[1:n]
  return(year_and_page)
}

pages_per_week <- function(hit_year, year_url){
  #Get weeks and their respective pages and save to year_and_page data.table  
  sacharts_webpage <- read_html(year_url)
  year_page_html <- html_nodes(sacharts_webpage, ".listing-item")
  year_page_href <- html_attr(html_children(year_page_html),"href")
  year_page <- html_text(year_page_html)
  
  year_week_and_page <- data.table(hit_year = hit_year, week = year_page,page = year_page_href)
  year_week_and_page <- year_week_and_page[str_sub(year_week_and_page$week,start=-4)==hit_year]
  return (year_week_and_page)
}
 
hits_per_week <- function(hit_week, week_url){
  #Get hits for the week
  #weeklyhits.dt <- data.table(Pos=numeric(20), LW=numeric(20), Weeks=numeric(20),Song=character(20), Artist=character(20), hit_week=rep(Sys.time(),20))
  
  webpage <- read_html(week_url)
  table_html <- html_nodes(webpage, "table")
  hit_table <- as.data.table(html_table(table_html))
  if(hit_table[1,1]=="Pos"){hit_table <- hit_table[-1,] } #different tables come with/without header
  hit_table <- hit_table[,.SD,.SDcols = c(1,2,3,4,6)] #some weeks have more columns, only select the ones needed
  hit_table <- hit_table[,hit_week := as.Date(hit_week)]
  return(hit_table)
}
 
#Write to file
writeTofile <- function(write_object,write_file,file_dir) {
  wd <- getwd()
  setwd(file_dir)
  con2 <- file(write_file, "wb")   
  write.csv(write_object,con2)
  close(con2)
  setwd(wd)
}

#Write to file - no row name
writeTofileNoRN <- function(write_object,write_file,file_dir) {
  wd <- getwd()
  setwd(file_dir)
  con2 <- file(write_file, "wb")   
  write.csv(write_object,con2, row.names = FALSE)
  close(con2)
  setwd(wd)
} 

#Read a file from file_dir and return a data frame
readTextFile <- function(file_name,file_dir) {
  wd <- getwd()
  setwd(file_dir)
  textStr <- readtext(file_name, encoding = "utf-8") 
  setwd(wd)
  return(textStr)
}

#Read a file from file_dir and return a data.table
readDataTable <- function(file_name,file_dir) {
  wd <- getwd()
  setwd(file_dir)
  text.dt <- as.data.table(readtext(file_name, encoding = "utf-8"))
  setwd(wd)
  return(text.dt)
} 