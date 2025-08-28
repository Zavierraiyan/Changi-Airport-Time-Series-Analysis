# Changi Airport Time Series Analysis

This project focuses on forecasting monthly passenger arrivals at **Changi Airport** using time series models.  
The main objective is to identify patterns, seasonality, and trends to support better planning and forecasting.

## 🔹 Key Details
- **Dataset**: Monthly passenger arrival data (2009–2019)
- **Methods**: Time Series Analysis (Decomposition, ACF/PACF), SARIMA
- **Tools**: R, RMarkdown
- **Output**: Forecast of future passenger arrivals with SARIMA model

## 🔹 Result
The **SARIMA (2,1,0)(0,1,1)[12]** model successfully captured both seasonal and trend components.  
It showed clear seasonal peaks in **March** and **December**, reflecting holiday travel patterns.  
The 5-year forecast indicates a continued upward trend, although uncertainty increases over time.  
This model can be applied for **short-term forecasting**, provided it is regularly updated with new data to maintain accuracy and support airport management in **capacity planning and service strategy**.

📄 [Full Report](https://drive.google.com/file/d/1YMdNZ-sZI5be6nGwgU3Q74xj1VcBynR9/view?usp=drive_link)
