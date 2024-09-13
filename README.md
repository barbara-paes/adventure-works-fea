# Data Modeling Project - Adventure Works

## About the Project

This project was developed by **Jeniffer Sanches** to showcase my skills in **dbt**, **data modeling**, and **data structuring**, transforming a database from an **OLTP** environment into **OLAP** for consumption in a **Data Warehouse** and a **BI tool**.

The database used is **Adventure Works**, which is a sample database from Microsoft for **online transaction processing (OLTP)**. Adventure Works simulates a fictional multinational manufacturing company called **Adventure Works Cycles**.

## Objectives

The goal of this project was to perform **data modeling** of the Adventure Works database, making the data available for consumption in a **BigQuery Data Warehouse** and also in a **sales dashboard in PowerBI**.

## Project Steps

1. **Data Extraction and Modeling**: 
   - I used **dbt** to model the data.
   - **Two fact tables** were created:
     - **Order Fact**: with a granularity at the order level.
     - **Product Fact**: with a granularity at the product level.
   
2. **Dimension Tables**:
   - **Product**
   - **Customer**
   - **Credit Card**
   - **Region**
   - **Calendar**

3. **Storage and Consumption**:
   - The data was made available for querying in **BigQuery**.
   - A **sales dashboard** was created in **PowerBI**, presenting sales metrics, trends, and analysis.

## Technologies Used

- **dbt**
- **BigQuery**
- **PowerBI**
- **SQL**

## Access the Project

- [View the dashboard in PowerBI](#) (https://bit.ly/3XquKNf)

## Contact

If you have any questions or suggestions, feel free to contact me via [LinkedIn](https://www.linkedin.com/in/jeniffer-sanches/).
