# Exploratory Data Analysis
# Project 2
# Plot 1

# Libraries used in this plot 
library("plyr")

# set directory and Load data
# Download the Data for Peer Assessment [29Mb] file from 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
# The zip file contains two files. Extract them to ~/R/Coursera/ExploratoryAnalysis/Project2 
setwd("~/R/Coursera/ExploratoryAnalysis/Project2")
NEI = readRDS("summarySCC_PM25.rds")
SCC = readRDS("Source_Classification_Code.rds")

# Transform NEI by using year as a factor variable
NEItr = transform(NEI, year = factor(year))

# Generate plot1 and save it as a png file
plotNEI = ddply(NEItr, .(year), summarize, sum = sum(Emissions))
png("plot1.png")
plot(plotNEI$year, plotNEI$sum, type="n", xlab = "year", ylab = "Total PM2.5 Emission", boxwex = 0.05)
lines(plotNEI$year, plotNEI$sum)
dev.off()
# Make sure developement enviornment is closed