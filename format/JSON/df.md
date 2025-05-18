# Data frame

    
```
{ "SDA": "basic",
  "info":{
    "author": "Vladimir Batagelj",
    "date": "May 17, 2025",
    "source": { "title": "The World Factbook",
                "URL": "https://www.cia.gov/the-world-factbook/" }
  },
  "data": [
    { "id": 1, "lab": "Slovenia", "ISO": "SI", "pop": 2097893,
        "land": { "arable": 8.9, "crops": 2.7, "pasture": 18.8, 
        "forest": 61.3, "other": 8.4 },
      "age": [ { "lb":  0, "rb":  14, "pc": 14.3, "m":  153852, "f":  146628 },
               { "lb": 15, "rb":  64, "pc": 62.5, "m":  683573, "f":  627788 },
               { "lb": 65, "rb": "Inf", "pc": 23.2, "m":  213619, "f":  272433 } ]
    },
    { "id": 2, "lab": "Croatia", "ISO": "HR", "pop": 4150116,
      "land": { "arable": 15.2, "crops": 1.4, "pasture": 9.2, 
        "forest": 34.7, "other": 39.4 },
      "age": [ { "lb":  0, "rb":  14, "pc": 13.8, "m":  296527, "f":  278236 },
               { "lb": 15, "rb":  64, "pc": 63.1, "m": 1307814, "f": 1309394 },
               { "lb": 65, "rb": "Inf", "pc": 23.1, "m":  399090, "f":  559055 } ]
    },
    { "id": 3, "lab": "Italy", "ISO": "IT", "pop": 60964931,
      "land": { "arable": 24, "crops": 8.1, "pasture": 11.9, 
        "forest": 32.7, "other": 23.3 },
      "age": [ { "lb":  0, "rb":  14, "pc": 11.9, "m":  3699167, "f":  3531734 },
               { "lb": 15, "rb":  64, "pc": 64.5, "m": 19378160, "f": 19958137 },
               { "lb": 65, "rb": "Inf", "pc": 23.6, "m":  6336738, "f":  8060995 } ]
    },
    { "id": 4, "lab": "Austria", "ISO": "AT", "pop": 8967982,
      "land": { "arable": 16, "crops": 0.8, "pasture": 14.7, 
        "forest": 47.2, "other": 21.3 },
      "age": [ { "lb":  0, "rb":  14, "pc": 14.1, "m":  648639, "f":  616334 },
               { "lb": 15, "rb":  64, "pc": 64.7, "m": 2904587, "f": 2898339 },
               { "lb": 65, "rb": "Inf", "pc": 21.2, "m":  839672, "f": 1060411 } ]
    },
    { "id": 5, "lab": "Malta", "ISO": "MT", "pop": 469730,
      "land": { "arable": 24.4, "crops": 3, "pasture": 0, 
        "forest": 1.4, "other": 71.2 },
      "age": [ { "lb":  0, "rb":  14, "pc": 14.5, "m":  35034, "f":  33181 },
               { "lb": 15, "rb":  64, "pc": 62.4, "m": 151836, "f": 141248 },
               { "lb": 65, "rb": "Inf", "pc": 23.1, "m":  50153, "f":  58278 } ]
    }
  ]
}
```

```
> wdir <- "C:/Users/vlado/docs/papers/2025/SDA/test"
> setwd(wdir)
> library(jsonlite)
> D <- fromJSON("SDA.json")
> str(D)
List of 3
 $ SDA : chr "basic"
 $ info:List of 3
  ..$ author: chr "Vladimir Batagelj"
  ..$ date  : chr "May 17, 2025"
  ..$ source:List of 2
  .. ..$ title: chr "The World Factbook"
  .. ..$ URL  : chr "https://www.cia.gov/the-world-factbook/"
 $ data:'data.frame':   5 obs. of  6 variables:
  ..$ id  : int [1:5] 1 2 3 4 5
  ..$ lab : chr [1:5] "Slovenia" "Croatia" "Italy" "Austria" ...
  ..$ ISO : chr [1:5] "SI" "HR" "IT" "AT" ...
  ..$ pop : int [1:5] 2097893 4150116 60964931 8967982 469730
  ..$ land:'data.frame':        5 obs. of  5 variables:
  .. ..$ arable : num [1:5] 8.9 15.2 24 16 24.4
  .. ..$ crops  : num [1:5] 2.7 1.4 8.1 0.8 3
  .. ..$ pasture: num [1:5] 18.8 9.2 11.9 14.7 0
  .. ..$ forest : num [1:5] 61.3 34.7 32.7 47.2 1.4
  .. ..$ other  : num [1:5] 8.4 39.4 23.3 21.3 71.2
  ..$ age :List of 5
  .. ..$ :'data.frame': 3 obs. of  5 variables:
  .. .. ..$ lb: int [1:3] 0 15 65
  .. .. ..$ rb: num [1:3] 14 64 Inf
  .. .. ..$ pc: num [1:3] 14.3 62.5 23.2
  .. .. ..$ m : int [1:3] 153852 683573 213619
  .. .. ..$ f : int [1:3] 146628 627788 272433
  .. ..$ :'data.frame': 3 obs. of  5 variables:
  .. .. ..$ lb: int [1:3] 0 15 65
  .. .. ..$ rb: num [1:3] 14 64 Inf
  .. .. ..$ pc: num [1:3] 13.8 63.1 23.1
  .. .. ..$ m : int [1:3] 296527 1307814 399090
  .. .. ..$ f : int [1:3] 278236 1309394 559055
  .. ..$ :'data.frame': 3 obs. of  5 variables:
  .. .. ..$ lb: int [1:3] 0 15 65
  .. .. ..$ rb: num [1:3] 14 64 Inf
  .. .. ..$ pc: num [1:3] 11.9 64.5 23.6
  .. .. ..$ m : int [1:3] 3699167 19378160 6336738
  .. .. ..$ f : int [1:3] 3531734 19958137 8060995
  .. ..$ :'data.frame': 3 obs. of  5 variables:
  .. .. ..$ lb: int [1:3] 0 15 65
  .. .. ..$ rb: num [1:3] 14 64 Inf
  .. .. ..$ pc: num [1:3] 14.1 64.7 21.2
  .. .. ..$ m : int [1:3] 648639 2904587 839672
  .. .. ..$ f : int [1:3] 616334 2898339 1060411
  .. ..$ :'data.frame': 3 obs. of  5 variables:
  .. .. ..$ lb: int [1:3] 0 15 65
  .. .. ..$ rb: num [1:3] 14 64 Inf
  .. .. ..$ pc: num [1:3] 14.5 62.4 23.1
  .. .. ..$ m : int [1:3] 35034 151836 50153
  .. .. ..$ f : int [1:3] 33181 141248 58278
```


```
> D$data$lab
[1] "Slovenia" "Croatia"  "Italy"    "Austria"  "Malta"   
> D$data$land$arable
[1]  8.9 15.2 24.0 16.0 24.4
> D$data$land[1,]
  arable crops pasture forest other
1    8.9   2.7    18.8   61.3   8.4
> D$data$land[D$data$ISO=="IT",]
  arable crops pasture forest other
3     24   8.1    11.9   32.7  23.3
> 
```
