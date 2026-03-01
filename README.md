# COVID-19 Global Analysis (SQL + Tableau)

## Executive Summary
The COVID-19 pandemic generated massive global datasets, but decision-makers need clear insights rather than raw numbers.  
In this project, I used **SQL Server for data exploration and transformation** and **Tableau Public for visualization** to build an interactive dashboard tracking global cases, deaths, infection rates, and trends over time.

The project demonstrates an **end-to-end analytics workflow**:
Raw Dataset → SQL Analysis → Tableau Dashboard → Public Visualization

---

## Dashboard Preview


![COVID Dashboard](Tableau/Tableau%20Dashboard.png)

---

## Business Problem
COVID-19 reporting spans hundreds of countries and thousands of daily records.  
The challenge is transforming raw pandemic data into clear insights that answer:

- How severe was COVID globally?
- Which continents were most impacted by deaths?
- Which countries had the highest infection rates relative to population?
- How did infection rates evolve over time?

---

## Dataset
Source: **Our World in Data (OWID) COVID-19 Dataset from kaggle**

Tables used:
- CovidDeaths
- CovidVaccinations

---

## Methodology

### 1. Data Extraction & Cleaning (SQL Server)
Imported OWID COVID dataset into SQL Server and performed:

- Data filtering (`continent IS NOT NULL`)
- Type conversions (`CAST`, `CONVERT`)
- Aggregations and grouping
- Joining datasets
- Window functions for rolling vaccination totals
- CTEs, Temp Tables, and Views for reusable analysis

---

### 2. SQL Analysis

<table width="100%">

<tr>
<td width="50%" valign="top">

### Global Metrics
- Total global cases  
- Total global deaths  
- Global death percentage  

</td>

<td width="50%" valign="top">

### Impact Analysis
- Countries with highest death counts  
- Deaths by continent  

</td>
</tr>

<tr>
<td width="50%" valign="top">

### Infection Analysis
- Likelihood of death by country  
- Percentage of population infected  
- Countries with highest infection rate vs population  

</td>

<td width="50%" valign="top">

### Vaccination Analysis
- Joined deaths and vaccination datasets  
- Rolling vaccination totals using window functions  
- Reusable SQL View for Tableau  

</td>
</tr>

</table>
---

### 3. Tableau Dashboard Development
Since Tableau Public cannot connect directly to SQL Server:
- SQL outputs were exported to Excel
- Built four Tableau visualizations:

1. **Global KPI Tiles**
2. **Total Deaths by Continent (Bar Chart)**
3. **Percent Population Infected (World Map)**
4. **Time Series + Forecast for Major Countries**

---

## Skills Demonstrated

**SQL:** Joins • Window Functions (OVER, PARTITION BY) • Aggregations • CTEs • Temp Tables • Views • Data Cleaning & Transformation  

**Tableau:** Dashboard Design • Geographic Mapping • Forecasting • KPI Visualization • Data Storytelling
---

## Key Insights
- Europe and North America recorded the highest death totals.
- Infection rates vary significantly when normalized by population.
- The U.S. and U.K. show the steepest growth trends among selected countries.
- Forecasting indicates continued growth in infection percentages.

---

## Tableau Dashboard
👉 **Live Dashboard:** *https://public.tableau.com/app/profile/nirjala.prajapati/viz/CovidProject_17705793166420/Dashboard1*


