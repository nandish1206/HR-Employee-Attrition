# HR Employee Attrition Analysis
🛠️ Tech Stack: MySQL | Python | Pandas | Excel | Power BI | Statistics

📊 Dataset: IBM HR Analytics Employee Attrition & Performance

## 📌 Project Overview

This project analyzes employee attrition to identify the employee segments most likely to leave and translate the findings into actionable HR retention strategies.

The analysis follows an end-to-end data analytics workflow using **MySQL, Python/Pandas, Excel, and Power BI**, with a client-style PowerPoint presentation summarizing the key findings.

---

## 🎯 Business Problem

Employee turnover can increase recruitment costs, reduce productivity, and create workforce planning challenges.

The key business question for this project is:

> **Which employee segments are most likely to leave, and what actions can HR take to reduce attrition?**

---

## 🛠️ Tools & Technologies

- **MySQL** — Data exploration and business queries
- **Python / Pandas** — Data cleaning, feature engineering and exploratory analysis
- **SciPy** — Statistical hypothesis testing
- **Seaborn / Matplotlib** — Data visualization
- **Excel** — Summary analysis and dashboard
- **Power BI** — Interactive HR attrition dashboard
- **PowerPoint** — Business presentation
- **GitHub** — Project documentation and version control

---

## 🔄 Project Workflow

```text
Raw Dataset
     ↓
   MySQL
     ↓
Python / Pandas
     ↓
Exploratory & Statistical Analysis
     ↓
Excel
     ↓
Power BI Dashboard
     ↓
PowerPoint Presentation
     ↓
Business Recommendations
```

---

## 📊 Dataset

The project uses the **IBM HR Analytics Employee Attrition & Performance** dataset.

- **Rows:** 1,470 employees
- **Columns:** 35
- **Target variable:** `Attrition`
- **Attrition categories:** Yes / No

The dataset contains employee demographic, compensation, job, satisfaction, tenure, overtime and performance-related information.

---

# 📈 Key Findings

## Overall Attrition

| KPI | Value |
|---|---:|
| Total Employees | 1,470 |
| Employees Left | 237 |
| Attrition Rate | 16.12% |
| Average Monthly Income | ₹6,502.93 |
| Average Years at Company | 7.01 |

> **Note:** The ₹ symbol is used for presentation purposes; the source dataset does not explicitly specify the currency.

---

## 1. Overtime is strongly associated with attrition

| Overtime | Attrition Rate |
|---|---:|
| No | 10.44% |
| Yes | 30.53% |

Employees working overtime show substantially higher observed attrition.

A Chi-Square test was performed:

- **χ² = 87.56**
- **p < 0.001**
- Result: statistically significant association

This indicates a strong statistical association between overtime status and attrition in this dataset. It does **not** establish that overtime directly causes employees to leave.

---

## 2. Early-tenure employees are higher-risk

Attrition is generally higher among employees with shorter tenure, particularly when combined with overtime.

Examples of observed high-risk segments:

| Segment | Employees | Attrition Rate |
|---|---:|---:|
| Sales Representative + Overtime + 0–2 Years | 10 | 80.00% |
| Sales Representative + Overtime + 3–5 Years | 10 | 70.00% |
| Laboratory Technician + Overtime + 0–2 Years | 28 | 64.29% |
| Sales Executive + Overtime + 0–2 Years | 16 | 62.50% |

These rates should be interpreted alongside the number of employees in each segment.

---

## 3. Income is related to observed attrition differences

| Income Band | Attrition Rate |
|---|---:|
| <3000 | 28.61% |
| 3000–4999 | 14.12% |
| 5000–7999 | 10.00% |
| 8000–11999 | 15.59% |
| 12000+ | 5.64% |

The lowest income band has considerably higher observed attrition than the highest income band.

---

## 4. Younger employees show higher attrition

The analysis shows higher observed attrition among younger employees.

The youngest age group has the highest observed attrition rate, while older groups generally show lower rates.

---

# 🧪 Statistical Analysis

### Welch's Independent Two-Sample t-Test

Numeric variables were compared between employees who stayed and employees who left.

| Variable | Stayed Mean | Left Mean | p-value | Result |
|---|---:|---:|---:|---|
| Monthly Income | 6,832.74 | 4,787.09 | <0.001 | Significant |
| Age | 37.56 | 33.61 | <0.001 | Significant |
| Years at Company | 7.37 | 5.13 | <0.001 | Significant |
| Years in Current Role | 4.48 | 2.90 | <0.001 | Significant |
| Distance from Home | 8.92 | 10.63 | 0.004 | Significant |
| Years Since Last Promotion | 2.23 | 1.95 | 0.199 | Not significant |

### Practical Effect Size

For Monthly Income:

- **Cohen's d = 0.44**
- Interpretation: **Small effect**

This demonstrates an important analytical point: statistical significance does not necessarily mean that the practical/business effect is large.

---

# 📊 Power BI Dashboard

The Power BI dashboard contains three pages:

### 1. Executive Overview
- KPI cards
- Department attrition
- Job role attrition
- Overtime attrition
- Tenure attrition
- Interactive slicers

### 2. Attrition Drivers
- Income band
- Age group
- Distance from home
- Job satisfaction
- Work-life balance
- Job role + overtime
- Tenure + overtime

### 3. Statistical Insights
- Chi-Square test
- Welch's t-test
- Cohen's d
- Correlation matrix

---

## 💡 HR Recommendations

### 1. Reduce overtime pressure
Review workload, staffing and overtime allocation in high-risk roles.

### 2. Strengthen early-tenure retention
Introduce structured onboarding and 30/60/90-day check-ins for new employees.

### 3. Target high-risk job roles
Prioritize retention initiatives for roles showing consistently higher attrition.

### 4. Review lower-income segments
Evaluate compensation competitiveness and career progression opportunities.

### 5. Monitor attrition continuously
Use Power BI to track attrition by department, role, tenure, overtime and income.

---

# 📁 Project Structure

```text
HR-Employee-Attrition/
│
├── data/
│   ├── raw/
│   │   └── WA_Fn-UseC_-HR-Employee-Attrition.csv
│   └── processed/
│
├── sql/
│   └── hr_attrition_analysis.sql
│
├── python/
│   └── HR_Attrition_Analysis.ipynb
│
├── excel/
│   ├── HR_Attrition_Analysis.xlsx
│   └── HR_Attrition_Statistics.xlsx
│
├── powerbi/
│   └── HR_Attrition_Dashboard.pbix
│
├── presentation/
│   └── HR_Attrition_Analysis.pptx
│
├── screenshots/
│   ├── executive_overview.png
│   ├── attrition_drivers.png
│   └── statistical_insights.png
│
└── README.md
```

---

# ⚠️ Important Interpretation Note

This dataset is used for analytical and portfolio purposes.

The findings describe **associations and patterns in the observed data**. They should not be interpreted as proof that a particular factor independently causes employee attrition.

High-risk segments should therefore be treated as groups for further investigation and targeted HR intervention rather than as employees who are certain to leave.

---

## 🚀 Conclusion

The analysis shows that employee attrition is concentrated in specific workforce segments rather than being evenly distributed.

The strongest signals involve:

- Overtime
- Early tenure
- Income level
- Age
- Selected job roles
- Distance from home

A targeted retention strategy—supported by continuous dashboard monitoring—can help HR focus resources where the observed attrition risk is highest.

---

## 👤 Project Type

**End-to-End Data Analytics Portfolio Project**

**MySQL → Python → Excel → Power BI → Business Recommendations**
