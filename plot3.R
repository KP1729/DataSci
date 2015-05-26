# Plot-3
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

## subset data for Baltimore city : fips=="24510"
NEI3 <- filter(NEI2, fips == "24510")

## creating a grouped data frame table by year
by_NEI <- group_by(NEI3, year, type)

## Summarizing the total emissions by year by type
sum_NEI <- summarize(by_NEI,sum_emissions=sum(Emissions))

## Plotting
library(ggplot2)
png("./course_asgn2/plot3.png")


p <- ggplot(sum_NEI, aes(x=year, y= sum_emissions, group=type))

## Adding line + points + title + clear background
p + geom_line(aes(colour=type)) + geom_point() + xlab("Year") + ylab("Total Emissions") +
        ggtitle("Emissions by type by year for Baltimore") + theme_bw()

dev.off()



