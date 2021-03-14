# fakedata-example

1. Get the [released binary](https://github.com/luvemil/fakedata-example/releases/download/v0.1.0.0/fakedata-example-exe-0.1.0.0-Linux-ghc-8.10.2)

2. Download the fakedata repo

```
git clone https://github.com/fakedata-haskell/fakedata.git
cd fakedata
git submodule init
git submodule update
```

3. Run the binary

```
./fakedata-example-exe-0.1.0.0-Linux-ghc-8.10.2 default -- uses the path from the fakedata library
./fakedata-example-exe-0.1.0.0-Linux-ghc-8.10.2 custom /path/to/local/fakedata -- uses the local library
```
