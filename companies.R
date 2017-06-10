database <- read.csv("company_database.csv")
companies <- as.data.frame(unique(database$company))
names(companies)[1] <- "companies"
write.csv(companies, "companies.csv", row.names = FALSE)
