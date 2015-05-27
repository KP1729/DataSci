## Quiz -3
### Already downloaded file as part of QZ-1
q1 <- read.csv(file = "./Idaho.csv")
agricultureLocal <- q1$ACR == 3 & q1$AGS == 6
which(agricultureLocal == TRUE)

## QZ3 - q2

jeff <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(jeff, destfile = "./jeff.jpg")
test <- readJPEG("./jeff.jpg", native=TRUE)
quantile(test, probs= c(0.3, 0.8))

## q3

gdp <- fread("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
                skip=5, select=c(1,2,4,5), colClasses="character")
gdp2 <- filter(gdp, V2>0 & V1>0)
edstats <- fread("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv")

setnames(gdp2,"V1", "CountryCode")
mg1 <- merge(gdp2, edstats, by="CountryCode", all=FALSE)
dim(mg1)
mg2 <- mg1 %>% mutate(rank=as.numeric(V2)) %>% arrange(desc(rank)) %>% select(CountryCode, V4, rank)
head(mg2,13)


## q-4 continuation from above

setnames(mg1,"Income Group", "IG")
m1 <- select(mg1, V2, IG)
m11 <- filter(m1, IG == "High income: OECD")
m21 <- filter(m1, IG == "High income: nonOECD")
summarize(m11, mean(as.numeric(V2)))
summarize(m21, mean(as.numeric(V2)))


## q-5 - contd.

filter(m1, as.numeric(V2) <=38 & IG == "Lower middle income")




