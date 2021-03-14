# fakedata-example

1. Get the released binary from <insert_url>

2. Download the fakedata repo

```
git clone https://github.com/fakedata-haskell/fakedata.git
cd fakedata
git submodule init
git submodule update
```

3. Run the binary

```
./fakedata-example-exe default -- uses the path from the fakedata library
./fakedata-example-exe custom /path/to/local/fakedata -- uses the local library
```
