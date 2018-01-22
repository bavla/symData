
library(clamix)

# populacijske piramide NUTS

### TESTRANJE ###
# F3df = read.csv2(file="nutspopyr/F3.csv")
# M3df = read.csv2(file="nutspopyr/M3.csv")
# # ničle
# F3df[which(F3df$Y_LT5==0),] # Albanija, Makedonija (ju bomo izkljucili)
# # NAji
# F3df[which(is.na(F3df$Y_GE85)),] # Irska # tega stolpca ne bomo uporabljali - samo Y_GE90 bomo uporabljali
# apply(x[,c(2:19,21),],1,sum) # Irska # izracunamo, ce drzi
# # UNK ni 0
# F3df[which(F3df$UNK!=0),] # ne bomo upostevali ze zaradi zgoraj

#F3df = F3df[-c(which(F3df$Y_LT5==0)),-which(names(F3df)%in%c("Y_GE85","UNK"))]
#M3df = M3df[-c(which(M3df$Y_LT5==0)),-which(names(M3df)%in%c("Y_GE85","UNK"))]

preurediNUTS3 <- function(tmp){
  tmp = F3df
  tmp = tmp[-c(which(tmp$Y_LT5==0)),-which(names(tmp)%in%c("Y_GE85","UNK","TOTAL"))]
  rownames(tmp) = tmp[,1]
  tmp = tmp[,-1]
  names(tmp) = c("0-4","5-9","10-14","15-19","20-24","25-29","30-34","35-39","40-44","45-49","50-54",
                    "55-59","60-64","65-69","70-74","75-79","80-84","85-89","90-")
  return(tmp)
}

naredi1 <- function(){
F3final = preurediNUTS3(F3df)
M3final = preurediNUTS3(M3df)
dl = list("M"=M3final,"F"=F3final)
MF3r <- create.symData(dl,"rDist")
MF3p <- create.symData(dl,"pDist")
########### shranimo oba csv-ja (potrebujemo kasneje za imena) in symData (relative ali z utezmi)
save(F3final,M3final,MF3r,MF3p,file="NUTSpopNew.RData")
}

# naredi matriko razlicnosti za v Pajek

Dissimilarity <- function(dataset,type){
  so <- dataset$so; alpha <- dataset$alpha
  L <- dataset$SOs; nVar <- length(so)
  numL <- length(L); numLm <- numL-1
  # each unit is a cluster; compute inter-cluster dissimilarity matrix
  D <- matrix(nrow=numL,ncol=numL); diag(D) <- Inf
  for(i in 1:numLm) for(j in (i+1):numL) {
    Z <- zlead(L[[i]],L[[j]],nVar,so,L[i],L[j],zs[[type]])
    D[i,j] <- distC(L[[i]],L[[j]],Z,nVar,alpha,L[i],L[j],Ds[[type]])
    D[j,i] <- D[i,j]
  }
  return(D)
}

naredi2 <- function(){
matrikaDr = Dissimilarity(MF3r,type="d1")
imenaD = rownames(M3final)
}

# pripravi uteženo Pajkovo omrezje s pomocjo matrike razlicnosti (razlicnost le med povezanimi enotami)

D2Pajek <- function(filenet,filenet2,D,imenaD){
  net1 = file(filenet,"r")
  tmp = readLines(net1,n=1)
  while(!grepl("[*]",tmp)){
    tmp = readLines(net1,n=1)
  }
  net2 <- file(filenet2,"w")
  # dobi stevilo vozlisc
  n = as.numeric(strsplit(tmp," ")[[1]][2])
  cat("% D2Pajek:",date(),"\n*Vertices",n,"\n",file=net2)
  # naredi dictionary - da ves, katero ime ima katera st. vozlisca
  # zraven zapisi tudi vse enote v novo datoteko
  vektor = numeric(n)
  for(i in 1:n){
    tmp = readLines(net1,n=1)
    cat(tmp,"\n", file=net2) # zapis v datoteko
    # dictionary in vektor
    delcki = strsplit(tmp,"[ ]+")[[1]] # prazni prostorcki razdelijo stvari
    st = as.numeric(delcki[2])
    ime = gsub("([\"])","",delcki[3])
    vektor[st] = ime # vektor imen
  }
  dictN = 1:n; names(dictN) = vektor # vektor stevil (z imeni) - nekaksen dictionary
  dictD = 1:n; names(dictD) = imenaD
  ##
  tmp = readLines(net1,n=1)
  cat(tmp,"\n",  file=net2) # zapis v datoteko
  ## 
  tmp = readLines(net1,n=1)
  while(!grepl("[*]",tmp)){
    delcki = strsplit(tmp,"[ ]+")[[1]] 
    st1 = as.numeric(delcki[2]); st2 = as.numeric(delcki[3])
    ime1 = vektor[st1]; ime2 = vektor[st2]
    i = dictD[ime1]; j = dictD[ime2]
    if(is.na(i)|is.na(j))print(paste(ime1,ime2)) # ce nastanejo problemi (da ni enote v matriki razlicnosti)
    weight = D[i,j]
    cat(st1,st2,weight,"\n",file=net2)
    tmp = readLines(net1,n=1)
  }
  cat(tmp,"\n",  file=net2) # zapis v datoteko
  vrstice = readLines(net1)
  unlist(strsplit("([\n])",vrstice))
  for(tmp in vrstice){
    delcki = strsplit(tmp,"[ ]+")[[1]] 
    st1 = as.numeric(delcki[2]); st2 = as.numeric(delcki[3])
    ime1 = vektor[st1]; ime2 = vektor[st2]
    i = dictD[ime1]; j = dictD[ime2]
    if(is.na(i)|is.na(j))print(paste(ime1,ime2)) # ce nastanejo problemi (da ni enote v matriki razlicnosti)
    weight = D[i,j]
    cat(st1,st2,weight,"\n",file=net2)
  }
  close(net1)
  close(net2)
  return(list(imena=vektor,dictD=dictD,dictN=dictN))
}

