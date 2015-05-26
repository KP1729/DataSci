# Plot-4
## Check for existence of at least one RDS file to skip the download & unzip steps

if (!file.exists("./summarySCC_PM25.rds")) {
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(fileURL, destfile="./exdata-NEI_data.zip")
        unzip("./exdata-NEI_data.zip")
}

## reading in PM2.5 Emissions Data
NEI <- readRDS("./summarySCC_PM25.rds")

library(dplyr)
NEI2 <-tbl_df(NEI)

## reading in Source Classification Code data
SCC <- readRDS("./Source_Classification_Code.rds")

## looking for 'coal' phrase in SCC dataset in EI.Sector column
SCC_coal <- as.vector(SCC[grepl("coal", SCC$EI.Sector, ignore.case = TRUE),1])

## Subset for source code classifications associated with 'coal' phrase
Coal_emissions <- filter(NEI2, NEI2$SCC %in% SCC_coal)
## creating a grouped data frame table by year
Coal_year <- group_by(Coal_emissions, year)

## Summarizing the total emissions by year for Coal
Coal_sum <- summarize(Coal_year, sum_year= sum(Emissions))

## Plotting
library(ggplot2)
png("./course_asgn2/plot4.png")

p <- ggplot(Coal_sum, aes(x=year, y= sum_year))

## Adding line + points + title + clear background
p + geom_line() + geom_point() + xlab("Year") + ylab("Total Emissions (tons)") +
        ggtitle("Emissions from coal combustion-related sources") + theme_bw()

dev.off()
