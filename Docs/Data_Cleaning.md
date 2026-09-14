# Data Cleaning

## Objective

The objective of data cleaning was to prepare the raw e-commerce data for reliable analysis while preserving the original source data.

Raw tables were not modified. Cleaned tables were created separately under the `CLEAN` schema in SQL Server.

## Cleaning Approach

The cleaning workflow followed:

Raw Data → Data Audit → Data Validation → Data Cleaning → EDA → Power BI

## Cleaning Activities

### 1. Data Type Standardization

`TRY_CONVERT()` was used to convert fields into appropriate data types.

Examples include:

- Numeric IDs converted to integer where appropriate.
- Price and payment values converted to decimal.
- Date and timestamp fields converted to datetime.
- Product attributes converted to numeric data types.

### 2. Text Standardization

`LTRIM()` and `RTRIM()` were used to remove leading and trailing spaces from text fields such as:

- City
- State
- Product Category
- Payment Type

### 3. Date Derivation

Additional time-related fields were derived from order purchase timestamps:

- Purchase Month
- Purchase Month Name
- Purchase Year

These fields support monthly and yearly trend analysis.

### 4. Missing Values

Missing values were not automatically replaced with zero.

Legitimate NULL values were retained where the original information was unavailable.

For important order dates, missing-value flags were created to support further analysis.

### 5. Data Quality Findings

The validation stage identified several data-quality observations, including:

- Orders without corresponding order-item records.
- Orders with missing delivery-related dates.
- Timeline inconsistencies between order lifecycle dates.
- Payment records with zero payment values.
- Missing product attributes.

These records were not blindly deleted. They were retained unless there was sufficient evidence that they were invalid.

### 6. Cleaning Principles

The following principles were followed:

- Preserve raw data.
- Avoid unnecessary deletion.
- Do not replace unknown values with zero without business justification.
- Separate data cleaning from business-rule investigation.
- Retain potentially valid anomalies for documented follow-up analysis.

## Output

Cleaned datasets were created in the SQL Server `CLEAN` schema and used as the primary source for Power BI analysis.