#D2Pajek("nutsdsimple/testNUTS.net","nutsdsimple/testWeight.net",matrikaDr[1:10,1:10],imenaD[1:10])

naredi3 <- function(){
rez=D2Pajek("nutsdsimple/NUTSdSea.net","nutsdsimple/NUTSdWeight.net",matrikaDr,imenaD)
######## shrani kvazi-dictionaries - da lazje operiras s tem naprej (imena in pripadajoci IDji)
### dictD[ime] = id (st.vrstice v matriki)
### dictN[ime] = id (id v omrezju v Pajku)
save(rez,file="nutsdsimple/NUTSdict.RData")
}

preberiClu <- function(file){
  clu = file(file,"r")
  readLines(clu,n=1) # prva vrstica ni pomembna
  cluster = readLines(clu)
  close(clu)
  return(cluster)
}


RDendro <- function(fileP, fileV, imena, method="relational/tolerant"){
  orDendro <- function(i){if(i<0) return(-i)
    return(c(orDendro(m[i,1]),orDendro(m[i,2])))}
  partition = as.numeric(preberiClu(fileP))
  h = as.numeric(preberiClu(fileV))
  n = (length(h)+1)/2
  # height
  h = h[(n+1):length(h)]
  # merge
  m = matrix(nrow=n-1,ncol=2)
  dictM = 1:(n-1)
  names(dictM) = as.character((n+1):length(partition))
  for(i in 1:(n-1)){
    tmp = which(partition==(i+n))
    #print(i)
    if(tmp[1] <= n) m[i,1] = -tmp[1]
    else m[i,1] = dictM[as.character(tmp[1])]
    if(tmp[2] <= n) m[i,2] = -tmp[2]
    else m[i,2] = dictM[as.character(tmp[2])]
  }
  hc = list(merge=m,height=h,order=orDendro(n-1),labels=imena,
            method=method,call=match.call(),dist.method="")
  class(hc) <- "hclust"
  return(hc)
}

# fileP="nuts_results/resultNUTSWeight/NUTSdendro.clu"
# fileV="nuts_results/resultNUTSWeight/NUTSdendro.vec"
# imena=names(rez$dictN)
# hcl = RDendro(fileP, fileV, imena)
# plot(hcl,hang=-1,cex=0.3,main="")

# sizeTree ???
rankTree <- function(hcl){
  nm <- length(hcl$height)
  rank <- rep(0,nm)
  for (i in 1:nm){
    j <- hcl$merge[i,1]; a <- ifelse(j<0,0,rank[j])
    j <- hcl$merge[i,2]; b <- ifelse(j<0,0,rank[j])
    rank[i] <- 1+max(a,b)
  }
  return(rank)
}

# hclRank = hcl
# hclRank$height = rankTree(hcl)
# plot(hclRank,hang=-1,cex=0.1,main="")
# tmp = rect.hclust(hclRank,k=50)#,h=90) length(tmp)
# sapply(tmp,FUN=length)
# length(which(sapply(tmp,FUN=length) > 5)) # koliko clustrov je "dovolj velikih"
# tmp[which(sapply(tmp,FUN=length) > 5)] # izberi clustre ven in narisi na zemljevid in piramide

# izracun za 1 skupino

relativSum = function(x){
  return(apply(x/apply(x,1,sum),2,sum))
}

getCluRepresent = function(nr=1,cluster,M,Z,relative=FALSE){
  # number of cluster in map
  # cluster == clustering za risanje na zemljevid
  # M, Z - data.frame of males, females
  dictCl = names(table(cluster)) # stevilke clustrov, ki so narisane na zemljevidu
  imenaPodrocij = names(cluster[cluster==dictCl[nr]])
  inx = which(rownames(M)%in%imenaPodrocij)
  # compute represent
  if(relative){
    # sestevamo samo oblike (shapes), ne celih piramid
    male = relativSum(M[inx,])
    female = relativSum(Z[inx,])
  }
  else{
    male = apply(M[inx,],2,sum)
    female = apply(Z[inx,],2,sum)
  }
  return(list(M=male,F=female,inx=inx))
}

