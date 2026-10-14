-- UPI Payments Analysis
-- Data: NPCI monthly UPI numbers (volume in million transactions, value in Rs crore)

-- ---------- STEP 1: Make the tables ----------
DROP TABLE IF EXISTS upi_monthly;
DROP TABLE IF EXISTS upi_state;

CREATE TABLE upi_monthly (
    year        INT,
    month       INT,
    days        INT,       -- days in that month
    volume_mn   NUMERIC,   -- number of transactions, in million
    value_cr    NUMERIC    -- money moved, in Rs crore
);

CREATE TABLE upi_state (
    state       VARCHAR(30),
    volume_mn   NUMERIC,
    value_cr    NUMERIC
);

-- ---------- STEP 2: Put the data in ----------
INSERT INTO upi_monthly (year, month, days, volume_mn, value_cr) VALUES
(2025, 4,  30, 17893.42, 2394925.87),
(2025, 5,  31, 18677.46, 2514297.01),
(2025, 6,  30, 18395.01, 2403930.69),
(2025, 11, 30, 20466.98, 2631632.63),
(2025, 12, 31, 21634.67, 2796712.73),
(2026, 1,  31, 21703.44, 2833481.22),
(2026, 2,  28, 20394.18, 2684229.29),
(2026, 3,  31, 22641.11, 2952542.05),
(2026, 4,  30, 22346.80, 2902988.05),
(2026, 5,  31, 23201.93, 2990424.21),
(2026, 6,  30, 22716.07, 2892138.67),
(2026, 7,  31, 23658.35, 2987880.49),
(2026, 8,  31, 24508.96, 2982355.95),
(2026, 9,  30, 24068.38, 2937396.67);

INSERT INTO upi_state (state, volume_mn, value_cr) VALUES
('Maharashtra',   2387.27, 278444.23),
('Karnataka',     1267.99, 175515.33),
('Uttar Pradesh', 1264.90, 153003.53),
('Tamil Nadu',     998.58, 150169.77),
('Telangana',      964.23, 146863.32);


-- ---------- STEP 3: Questions ----------

-- Question 1: What does each month look like?
-- value_cr / 100000 gives the value in Rs lakh crore.
-- volume / days gives the daily transactions, so a short month like February is compared fairly.
-- value_cr * 10 / volume_mn gives the average payment in Rs.
SELECT year,
       month,
       volume_mn,
       ROUND(value_cr / 100000, 2)          AS value_lakh_crore,
       ROUND(volume_mn / days, 1)           AS daily_txn_million,
       ROUND(value_cr * 10 / volume_mn, 0)  AS avg_payment_rs
FROM upi_monthly
ORDER BY year, month;


-- Question 2: How much did UPI grow compared with the same month last year?
-- We join the table with itself: this year's row (this_year) with the same month in the year before (last_year).
SELECT this_year.year,
       this_year.month,
       ROUND((this_year.volume_mn - last_year.volume_mn) * 100 / last_year.volume_mn, 1) AS volume_growth_percent,
       ROUND((this_year.value_cr  - last_year.value_cr)  * 100 / last_year.value_cr, 1)  AS value_growth_percent
FROM upi_monthly this_year
JOIN upi_monthly last_year
  ON this_year.month = last_year.month
 AND this_year.year  = last_year.year + 1
ORDER BY this_year.year, this_year.month;


-- Question 3: Which months had the most transactions?
SELECT year, month, volume_mn
FROM upi_monthly
ORDER BY volume_mn DESC
LIMIT 3;


-- Question 4: Which months moved the most money?
SELECT year, month, ROUND(value_cr / 100000, 2) AS value_lakh_crore
FROM upi_monthly
ORDER BY value_cr DESC
LIMIT 3;


-- Question 5: Did the average payment get smaller over time?
-- Compare the first month (Apr 2025) with the latest month (Sep 2026).
SELECT year,
       month,
       ROUND(value_cr * 10 / volume_mn, 0) AS avg_payment_rs
FROM upi_monthly
WHERE (year = 2025 AND month = 4)
   OR (year = 2026 AND month = 9)
ORDER BY year, month;


-- Question 6: Which state has the biggest average payment (Aug 2026)?
SELECT state,
       volume_mn,
       ROUND(value_cr / 100000, 2)         AS value_lakh_crore,
       ROUND(value_cr * 10 / volume_mn, 0) AS avg_payment_rs
FROM upi_state
ORDER BY avg_payment_rs DESC;
