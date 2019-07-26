# MusicWebScraping
Using R code this repository Scrapes the top 20 SA singles hits data from and SA Charts web site
 * The code refers to the master page ("https://sacharts.wordpress.com") and scrape the list of pages per year
 * Referring to each year page in the list it scrapes the list of pages per week.
 * Referring to each week pages it scrapes the top 20 list for that week.
 * the list of hits is written to the csv file weeklyhits.csv
 * the contents of the csv file is later used in a dynamic graphical presentation of the changing hit parade.
 
 The R code uses the following libraries
 * rvest to do the web scraping
 * data.table to manipulate the data in a data.table
 * stringr to manipulate the strings
 * readtext to write the data to the csv file

See the repository MusicHitsAnimated for an animated graph of the hit parade.
