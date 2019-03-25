# CommonFloor Clone

This is a sample application where real estate properties are shown for buying,
renting and selling.

## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ cd /path/to/repos
$ git clone https://github.com/amanksingh01/commonfloor_clone.git
$ cd commonfloor_clone
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
```

(Optional) Seed the databse with sample data:
```
$ rails db:seed
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```

## License

Licensed under the [MIT License](LICENSE).