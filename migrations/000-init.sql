-- Migration 000: Initial schema setup

-- Drop objects if they exist
DROP TABLE IF EXISTS transaction CASCADE;
DROP TABLE IF EXISTS category CASCADE;
DROP TABLE IF EXISTS account CASCADE;
DROP TYPE IF EXISTS account_type CASCADE;
DROP PROCEDURE IF EXISTS new_transaction CASCADE;

-- Create account type enum
CREATE TYPE account_type AS ENUM ('debit', 'credit');

-- Create account table
CREATE TABLE account
(
    id               UUID PRIMARY KEY NOT NULL,
    name             TEXT             NOT NULL,
    kind             account_type     NOT NULL,
    starting_balance NUMERIC(10, 2)   NOT NULL
);

-- Create category table
CREATE TABLE category
(
    id   UUID PRIMARY KEY NOT NULL,
    name TEXT             NOT NULL
);

-- Create transaction table
CREATE TABLE transaction
(
    id          UUID PRIMARY KEY NOT NULL,
    entered     DATE             NOT NULL,
    ord         INT              NOT NULL,
    description TEXT,
    account_id  UUID REFERENCES account (id),
    category_id UUID REFERENCES category (id),
    amount      NUMERIC(10, 2)   NOT NULL
);

-- Create new_transaction procedure
CREATE OR REPLACE PROCEDURE new_transaction(
    p_account_id UUID,
    p_entered DATE
) AS
$$
DECLARE
    v_max_ord INT;
BEGIN
    -- Get the max ord for the given date and account id
    SELECT COALESCE(MAX(ord), 0)
    INTO v_max_ord
    FROM transaction
    WHERE account_id = p_account_id
      AND entered = p_entered;

    -- Increment the max ord to get the new ord value
    v_max_ord := v_max_ord + 1;

    -- Create a new transaction with the incremented ord value and amount set to 0
    INSERT INTO transaction (id, entered, ord, account_id, amount)
    VALUES (gen_random_uuid(), p_entered, v_max_ord, p_account_id, 0.00);
END;
$$ LANGUAGE plpgsql;

-- Initialize data
-- Create accounts
INSERT INTO account (id, name, kind, starting_balance)
VALUES ('11111111-1111-1111-1111-111111111111', 'Checking Account', 'debit', 4000.00),
       ('22222222-2222-2222-2222-222222222222', 'Credit Card', 'credit', 0.00);

-- Create categories
INSERT INTO category (id, name)
VALUES ('33333333-3333-3333-3333-333333333333', 'Home'),
       ('44444444-4444-4444-4444-444444444444', 'Food'),
       ('55555555-5555-5555-5555-555555555555', 'Gas');

