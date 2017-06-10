tmp <- read.table("tmp.code")
check <- tolower(as.character(tmp[1,1]))
company <- read.csv("selcompany.csv", header = TRUE)
bycode <- company[gsub(" ", "", tolower(as.character(company$code))) == check,]
write.csv(bycode, "bycode.csv")
