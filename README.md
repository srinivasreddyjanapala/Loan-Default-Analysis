# Loan-Default-Analysis
Exploratory Analysis of Factors Influencing Loan Default


## 🔍 Project Overview
This project demonstrates an end-to-end **data analytics workflow** using SQL and Python.  
The objective is not to predict defaults, but to **understand what borrower and loan attributes contribute to higher risk of loan default**.  

The work is divided into two main stages:
1. **Data Cleaning (SQL)** – preparing raw loan data for analysis  
2. **Exploratory Data Analysis (Python)** – identifying key trends, correlations, and risk factors


### 1️⃣ Data Cleaning (SQL)
- Removed duplicate and invalid records  
- Standardized categorical fields (e.g., gender, loan status)  
- Handled missing values in income, loan amount, and tenure  
- Created **cleaned views** to be used for analysis in Python  

### 2️⃣ Exploratory Data Analysis (Python)
- **Univariate analysis** → distributions of loan status, income levels, loan amounts, and tenure  
- **Bivariate analysis** → segmented default rates by borrower demographics and loan characteristics  
- **Visualization** → bar charts, boxplots, and heatmaps to highlight correlations  


- Borrowers with **lower income** and **higher loan-to-value ratios** were more likely to default.  
- **Self-employed applicants** showed higher default percentages compared to salaried applicants.  
- Longer **loan tenure** correlated with slightly higher risk of default.  


---

## 🛠️ Tech Stack
- **SQL (MySQL)** → Data preprocessing and cleaning  
- **Python (Pandas, NumPy, Matplotlib, Seaborn)** → EDA and visualization  
- **Jupyter Notebook** → Analysis workflow and reporting  



