getleaders <- function(object,nL){
  # get last nL leaders from object
  # hclust
  merge <- object$merge
  inx <- dim(merge)[1]
  curr_nL <- 2
  clu <- inx
  while (length(clu) < nL){
    clu <- setdiff(clu,inx)
    curr_clu <- merge[inx,]
    clu <- union(clu,curr_clu)
    inx <- inx-1
  }
  return(clu)
}
hleader.units <- function(object,nleader){
  # get all units for the leader with number nleader
  # object - object hclust
  merge <- object$merge
  if(nleader>0){
    units <- merge[nleader,]
    for (i in units[which(units>0)]){
      units <- append(units,hleader.units(object,i))
      units <- setdiff(units,i)
    }}
  else{units <- nleader}
  return(units)
}
check.dendro.order <- function(object,inx,...){
  # object - hclust
  # inx - indexes of hierarchical leaders of interest
  plot(object,...)
  li <- length(inx)
  rectOut <- rect.hclust(object,li)
  order <- vector("numeric",li)
  counter <- 0 # current index
  for (i in inx){
    counter <- counter+1
    units <- abs(hleader.units(object,i))
    for (j in 1:li){
      if ((units %in% rectOut[[j]])[1]){
        order[j] <- counter;break}
    }}
  return(order)
}

my.cutree <- function(dendro,numberClu){
  temp = rect.hclust(dendro,numberClu)
  clustering = numeric(length(dendro$labels)) ## TU SO SEDAJ PRAVE STEVILKE GLEDE NA DENDROGRAM (cutree jih ne da glede na dendrogram!)
  for(i in 1:length(temp)){
    clustering[temp[[i]]] = i 
  }
  return(clustering)
}

change.dendro.order <- function(object,inxClu){
  # object - hclust
  # inxClu - indices of current clusters in different ordering
  clustering = my.cutree(object,length(inxClu))
  cluOrder = clustering[object$order]
  order2 = NULL
  for(i in 1:length(inxClu)){
    order2 = c(order2,object$order[cluOrder==inxClu[i]])
  }
  object$order=order2
  return(object)
}