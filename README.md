# Bank Elixir

This project was created to learn about elixir programming language. It likes a bank register account and bank transactions. 
I saved the data of users, accounts and transactions in file to learn about how to elixir work with files (.txt).

## Usage

To run this project you need elixir installed in you machine.

You can download this project then enter in project.

Run commands bellow

```
$ mix deps.get

$ ies -S mix
```

To register a user, you can run:

```
$ user_1: %User{email: "myemail@email.com", name: "My name"}}

$ Account.create(user_1) # By default the account has 1000 money

$ user_2: %User{email: "mysecond@email.com", name: "My name"}}

$ Account.create(user_2) # By default the account has 1000 money
```

We created two accounts.

To transfer money to other account you need set emails of accounts and the value: 

```
$ Transaction.transfer("mysecond@email.com", "myemail@email.com", 90)
```

To show all accounts, you can run:

```
$ Transaction.search
```

To calculate total of transactions by year, month and day you can run:

Year:
```
$ Transaction.calculate_total_year(Date.utc_today().year)
```
Month:
```
$ Transaction.calculate_total_month(Date.utc_today().year, Date.utc_today().month)
```
Day:
```
$ Transaction.calculate_total_day(Date.utc_today())
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)