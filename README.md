# UPI Payments Analysis (India)

## Dashboard Link
Link - https://akshatrastogi-analyst.github.io/upi-payments-analysis/

## Business question
How fast is UPI growing, how big is the average payment in Rs, and what should a bank or payment app plan for?

## Data
- NPCI UPI Product Statistics, monthly: banks live, volume (million), value (Rs crore). Apr 2025 to Sep 2026, some months not included.
- NPCI state-wise UPI data for Aug 2026 (top 5 states).
- Files: `upi_analysis.sql` (tables and queries), `index.html` (dashboard).

## Steps
1. Put the NPCI monthly data into a PostgreSQL table.
2. Added days in the month, so months can be compared fairly using daily numbers.
3. Calculated value in Rs lakh crore, daily transactions, and average payment size.
4. Calculated year-over-year growth (same month, last year).
5. Compared states by average payment size.
6. Made a one-page dashboard.

## Findings
- Volume grew about 24% and value about 19% to 21% compared with the same month last year (Apr to Jun 2026).
- Daily transactions went from about 596 million (Apr 2025) to about 802 million (Sep 2026).
- Average payment fell from about Rs 1,338 (Apr 2025) to about Rs 1,220 (Sep 2026).
- Aug 2026 had the highest volume (24,509 million). May 2026 had the highest value (Rs 29.90 lakh crore).
- In Aug 2026, Telangana (about Rs 1,523) and Tamil Nadu (about Rs 1,504) had bigger average payments than Maharashtra (about Rs 1,166) and Uttar Pradesh (about Rs 1,210).

## Recommendations
1. Plan extra server capacity before the busiest months.
2. Design offers for small everyday payments, since the average payment is falling.
3. Focus new merchant tie-ups on states with high payment value, not only high volume.

## Limits
Some months are missing from the data. Averages and daily numbers are my own calculations from NPCI totals.

