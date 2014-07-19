# Exploratory Data Analysis
# Project 2
# Plot 2

# Libraries used in this plot 
library("plyr")

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

# Generate plot2 and save it as a png file
plotNEI = ddply(NEIfips, .(year), summarize, sum = sum(Emissions))
png("plot2.png")
plot(plotNEI$year, plotNEI$sum, type = "n", xlab = "year", 
     ylab = "Total PM2.5 Emission",
     main = "PM2.5 emission in Baltimore City", boxwex = 0.05)
lines(plotNEI$year, plotNEI$sum)
dev.off()
# Make sure developement enviornment is closed