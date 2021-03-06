# Plot-1
## Check for existence of at least one RDS file to skip the download & unzip steps

if (!file.exists("./summarySCC_PM25.rds")) {
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(fileURL, destfile="./exdata-NEI_data.zip")
        unzip("./exdata-NEI_data.zip")
}

## reading in PM2.5 Emissions Data
NEI <- readRDS("./summarySCC_PM25.rds")

## Loading dplyr library
library(dplyr)

## load data into data frame table
NEI2 <- tbl_df(NEI)
## creating a grouped data frame table by year
by_NEI <- group_by(NEI2, year)
## Summarizing the total emissions by year
sum_NEI <- summarize(by_NEI,sum_emissions=sum(Emissions))

## Plotting
png("./course_asgn2/plot1.png")

## using a barplot to check if total emissions display a pattern over the years

barplot(sum_NEI$sum_emissions, 
ylab = "Emissions (tons)",
xlab= "Year", 
main = "Total Emissions by year", 
names.arg= c("1999","2002","2005", "2008"),
cex.axis=0.8,
col="red")

dev.off()
