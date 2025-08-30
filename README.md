# Office Building Energy Profile: An Analysis of Energy and Conservation Potential

This repository contains the code (**SQL and Python**) and RETScreen expert report on analysis and plots of the energy profile of the Agricultural and Biosystems Engineering (ABE) building at the University of Ilorin, Nigeria. The dataset used is a primary data collected specifically for this research. The analyis method used include Exploratory Data Analyis (EDA) and Hypotheses-Driven Analyis. Which assessed the potential energy conservation in the building and CO₂ emission reduction using **RETScreen Expert**.

# Project Division
1. Hypothesis Testing (pre-retrofit and post-retrofit data)
2. Performance Analysis using RETScreen Expert

# The Building

![alt text](<../ABE Building.png>)

Figure 1: Pictorial view of the ABE building.

# About the Data
The datasets [two datasets] used are primary data of pre-retrofit and post-retrofit scenario of appliances in the building (data ). Both dataset contains the same number of rows and columns; **14 columns and 2205 rows**. They also have the same names of columns. 
The variables [columns] include: *Office number, date, day, time interval, fridge, AC, desktop, fan, laptop, bulb, phone, total power, diff in time interval, energy consumed, room area, energy consumed per area, and conditions.*

The dataset used in this project is not publicly available due to privacy and confidentiality reasons. **The data is, however, available upon request.** Please reach out to me at chibuike.emmanuelh@gmail.com with a brief description of your intended use.



# Data Collection and Preprocessing

Python and Microsoft Excel were utilized for the data collection and data cleaning. Excel was used to insert data collected daily and also to check and clean basic errors in data. Python was used for advance cleaning technique and feature engineering.

![alt text](../screenshot_pre_retrofit_data.png)

Figure 2: First 30 rows of pre-retrofit data of the ABE building.

![alt text](../Screenshot_post_retrofit_data.png)

Figure 3: First 30 rows of post-retrofit data of the ABE building.

# Exploratory and Hypotheses-Driven Data Analyses

SQL and Python were used for exploratory data analysis and to answer the research questions of this study, which also include the comparison between pre-retrofitted and post-retrofitted data. For the hyptheses, SQL was utilized for quering the values, whereas Python was used majorly for plotting graphs; using Matplotlib and Seaborn libraries.

![alt text](<Screenshot on sql.png>)

Figure 4: Part of SQL code used to generate the values to be plotted.

![alt text](image.png)

Figure 5: Hypotheses-driven graph showing the energy consumption per square metre across rooms in the building.

# Performance Analysis using RETScreen Expert Software

RETScreen Expert was used to get a target for the reduction in energy consumption and estimated CO₂ emission reduction from the building. And a comparison of the emissions from the building between year 2024 and 2025 using the pre-retrofitted data.

![alt text](<Screenshot rets.png>)

Figure 6: Plot from RETScreen showing the base case, benchmark, and target of the building's energy consumption.

# Tools used for this project
* Microsoft Office: Excel, Word, and Powerpoint for data documentation and presentation
* Python: Libraries such as; Pandas, Numpy, Matplotlib, and Seaborn
* SQL Server Management Studio
* RETScreen Expert: For performance analysis 
* Git and GitHub: Version control system