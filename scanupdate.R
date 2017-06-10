fwgorig <- read.csv("company_database.csv", header = TRUE)
fwgorig[,"date"] <- as.Date(fwgorig[,"date"])
fwgorig[,"code"] <- as.character(fwgorig[,"code"])
fwg <- fwgorig
newinvoice <- read.csv("invoice.csv", header = TRUE)
newinvoice <- newinvoice[,-c(1,4,6)]
stylenames <- unlist(newinvoice[,"style"])
newinvoice[,"style"] <- tolower(newinvoice[,"style"])
newinvoice[,"style"] <- gsub(" ", "", (newinvoice[,"style"]))
newinvoice[,"code"] <- tolower(newinvoice[,"code"])
newinvoice[,"code"] <- gsub(" ", "", (newinvoice[,"code"]))
newinvoice[,"code"] <- as.character(newinvoice[,"code"])
fwg[,"code"] <- tolower(fwg[,"code"])
fwg[,"code"] <- gsub(" ", "", (fwg[,"code"]))
fwg[,"style"] <- gsub(" ", "", (fwg[,"style"]))
fwg[,"style"] <- tolower(fwg[,"style"])
company <- as.character(read.csv("company.csv")[1,1])

for (k in c("code", "style")) {
    for (i in 1:dim(newinvoice)[1]) {
        tmp.code <- as.character(newinvoice[i,k])
        if (tmp.code %in% fwg[,k]) {
            fwg.code <- fwg[fwg[,k] %in% tmp.code,]
            fwg.code <- fwg.code[,-c(1,5)]
            if (dim(fwg.code)[1] > 1) {
                fwg.code[,"match"] <- rep(NA)
                for (j in 1:dim(fwg.code)[1]) {
                    fwg.code[j,"match"] <- ifelse(all(fwg.code[j,c(1:3)] == newinvoice[i,]), TRUE, FALSE)
                }
                    fwg.code[,"match"] <- as.logical(fwg.code[,"match"])
                    if (sum(fwg.code[,"match"]) == 0) {
                        fwgnewline <- data.frame("company" = company)
                        fwgnewline[,"code"] <- newinvoice[i,"code"] 
                        fwgnewline[,"style"] <- stylenames[i]
                        fwgnewline[,"price"] <- newinvoice[i, "price"]
                        fwgnewline[,"date"]  <- Sys.Date() 
                        fwgorig <- rbind(fwgorig, fwgnewline)
                        rm(fwgnewline)
                    }
            } else {
                if (all(fwg.code != newinvoice[i,]) == TRUE) {
                    fwgnewline <- data.frame("company" = company)
                    fwgnewline[,"code"] <- newinvoice[i,"code"] 
                    fwgnewline[,"style"] <- stylenames[i]
                    fwgnewline[,"price"] <- newinvoice[i, "price"]
                    fwgnewline[,"date"]  <- Sys.Date() 
                    fwgorig <- rbind(fwgorig, fwgnewline)
                    rm(fwgnewline)
                }
            }
        } else {
	    fwgnewline <- data.frame("company" = company)
	    fwgnewline[,"code"] <- newinvoice[i,"code"] 
	    fwgnewline[,"style"] <- stylenames[i]
	    fwgnewline[,"price"] <- newinvoice[i, "price"]
	    fwgnewline[,"date"]  <- Sys.Date() 
	    fwgorig <- rbind(fwgorig, fwgnewline)
	    rm(fwgnewline)
	  }
    }
}
fwgorig <- unique(fwgorig)
write.csv(fwgorig, "company_database.csv", row.names = FALSE)
