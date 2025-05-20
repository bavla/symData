# JSON

Traditional data analysis is based on a (simple) data table T<sub>U╳V</sub>, over a set of units U and a set of unit properties or variables V. The entry T[u, v] contains the (measured) value of a property v ∈ V at a unit u ∈ U. The values are simple data: numbers, logical values, dates, character strings. When encoding data, sometimes there is a need for unusual values such as unknown, meaningless, and infinite. Spreadsheet programs such as Excel can be used to prepare, maintain, and perform simple analyses of such tables.

In recent times, there are more and more examples of data that go beyond simple tables - the values can be composite data: time series, sequences of events, sets of strings, intervals, distributions, graphs, etc. Sometimes we add one or more (weighted) relations between the units - we get a network. If we convert the table T into triples (u, v, T[u, v]), we get a knowledge graph.

In the seminar, we will look at examples in R to see how generalized tables are represented, read, used, and saved to a file in modern programming languages, and can be exchanged between programs written in different programming languages.



  * [Data frame](df.md)
  * [Tidyverse](tv.md)
  * [The World Factbook](wfb.md)
  * [Infinity, Undefined, Not a number](spec.md)



```
```

```
```

```
```

