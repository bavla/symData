# 1365. Sredin seminar, 21. maj 2025

# Simple data table

> wdir <- "C:/Users/vlado/docs/papers/2025/SDA/test"
> setwd(wdir)
> nm <- c("Anna", "Betty", "Charles", "Doris", "Edward")
> sx <- c("F", "F", "M", "F", "M") 
> ag <- c(29, 30, 28, 33, 27)
> D <- data.frame(name=nm,sex=factor(sx,levels=c("M","F")),age=ag)
> D
> write.csv2(D,file="DFex1.csv")

# Composed values

> ph <- list(
+   data.frame(loc=c("home","work"),
+     num=c("051123456","051654321")),
+   data.frame(loc="home",num="051121212"),
+   data.frame(loc=c("work","home"),
+     num=c("051987654","051456789")),
+   data.frame(loc="work",num="051356356"),
+   data.frame(loc="home",num="051717171"))
> D$phone <- ph
> D
> (P <- D$phone[1][[1]])
> P[P$loc=="home",]$num
> write.csv2(D,file="DFex2.csv")

# The World Factbook

> library(jsonlite)
> F <- fromJSON("C:/Users/vlado/DL/data/kaggle/CIA/factbook.json")
> names(F)
> length(names(F$countries))
> head(names(F$countries))
> tail(names(F$countries))

> str(F$countries$slovenia,max.level=2)
> F$countries$slovenia$data$energy$electricity
> F$countries$slovenia$data$energy$electricity$exports

> D <- as.data.frame(F$countries[["slovenia"]]$data$energy$electricity) 

> names(F$countries$slovenia$data)
> names(F$countries$slovenia$data$people)
> P <- F$countries$slovenia$data$people$age_structure
> names(P)
> P$date
> P[[2]]

> N <- names(F$countries); n <- length(N)
> C <- NULL
> for(i in 1:n){
+   P <- F$countries[[i]]$data$people$age_structure
+   d <- NULL
+   for(j in 1:5){d <- rbind(d,P[[j]])}
+   row.names(d) <- names(P)[1:5]
+   C <- rbind(C,list(name=N[i],year=P$date,pop=as.data.frame(d)))
+ }
> head(C)
> C <- as.data.frame(C)
> str(C[1:2,])
 
> as.data.frame(C[1,3])
> (sp <- as.data.frame(C[which(N=="slovenia"),3]))
> (vp <- unname(unlist(sp$percent)))
> sp[3,]

# JSON

> write(toJSON(C,auto_unbox=TRUE),file="popAge.JSON")

> Q <- fromJSON("popAge.json")
> names(Q)
> dim(Q)
> (p1 <- as.data.frame(Q$pop[1]))
> (ps <- as.data.frame(Q$pop[which(Q$name=="slovenia")]))

# Inf, NA, NaN

> (M <- matrix(c(1:4, NaN, NA, Inf, +Inf, -Inf), ncol=3, byrow=TRUE))
> (m <- toJSON(M))
> fromJSON(m)
> t <- '[[1,2,3],[4,"NaN","NA"],["Inf","Infinity","-Inf"]]'
> fromJSON(t)

# Tidyverse / Tibble

> library(tidyverse)
> CT <- as_tibble(C)
> glimpse(CT)
> CU <- unnest(CT,cols=c(name,year))
> glimpse(CU)
> CU

# SDA format

> path <- paste0("https://raw.githubusercontent.com/bavla/symData/",
+   "refs/heads/master/Billard-Diday/") 
> J2 <- fromJSON(paste0(path,"Joggers2.json"))
> names(J2)
> J2$info
> J2$units

> Y1 <- as.data.frame(cbind(J2$units$Y1))
> Y1$V1[[9]] 

> (Y2 <- as.data.frame(cbind(as.data.frame(J2$units)[,3])))
> T2 <- cbind(J2$units$Y2)
> as.data.frame(cbind(T2[9,1][[1]]))



