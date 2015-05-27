# Plot-5
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

## subset data for Baltimore city : fips=="24510"
NEI3 <- filter(NEI2, fips == "24510")

## reading in Source Classification Code data
SCC <- readRDS("./Source_Classification_Code.rds")

## looking for 'motor vehicle related' phrase in SCC dataset in EI.Sector column
SCC_motor <- as.vector(SCC[grepl("vehicle", SCC$EI.Sector, ignore.case = TRUE),1])

## Subset for source code classifications associated with 'motor vehicle related' phrase
motor_emissions <- filter(NEI3, NEI3$SCC %in% SCC_motor)

## creating a grouped data frame table by year
motor_year <- group_by(motor_emissions, year)

## Summarizing the total emissions by year for Coal
motor_sum <- summarize(motor_year, sum_year= sum(Emissions))

## Plotting
library(ggplot2)
png("./course_asgn2/plot5.png")

p <- ggplot(motor_sum, aes(x=year, y= sum_year))

## Adding line + points + title + clear background
p + geom_line() + geom_point() + xlab("Year") + ylab("Total Motor Emissions (tons)") +
        ggtitle("Emissions from motor vehicle sources in Baltimore") + theme_bw()

dev.off()
