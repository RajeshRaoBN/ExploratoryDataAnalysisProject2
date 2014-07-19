# Exploratory Data Analysis
# Project 2
# Plot 3

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

# Transform NEI by using year as a factor variable and fips 
NEItr = transform(NEI, year = factor(year))
# Total emissions from PM2.5 in the Baltimore City, Maryland (fips == 24510) from 1999 to 2008
NEIfips = NEItr[NEItr$fips == "24510",]

# Generate plot3 and save it as a png file
plotNEI = ddply(NEIfips, .(year, type), summarize, sum = sum(Emissions))
png("plot3.png")
ggplotNEI = ggplot(plotNEI, aes(year, sum))
ggplotNEI + geom_point() + facet_grid(. ~ type) + 
  labs(title = "PM2.5 Emission in Baltimore city", 
       y = "Total PM2.5 emission each year")
dev.off()
# Make sure developement enviornment is closed