#############################

source("dendro_rearragement.R")
huygensT <- function(podatki,rezLeaders,dendro,numberClu,tip="d1"){
  if(is.null(rezLeaders)){
    clustering = my.cutree(dendro,numberClu)
  }else{
    clustering = getFinalCluster(rezLeaders,dendro,numberClu)$razbitjeEnotDendro
    ##leadH = get.ordered.leaders(dendro,numberClu,rezLeaders)
  }
  
  nVar <- length(podatki$so)
  numSO <- length(podatki$SOs)
  rT = numeric(numberClu)
  leadAll = tlead(podatki$SOs,numSO,nVar,1,podatki$so,rep(1,numSO),ts[[tip]]) # iz clamix-a (tableDiss2.R)
  leadT = tlead(podatki$SOs,numSO,nVar,numberClu,podatki$so,clustering,ts[[tip]])
  for(i in 1:numberClu){
    ## izracunaj WI ("WSS")
    inxC = which(clustering==i) # get indices of data in this cluster
    rT[i] = 0
    for(j in inxC){
      rT[i] = rT[i] + distSO(podatki$SOs[[j]],leadT[[i]],nVar,podatki$alpha,deltas[[tip]])
    }
  }
  # izracunaj TI
  rAll = 0
  for(j in 1:numSO){
    rAll = rAll + distSO(podatki$SOs[[j]],leadAll[[1]],nVar,podatki$alpha,deltas[[tip]])
  }
  return(list(rT=rT,rAll=rAll,leadT=leadT,leadAll=leadAll))
}


plotMap = function(dendro,numClu,minSize=5){
  # izris zemljevida, vrne ven clustering z imeni podrocij
  NUTSd <- readShapeSpatial("NUTS_2013_01M_SH/data/NUTS_RG_01M_2013.shp")
  NUTSd3 <- NUTSd[NUTSd@data$STAT_LEVL_ == 3, ]
  labsd3 <- as.character(NUTSd3$NUTS_ID) # pomembno za pravo barvanje
  NUTSd0 = NUTSd[NUTSd@data$STAT_LEVL_ == 0, ]
  
  cluster = cutree(dendro,k=numClu)
  values0 = which(table(cluster)<=minSize) # vse manjse od daj v "neskupino"
  cluster[cluster%in%names(values0)] = 0
  clusterMatch = cluster[match(labsd3,names(cluster))] # vrstni red razvrstitve za risanje na zemljevid
  cM = as.numeric(as.factor(clusterMatch)) # clustri gredo od 1 naprej (zaporedno)
  if(any(names(table(cluster))=="0")){
    barve = c("white",brewer.pal(max(cM)-1,"Paired"))
    legend = c("other",1:(max(cM)-1))
  }
  else{
    barve = brewer.pal(max(cM),"Paired")
    legend = 1:max(cM)
  }
  plot(NUTSd3,xlim=c(-24,44),ylim=c(28,70),lwd=0.1,bg="skyblue",col=barve[cM])
  plot(NUTSd0, add = TRUE,lwd=0.8)
  text(coordinates(NUTSd0),labels=as.character(NUTSd0$NUTS_ID),cex=0.6)
  legend("topright",fill=barve,cex=0.75,legend=legend,bty="n")
  return(clusterMatch)
}


# izris populacijskih piramid na eni sliki
izrisP <- function(clu,meje=seq(0,0.15,len=4),nrow=2,relative=FALSE){
  # clu - clustering with original cluster numbers (or 0)
  # meje - boundaries of pop.pyramid
  nClu = length(table(clu))
  op=par(mfrow=c(nrow,round(nClu/nrow)))
  other = ifelse(any(clu==0),TRUE,FALSE) # is there a cluster other
  for(j in 1:nClu){
    tmp = getCluRepresent(j,clu,M3final,F3final,relative=relative)
    dx <- data.frame(tmp$M/sum(tmp$M), tmp$F/sum(tmp$F), row.names = names(tmp$M))
    ime = ifelse(other,ifelse(j==1,"other",j-1),j)
    pyramid(dx,Lcol="blue",Rcol="red",Laxis=meje,Raxis=meje,main=paste("cluster",ime))
  }
  par(op)
}

izrisSO <- function(dendro,nClu,meje=seq(0,0.15,len=4),nrow=2){
  # dendro - dendrogram of hclustSO
  # meje - as above
  inx = getleaders(dendro,nClu)
  op=par(mfrow=c(nrow,round(nClu/nrow)))
  for(j in 1:nClu){
    tmp = rezSO$leaders[[inx[j]]]
    last = length(tmp$M)
    dx <- data.frame(tmp$M[-last], tmp$F[-last], row.names = names(M3final))
    pyramid(dx,Lcol="blue",Rcol="red",Laxis=meje,Raxis=meje,main="")
  }
  par(op)
}