# Symbolic Data Analysis (SDA) Workshop 2025
# June 9–11, 2025, Varaždin, Croatia
# ------------------------------------------------------------------
# https://github.com/bavla/symData/tree/master/format
# https://github.com/bavla/symData/tree/master/Billard-Diday
#

> wdir <- "C:/Users/vlado/docs/papers/2025/SDA/test"
> setwd(wdir)
> library(jsonlite); library(data.table); library(httr)

# First attempt
# https://raw.githubusercontent.com/bavla/symData/refs/heads/master/Billard-Diday/Joggers.json
> path <- paste0("https://raw.githubusercontent.com/bavla/symData/",
+   "refs/heads/master/Billard-Diday/") 
> J2 <- fromJSON(paste0(path,"Joggers2.json"))
> # J2 <- fromJSON("Joggers2.json")
> names(J2)

> X <- as.data.frame(t(rbind(J2$units$Y1)))
> X$V1[[3]]
[1] 69 91

> Z <- as.data.frame(t(rbind(J2$units$Y2)))
> tra <- function(ZZ){MM <- matrix(unlist(ZZ),byrow=TRUE,ncol=3)
+   return(list(lb=MM[,1],rb=MM[,2],p=MM[,3]))}
> T <- data.table(S=J2$units$Y1,H=lapply(Z$V1,tra))
> T
> T[3,H][[1]]$p
[1] 0.4 0.4 0.2

# JSON
> TQjson <- toJSON(T)
> QQ <- as.data.table(fromJSON(TQjson))
> QQ
> QQ[3,H.p][[1]]
> write(TQjson,file="TQ.JSON")

# extending data.table
> s <- sample(1:5,nrow(T),replace=TRUE)
> gen <- function(k) sample(c("X","Y","Z"),k,replace=TRUE)
> TQ <- copy(QQ)
> TQ[,comp := lapply(s,gen)]
> TQ[,name := LETTERS[1:10]]
> TQ[,w := sample(60:90,10,replace=TRUE)]
> setcolorder(TQ,c("name","w","comp","S","H.lb","H.rb","H.p"))
> TQ

# JoggersExt.json
> Jex <- fromJSON(paste0(path,"JoggersExt.json"))
> # Jex <- fromJSON("JoggersExt.json")
> names(Jex)
> Jex$info$title
> Jex$info$trace
> Jex$vars
> D <- as.data.table(Jex$units)
> D
> D[3,H.p][[1]]

