# mongodb-using-daru
testing mongodb + daru to make dataframe

1. Install mongodb ` brew services start mongodb` for mac.

I created testdb in mongo shell : 

```
> db
testdb
> db.cars.insert({name: "Audi", price: 52642})
WriteResult({ "nInserted" : 1 })
> db.cars.insert({name: "Mercedes", price: 57127})
WriteResult({ "nInserted" : 1 })
> db.cars.insert({name: "Volvo", price: 29000})
WriteResult({ "nInserted" : 1 })
```

