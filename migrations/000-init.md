For any table or function in this file, the object should be deleted if it exists before attempting to create it.
Include DROP CASCADE for any relevant commands.

# The account table

It needs the below fields. All fields are required.

- `id` primary key UUID
- `name` TEXT
- `kind` account type enum. The values can be 'debit' or 'credit'
- `starting_balance` currency.

# The category table

It needs the below fields. All fields are required.

- `id` primary key UUID
- `name` TEXT

# The transaction table

It needs the below fields.

- `id` primary key UUID
- `entered` date, required.
- `ord` int REQUIRED
- `description` TEXT
- `account_id` forign key to account table.
- `category_id` forign key to category table.
- `amount` currency, required.

There should be a procedure called `new_transaction` that takes an account id and a date. The procedure should get the
max `ord` for that date and account id. It should then create a new transaction incrementing the `ord`. If there are no
transactions for that date and account id the `ord` value should be set to 1. The `amount` should be 0. Do not return
any values.

# Init Data

Ensure all init data commands are at the bottom of the file.

Generate a single debit account with $4,000 and a credit account with $0.

Add a category for home, food, and gas.
