## Quiz 1 - Q1

fileURL0 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileURL0, destfile="./Idaho.csv")
dat <- read.csv("./Idaho.csv", header=TRUE)
names(dat)
table(dat$VAL)

# Factor 24 (>1000000) appears 53 times

## Quiz 1 - Q2

#two columns of data in a single variable


## Quiz 1 - Q3

library("xlsx")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile="./getdata-data-DATA.gov_NGAP.xlsx", method="auto", mode="wb")

dat <- read.xlsx("./getdata-data-DATA.gov_NGAP.xlsx", sheetIndex=1, startRow=18, header=TRUE, 
                 endRow=23, colIndex=7:15)
sum(dat$Zip*dat$Ext,na.rm=T)

## Quiz 1 - Q4
library("XML")
fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(fileUrl2, destfile = "./BaltimoreRestaurants.xml", method="auto", mode="wb")
doc <- xmlTreeParse("./BaltimoreRestaurants.xml", useInternal = TRUE)
test <- sapply(getNodeSet(doc,"//zipcode"), xmlValue)
table(test)

### Alternate
rootNode <- xmlRoot(doc)
table(xpathSApply(rootNode, "//zipcode", xmlValue))


## Quiz 1 - Q5

library("data.table")
fileURL5 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileURL5, destfile="./getdata-data-ss06pid.csv")
DT <- fread("./getdata-data-ss06pid.csv", sep=",")

#The other functions do not get the required output/too slow
system.time(replicate(1000, tapply(DT$pwgtp15,DT$SEX, mean)))
system.time(replicate(1000, sapply(split(DT$pwgtp15,DT$SEX),mean)))
