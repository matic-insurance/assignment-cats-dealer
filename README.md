## Cats Dealer 

### Setup

Run bundler to install dependencies:

```
bundle install
```

Bootstrap the ENVs

```
./script/bootstrap
```

#### Environment Variables
This project used [dotenv](https://github.com/bkeepers/dotenv) to set configuration values as environment variables. If you ran ` script/bootstrap `, you should have both a ` .env.development ` and a ` .env.test ` file.

When adding configuration values to the project, first make an entry in ` .env.example `. If the data is sensitive, such as passwords, use a placeholder:

```
SECRET_PASSWORD = :put_your_super_secret_password_here
```

If the data is not sensitive, like a URL, you can store it directly in ` .env.example ` and then commit it to git.

If you have environment specific variables, place these into their respective environments:

 * .env.example - example used by ` script/bootstrap ` to create the next two files
 * .env.development - loaded by development
 * .env.test - loaded by test

#### Storage Update
App is designed to fetch `Cats` from providers asynchronously in the background.

It will do the initial fetch when you run ./script/bootstrap

If you want ro refresh storage manually, please either run 
```
cats:storage:refresh
```
or setup background runner. It is already sheduled to run the job every 5 minutes.
