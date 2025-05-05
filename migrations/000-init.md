For any table or function in this file, the object should be deleted if it exists before attempting to create it.

Create a config table. It needs the below fields. All fields are required.

- `key` primary key UUID
- `value` JSONB.
- `last_update` timestamp

The config table should have an upsert procedure that automatically sets the `last_update` field.
