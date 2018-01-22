D2PajekUS <- function(filenet,filenet2,D,imenaPod,imenaNet){
  # filenet = pajkova datoteka za omrezje
  # filenet2 = izhodna pajkova datoteka (weighted links)
  # imenaPod = vrstni red identifikatorjev v matriki
  # imenaNet = vrstni red identifikatorjev v omrezju
  x1=1620;x2 = 2916 # to sta dva countija, ki jih v matriki razlicnosti ni (po trenutni identifikaciji z imeni)
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
  for(i in 1:n){
    tmp = readLines(net1,n=1)
    tmp = unlist(strsplit(tmp,"[ ]+"))
    tmp = paste(tmp[2],paste0("\"",imenaNet[i],"\""),tmp[4],tmp[5],tmp[6])
    cat(tmp,"\n", file=net2) # zapis v datoteko
  }
  dictND = c(1:(x1-1),0,x1:(x2-2),0,(x2-1):n) # imena so vrstice v matriki (dve manj)
  ##
  tmp = readLines(net1,n=1)
  cat(tmp,"\n",  file=net2) # zapis v datoteko
  ## 
  tmp = readLines(net1,n=1)
  while(!grepl("[*]",tmp)){
    delcki = strsplit(tmp,"[ ]+")[[1]] 
    st1 = as.numeric(delcki[2]); st2 = as.numeric(delcki[3])
    if(!(st1%in%c(x1,x2))&!(st2%in%c(x1,x2))){ # the two vertices with no connection in matrix are left as no links
      i = which(imenaPod==imenaNet[st1])[1]
      j = which(imenaPod==imenaNet[st2])[1]
      if(is.na(i)|is.na(j))print(paste(ime1,ime2)) # ce nastanejo problemi (da ni enote v matriki razlicnosti)
      weight = D[i,j]
      cat(st1,st2,weight,"\n",file=net2)
    }
    tmp = readLines(net1,n=1)
  }
  cat(tmp,"\n",  file=net2) # zapis v datoteko
  vrstice = readLines(net1)
  unlist(strsplit("([\n])",vrstice))
  for(tmp in vrstice){
    delcki = strsplit(tmp,"[ ]+")[[1]] 
    st1 = as.numeric(delcki[2]); st2 = as.numeric(delcki[3])
    if(!(st1%in%c(x1,x2))&!(st2%in%c(x1,x2))){ # the two vertices with no connection in matrix are left as no links
      i = which(imenaPod==imenaNet[st1])[1]
      j = which(imenaPod==imenaNet[st2])[1]
      if(is.na(i)|is.na(j))print(paste(ime1,ime2)) # ce nastanejo problemi (da ni enote v matriki razlicnosti)
      weight = D[i,j]
      cat(st1,st2,weight,"\n",file=net2)
    }
  }
  close(net1)
  close(net2)
}
