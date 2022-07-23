# Bio faker backend


## Build and run
* Install [stack](https://docs.haskellstack.org/en/stable/README/)
* Run
```sh
git clone --recurse-submodules -j8 https://github.com/br4ch1st0chr0n3/bio-faker-back
cd bio-faker-back
sh run.sh
```

## Host on Heroku
* Read this [article](https://hackernoon.com/for-all-the-world-to-see-deploying-haskell-with-heroku-7ea46f827ce)
* Do 
```
heroku create app-name  -b https://github.com/mfine/heroku-buildpack-stack
git remote add app-name https://git.heroku.com/app-name.git
git push heroku master
heroku ps:scale web=1
```

## Access online
* `GET`-requests at
    * [/yoda](https://bio-faker-back.herokuapp.com/yoda)
    * [/chuck_norris](https://bio-faker-back.herokuapp.com/chuck_norris)

## References
* Clone repo with nested submodules: [here](https://stackoverflow.com/a/4438292)
* Clone nested submodules retrospectively: [here](https://stackoverflow.com/a/6562038)