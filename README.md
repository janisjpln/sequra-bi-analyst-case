# SeQura BI Analyst - Technical Case

## 📌 Introduction
This project contains the resolution of the **Technical Case** for the *Business Intelligence Analyst* position at **SeQura**.  
The case is divided into two main sections:
1. **SQL Exercises** → Queries to answer specific business questions.
2. **Business Analysis & Recommendations** → Executive report with insights, recommendations, KPIs, and a Gantt implementation plan.

All interactive visualizations supporting this report are available in Tableau: [**View Dashboard**](https://public.tableau.com/app/profile/.janiscaler93/viz/Challenge_17547380028760/Dashboard1)

---

## 📂 Project Structure
- `/sql` → SQL queries with explanatory comments.  
- `/results` → CSV files exported from BigQuery with query results.  
- `/report` → Final PDF report.  

---

## 📂 Data Preparation
Before starting the SQL queries, the dataset provided in the case study (Appendix) was delivered in a Word document, which is not directly suitable for SQL querying.  
To ensure all tables could be loaded into BigQuery and maintain data integrity, I prepared them manually in **Microsoft Excel** as follows:  

1. **Copying to Excel**  
   - Selected each table from the Word document.  
   - Pasted it into a new Excel workbook, one sheet per table.  

2. **Column structure review**  
   - Checked that each column had the correct header name according to the schema in the Appendix.  
   - Ensured that each value was in its correct column (no merged cells or extra line breaks).  

3. **Data format standardization**  
   - **Dates:** Converted all date fields to `YYYY-MM-DD` format.  
   - **Timestamps:** Standardized to `YYYY-MM-DD HH:MM:SS`.  
   - **Decimals:** Ensured decimal separators used a dot `.` instead of a comma `,`.  
   - **Numeric IDs:** Confirmed they were integers without leading zeros.  
   - **Empty values:** Left blank cells for NULLs rather than using placeholders like `N/A`.  

4. **Data cleaning adjustments in Excel**  
   - Removed accidental spaces before/after text values using Excel’s TRIM function.  
   - Verified foreign keys matched primary keys in parent tables.  
   - Ensured prices and amounts were stored as numeric values, not text.  

5. **Exporting to CSV**  
   - Saved each sheet as `CSV UTF-8 (Comma delimited) (*.csv)`.  
   - Verified file encoding and delimiters.  

6. **Uploading to BigQuery**  
   - Created a dataset named `sequra_challenge`.  
   - Used **Create Table → Upload CSV** for each file.  
   - Enabled “Autodetect schema” for initial import, then verified data types.

**Outcome:**  
All 7 tables (`customers`, `products`, `orders`, `order_items`, `app_sessions`, `app_events`, `merchants`) were successfully loaded into BigQuery in CSV format, matching the original schema from the Appendix and ready for querying.  

---

## 🛠 Tools Used
- **BigQuery Sandbox** → Query execution (data loaded manually from CSV due to sandbox limitations).
- **Visual Studio Code** → Code organization and documentation.
- **Tableau Public** → Visualization and dashboard creation.
- **Canva** → Design of the final executive report.
- **GitHub** → Repository for storing and versioning the project.

---

## 📊 Part 1: SQL Solutions

Queries are stored in `/sql/` and documented with:
- **Business Goal**: What business question it answers.
- **Logic**: Steps followed in the query.
- **Assumptions**: If applicable.
- **Insights**: If applicable.

| Query | Description | SQL File | Results (CSV) |
|-------|-------------|----------|---------------|
| Q1.1  | Countries with more than 3 customers, including customer count and average age. | [q1_1_customers_by_country.sql](./sql/q1_1_customers_by_country.sql) | [Download CSV](./results/q1_1_customers_by_country.csv) |
| Q1.2  | Monthly ticket value trend for 2024 with month-over-month growth percentage. | [q1_2_monthly_ticket_trend.sql](./sql/q1_2_monthly_ticket_trend.sql) | [Download CSV](./results/q1_2_monthly_ticket_trend.csv) |
| Q2.1  | App engagement by platform (iOS vs Android) during H2 2024. | [q2_1_engagement_by_platform.sql](./sql/q2_1_engagement_by_platform.sql) | [Download CSV](./results/q2_1_engagement_by_platform.csv) |
| Q2.2  | Relationship between payment management usage and shopping portal engagement. | [q2_2_payment_vs_shopping_engagement.sql](./sql/q2_2_payment_vs_shopping_engagement.sql) | *(pending)* |
| Extra | Theoretical in-app purchase funnel. | [qx_in_app_shopping_funnel.sql](./sql/qx_in_app_shopping_funnel.sql) | [Download CSV](./results/qx_in_app_shopping_funnel.csv) |

---

## 📈 Part 2: Business Report
- **Format:** PDF (max. 3 pages).  
- **Content:**  
  - 4 actionable business recommendations.  
  - Expected impact with red/yellow/green thresholds.  
  - Implementation timeline (Gantt).  
  - Suggested KPIs for tracking.  
  - Follow-up analysis proposals.  

💡 *All charts supporting this report are available in the interactive Tableau Dashboard:*  
[**View Tableau Dashboard**]((https://public.tableau.com/app/profile/.janiscaler93/viz/Challenge_17547380028760/Dashboard1))

---

## 📝 Assumptions
1. Dataset is simulated and manually loaded into BigQuery from CSV.
2. Engagement metric = unique sessions/events per user.
3. Date filters applied according to `event_date` or equivalent field.
4. Monthly growth rate calculated as `(current month - previous month) / previous month × 100`.
5. Missing values (NULL) were treated as absence of data, not as zero, unless explicitly stated in the query logic.

---

## 📬 Author
**Janis Caler**  
[LinkedIn](https://www.linkedin.com/in/janis-caler-281005b9/)

---
