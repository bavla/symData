# Infinity, Undefined, NaN

The basic idea of the JSON format is that a JSON data description is in Javascript evaluated into a Javascript data value.    
```
> M <- matrix(c(1:4, NaN, NA, Inf, +Inf, -Inf), ncol=3, byrow=TRUE); M
     [,1] [,2] [,3]
[1,]    1    2    3
[2,]    4  NaN   NA
[3,]  Inf  Inf -Inf
> (m <- toJSON(M))
[[1,2,3],[4,"NaN","NA"],["Inf","Inf","-Inf"]] 
> fromJSON(m)
     [,1] [,2] [,3]
[1,]    1    2    3
[2,]    4  NaN   NA
[3,]  Inf  Inf -Inf

> (g <- gsub("Inf","Infinity",m))
[[1,2,3],[4,"NaN","NA"],["Infinity","Infinity","-Infinity"]] 
> fromJSON(g)
     [,1]       [,2]       [,3]       
[1,] "1"        "2"        "3"        
[2,] "4"        "NaN"      NA         
[3,] "Infinity" "Infinity" "-Infinity"
> 
```

```
```

```
```
<hr>

[JSON](./README.md)

