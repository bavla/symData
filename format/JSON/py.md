# Python


https://realpython.com/python-json/ https://www.w3schools.com/python/python_json.asp

```
import sys, os, json
wdir = "C:/Users/vlado/docs/papers/2025/SDA/test"
os.chdir(wdir)
with open("SDA.json", mode="r", encoding="utf-8") as read_file:
  D = json.load(read_file)
type(D)
<class 'dict'>
D.keys()
dict_keys(['SDA', 'info', 'data'])
print(json.dumps(D["data"], indent=2))
```

```
[
  {
    "id": 1,
    "lab": "Slovenia",
    "ISO": "SI",
    "pop": 2097893,
    "land": {
      "arable": 8.9,
      "crops": 2.7,
      "pasture": 18.8,
      "forest": 61.3,
      "other": 8.4
    },
    "age": [
      {
        "lb": 0,
        "rb": 14,
        "pc": 14.3,
        "m": 153852,
        "f": 146628
      },
      {
        "lb": 15,
        "rb": 64,
        "pc": 62.5,
        "m": 683573,
        "f": 627788
      },
      {
        "lb": 65,
        "rb": "Inf",
        "pc": 23.2,
        "m": 213619,
        "f": 272433
      }
    ]
  },
  {
    "id": 2,
    "lab": "Croatia",
    "ISO": "HR",
    "pop": 4150116,
    "land": {
      "arable": 15.2,
...........
      {
        "lb": 65,
        "rb": "Inf",
        "pc": 23.1,
        "m": 50153,
        "f": 58278
      }
    ]
  }
]
```

```
```


<hr>

[JSON](./README.md)
