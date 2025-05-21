# The World Factbook

The World Factbook [WWW](https://www.cia.gov/the-world-factbook/), [GitHub](https://github.com/factbook)/[JSON](https://github.com/factbook/factbook.json), [Kaggle](https://www.kaggle.com/datasets/lucafrance/the-world-factbook-by-cia), [Ian Coleman](https://iancoleman.io/exploring-the-cia-world-factbook/).

https://github.com/bavla/EDA/blob/main/24/fb.md

    
```
> library(jsonlite)
> F <- fromJSON("C:/Users/vlado/DL/data/kaggle/CIA/factbook.json")
> names(F)
[1] "countries" "metadata" 
> length(names(F$countries))
[1] 259
> head(names(F$countries))
[1] "world"          "afghanistan"    "akrotiri"       "albania"        "algeria"       
[6] "american_samoa"
> tail(names(F$countries))
[1] "west_bank"      "western_sahara" "yemen"          "zambia"         "zimbabwe"      
[6] "european_union"

> str(F$countries$slovenia,max.level=2)
> F$countries$slovenia$data$energy$electricity
> F$countries$slovenia$data$energy$electricity$exports
$kWh
[1] 7.972e+09
$global_rank
[1] 26
$date
[1] "2017"
> D <- as.data.frame(F$countries[["slovenia"]]$data$energy$electricity)
 
> names(F$countries$slovenia$data)
> names(F$countries$slovenia$data$people)
> P <- F$countries$slovenia$data$people$age_structure
> names(P)
[1] "0_to_14"     "15_to_24"    "25_to_54"    "55_to_64"    "65_and_over" "date"       
> P$date
[1] "2020"
> P[[2]]
$percent
[1] 9.01
$males
[1] 98205
$females
[1] 91318
```
    
```
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
     name             year   pop         
[1,] "world"          "2020" data.frame,3
[2,] "afghanistan"    "2020" data.frame,3
[3,] "akrotiri"       NULL   data.frame,0
[4,] "albania"        "2020" data.frame,3
[5,] "algeria"        "2020" data.frame,3
[6,] "american_samoa" "2020" data.frame,3
> C <- as.data.frame(C)
> str(C[1:2,])
'data.frame':   2 obs. of  3 variables:
 $ name:List of 2
  ..$ : chr "world"
  ..$ : chr "afghanistan"
 $ year:List of 2
  ..$ : chr "2020"
  ..$ : chr "2020"
 $ pop :List of 2
  ..$ :'data.frame':    5 obs. of  3 variables:
  .. ..$ percent:List of 5
  .. .. ..$ 0_to_14    : num 25.3
  .. .. ..$ 15_to_24   : num 15.4
  .. .. ..$ 25_to_54   : num 40.7
  .. .. ..$ 55_to_64   : num 9.09
  .. .. ..$ 65_and_over: num 9.49
  .. ..$ males  :List of 5
  .. .. ..$ 0_to_14    : int 1005229963
  .. .. ..$ 15_to_24   : int 612094887
  .. .. ..$ 25_to_54   : int 1582759769
  .. .. ..$ 55_to_64   : int 341634893
  .. .. ..$ 65_and_over: int 326234036
  .. ..$ females:List of 5
  .. .. ..$ 0_to_14    : int 941107507
  .. .. ..$ 15_to_24   : int 572892123
  .. .. ..$ 25_to_54   : int 1542167537
  .. .. ..$ 55_to_64   : int 357176983
  .. .. ..$ 65_and_over: int 402994685
  ..$ :'data.frame':    5 obs. of  3 variables:
  .. ..$ percent:List of 5
  ..............
```
    
```
> as.data.frame(C[1,3])
            percent      males    females
0_to_14       25.33 1005229963  941107507
15_to_24      15.42  612094887  572892123
25_to_54      40.67 1582759769 1542167537
55_to_64       9.09  341634893  357176983
65_and_over    9.49  326234036  402994685
> (sp <- as.data.frame(C[which(N=="slovenia"),3]))
            percent  males females
0_to_14       14.84 160134  151960
15_to_24       9.01  98205   91318
25_to_54      40.73 449930  406395
55_to_64      14.19 148785  149635
65_and_over   21.23 192420  253896
> (vp <- unname(unlist(sp$percent)))
[1] 14.84  9.01 40.73 14.19 21.23
> sp[3,]
         percent  males females
25_to_54   40.73 449930  406395 
```
    
```

```

<hr>

[JSON](./README.md)
