# Exploratory Data Analysis
# Project 2
# Plot 4

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
combustion = as.data.frame(SCC[grep("combustion", SCC$SCC.Level.One, ignore.case = T) & 
                                grep("coal", SCC$SCC.Level.Three,ignore.case = T), 1])
names(combustion) = "SCC"
dataSCC = merge(combustion, NEItr, by = "SCC")

# Generate plot4 and save it as a png file
plotSCC = ddply(dataSCC, .(year), summarize, sum = sum(Emissions))
png("plot4.png")
ggplotSCC = ggplot(plotSCC, aes(year,sum))
ggplotSCC + geom_point(size = 4) + labs(title = "PM2.5 Emission from coal combustion-related sources",
                              y = "Total PM2.5 emission each year")
dev.off()
# Make sure developement enviornment is closed
