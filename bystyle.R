tmp <- read.table("tmp.style")
check <- tolower(as.character(tmp[1,1]))
company <- read.csv("selcompany.csv", header = TRUE)
bystyle <- company[gsub(" ", "", tolower(as.character(company$style))) == check,]
write.csv(bystyle, "bystyle.csv")
