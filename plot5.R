# Exploratory Data Analysis
# Project 2
# Plot 5

# Libraries used in this plot 
library("plyr")
library("ggplot2")

# set directory and Load data
# Download the Data for Peer Assessment [29Mb] file from 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
# The zip file contains two files. Extract them to ~/R/Coursera/ExploratoryAnalysis/Project2 
setwd("~/R/Coursera/ExploratoryAnalysis/Project2")
NEI = readRDS("summarySCC_PM25.rds")
SCC = readRDS("Source_Classification_Code.rds")

# Transform NEI by using year as a factor variable and load SCC data frame  
NEItr = transform(NEI, type=factor(type), year = factor(year))
# Total emissions from PM2.5 in the Baltimore City, Maryland (fips == 24510) from 1999 to 2008
NEIfips = NEItr[NEItr$fips == "24510",]
vehicles = as.data.frame(SCC[grep("vehicles", SCC$SCC.Level.Two, ignore.case = T), 1])
names(vehicles) = "SCC"
datamerge = merge(vehicles, NEIfips, by = "SCC")

# Generate plot5 and save it as a png file
plotmerge = ddply(datamerge, .(year), summarize, sum = sum(Emissions))
png("plot5.png")
ggplotmerge = ggplot(plotmerge, aes(year, sum))
ggplotmerge + geom_point(size = 4) + 
  labs(title = "PM2.5 Emission from motor vehicle sources in Baltimore City",
                              y = "Total PM2.5 emission each year")
dev.off()
# Make sure developement enviornment is closed