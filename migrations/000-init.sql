-- Migration 000: Initial schema setup

-- Drop objects if they exist
DROP TABLE IF EXISTS config;
DROP PROCEDURE IF EXISTS upsert_config;

-- Create config table
CREATE TABLE config (
    key UUID PRIMARY KEY NOT NULL,
    value JSONB NOT NULL,
    last_update TIMESTAMP NOT NULL
);

-- Create upsert procedure that automatically sets the last_update field
CREATE OR REPLACE PROCEDURE upsert_config(
    p_key UUID,
    p_value JSONB
) AS $$
BEGIN
    INSERT INTO config (key, value, last_update)
    VALUES (p_key, p_value, CURRENT_TIMESTAMP)
    ON CONFLICT (key) 
    DO UPDATE SET 
        value = p_value,
        last_update = CURRENT_TIMESTAMP;
END;
$$ LANGUAGE plpgsql;