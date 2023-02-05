rescript-axios
---------------

Axios bindings for Rescript with @ryyppy/rescript-promise

Requirements
---------------

1. bs-platform@9.1.2 and above.
2. axios@1.3.1 and above.
3. @ryyppy/rescript-promise@2.1.0 and above

Installation
---------------
##### 1.Adding dependencies
```
npm i rescript axios @ryyppy/rescript-promise --save
```
##### 2.Install @kaylew/rescript-axios
```
npm i @kaylew/rescript-axios --save
```
##### 3.Add @ryyppy/rescript-promise and @kayle/rescript-axios as dependencies in your bsconfig.json:


```
{
  "bs-dependencies": [
    "@ryyppy/rescript-promise",
    "@kaylew/rescript-axios"
  ]
}
```

Usage
------------
##### axios
You can use Axios.axios() function which is correspond with axios() in axios.But you must use Axios.makeConfig to create axios configs.
```
let config = Axios.makeConfig(
    ~url="/route",
    ~method="get",
    ~baseUrl="protocol://domain:port/api",
    ...
)
Axios.axios(~config=config,())
    ->Promise.then(res => {
        let data = res.data
        Promise.resolve()
    })
    ->Promise.catch(err => {
        Js.log(err.message)
        Promise.resolve()
    })
    ->ignore
```

##### get

```
Axios.get(~url="protocol://domain:port/api",())
    ->Promise.then(res => {
        ...
    })
    ->Promise.catch(err => {
        ...
    })
    ->ignore
```
