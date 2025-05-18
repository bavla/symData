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
