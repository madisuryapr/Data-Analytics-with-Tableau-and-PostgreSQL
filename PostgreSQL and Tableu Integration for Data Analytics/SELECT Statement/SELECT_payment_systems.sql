/*********** SQL SELECT Statement ***********/

/* 1. Select all data from table named "payment_systems" */
SELECT ps.*
FROM payment_systems ps;

/* 2. Select Data ID and Category columns and give both columns nickname */
SELECT
ps.data_id AS "Data ID",
ps.category AS "Payment System"
FROM payment_systems ps;

/* 3. Select Data ID, Date, Category and Transactions Value columns where
      Category only consist of retail payment systems (i.e. Debit Cards,
      Credit Cards, and Electronic Money)
 */
SELECT ps.period AS "Date",
       ps.data_id AS "Data ID",
       ps.category AS "Payment Systems",
       ps.transactions_value AS "Transactions Value (Billion IDR)"
FROM payment_systems ps
WHERE ps.category
          IN ('Debit Cards', 'Credit Cards', 'Electronic Money');

/* 4. Select Data ID, Category and Transactions Value columns where
      Category only consist of wholesale payment systems (i.e.
      Bank Indonesia National Clearing and Real-Time Gross Settlement Systems)
 */
SELECT ps.period AS "Date",
       ps.data_id AS "Data ID",
       ps.category AS "Payment Systems",
       ps.transactions_value AS "Transactions Value (Billion IDR)"
FROM payment_systems ps
WHERE ps.category
IN ('Bank Indonesia National Clearing System',
            'Bank Indonesia-Real Time Gross Settlement System');

/* 5. Select average transactions value data and group the data
      by payment systems
*/
SELECT ps.category AS "Payment Systems",
       INT8(AVG(ps.transactions_value)) AS
           "Total Transactions Value (Billion IDR)"
FROM payment_systems ps
GROUP BY ps.category;

/* 6. Retrieve the average of transactions value and volume
      for each payment systems each year */
/* Note: Transactions value and volume are in Billion IDR and 000 Unit (exception for
         BI-RTGS), respectively
   */
SELECT DATE_PART('year', ps.period) AS "Year",
       ps.category AS "Payment System",
       INT8(AVG(ps.transactions_value)) AS "AVG Transactions Value",
       INT8(AVG(ps.transactions_volume)) AS "AVG Transactions Volume"
FROM payment_systems ps
GROUP BY DATE_PART('year', ps.period), ps.category
ORDER BY DATE_PART('year', ps.period);

/* 7. Select all records from table between year 2020 and 2021 */
SELECT ps.*
FROM payment_systems ps
WHERE ps.period
BETWEEN '2020-01-01' AND '2021-12-01';

/* 8. Retrieve Credit and Debit Cards transactions value and volume
      annualized growth records, alongside its Data ID where data
      period after 2009
 */
 SELECT ps.data_id AS "Data ID",
        ps.period AS "Date",
        ps.category AS "Payment System",
        ps.value_growth_annualized AS "YoY Value Growth",
        ps.volume_growth_annualized AS "YoY Volume Growth"
FROM payment_systems ps
WHERE DATE_PART('year', ps.period) > 2009
AND ps.category
        IN ('Credit Cards', 'Debit Cards')
ORDER BY ps.data_id;

/* 9. Select transactions value records for all payment systems
      having transactions value is more than the average
 */
 SELECT ps.data_id AS "Data ID",
        ps.period AS "Date",
        ps.category AS "Payment System",
        ps.transactions_value AS "Transactions Value (Billion IDR)"
FROM payment_systems ps
GROUP BY ps.data_id, ps.period, ps.category, ps.transactions_value
HAVING ps.transactions_value >= AVG(ps.transactions_volume)
ORDER BY ps.data_id;

/* 10. Retrieve All Payment Systems Included within the table */
SELECT DISTINCT ps.category
    AS "Payment System"
FROM payment_systems ps;

/* 11. How Many Debit Cards Transactions with Value more than 400000? */
/* You will Obtain 82 Transactions for the result */
SELECT ps.category AS "Payment System",
       COUNT(ps.transactions_value)
FROM payment_systems ps
WHERE ps.transactions_value > 400000
AND ps.category = 'Debit Cards'
GROUP BY ps.category;

/* 12. Retrieve Bank Indonesia-Real Time Gross Settlement System
       Number of Transactions where Transactions value is more
       than 8500000
   */
/* Hint: You should obtain 95 number of transactions */
SELECT ps.category AS "Payment System",
       COUNT(ps.transactions_value) AS
           "Number of Transaction"
FROM payment_systems ps
WHERE ps.category = 'Bank Indonesia-Real Time Gross Settlement System'
AND ps.transactions_value > 8500000
GROUP BY ps.category;

