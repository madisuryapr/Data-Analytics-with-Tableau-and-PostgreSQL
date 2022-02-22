/* Create Database for Project named "Economics" */
CREATE DATABASE Economics;

/* Create Schema for Payment Systems */
CREATE TABLE payment_systems (
    data_id                  INTEGER NOT NULL
        PRIMARY KEY ,
    month                    DATE,
    category                 TEXT,
    transactions_value       BIGINT,
    transactions_volume      BIGINT,
    value_growth             DOUBLE PRECISION,
    value_growth_annualized  DOUBLE PRECISION,
    volume_growth            DOUBLE PRECISION,
    volume_growth_annualized DOUBLE PRECISION
);