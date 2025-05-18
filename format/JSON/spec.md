# Infinity, Undefined, NaN

The basic idea of the JSON format ( [RFC 8259](https://datatracker.ietf.org/doc/html/rfc8259) and [ECMA-404](https://ecma-international.org/publications-and-standards/standards/ecma-404/) )is that in Javascript a JSON data description is evaluated into a Javascript data value (object).    


There are two problems related to numerical values
  * most programming languages support the [IEE 754](https://ieeexplore.ieee.org/document/8766229) standard for numerical values that includes (section 6) also special values +Infinity, -Infinity, and Not_a_Number (`+Inf`, `-Inf`, `NaN`). Javascript allows numbers of unlimited precision, but doesn't support the special values.
  * in data analysis the value Not_Available ( `NA` ) is used to indicate a missing value

See also: [Infinity and JSON](https://medium.com/the-magic-pantry/infinity-and-json-cde6df62c17c);
[json-status-in-ecmascript](https://stackoverflow.com/questions/1423081/json-left-out-infinity-and-nan-json-status-in-ecmascript);
[JSON in Python 3](https://docs.python.org/3/library/json.html);
[Issue 98](https://github.com/popsim-consortium/demes-spec/pull/98#issuecomment-872430331).

The new Javascript standard [ecma262](https://tc39.es/ecma262/) finally introduced values Infinity, Undefined, and .

In R the library `jsonlite` already supports `+Inf`, `-Inf`, `NaN`, and `NA`.
```
> library(jsonlite)
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

