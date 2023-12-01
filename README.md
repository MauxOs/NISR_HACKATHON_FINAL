# NISR_HACKATHON_FINAL

Guidance on using this dashboard.

_____________________________________________________CPI and GDP Dashboard_______________________________________________________

Welcome to the CPI and GDP Dashboard! This interactive Shiny dashboard allows you to explore the trends in the Consumer Price Index (CPI), the percentage contributions of Main Categories, Variation in CPI (inflation rate) Comparing prices in both rural and urban economies, additionally, You will navigate through GDP Tabs to get insight about GDP growth rate over years, Percentage Contribution of Each Industry to GDP, and expenditure GDP.

Author: Maurice HIRWA UWIMANA and MUGABO Jeanforbin
Date: November 30, 2023

Getting Started

Follow these steps to set up and explore the CPI and GDP Dashboard:

1. There are three ways you can this dashboard:
I. Open this link https://mauxos.shinyapps.io/CPI_GDP_Report/ to access R markdown; an interactive report.
II. Open this link https://mauxos.shinyapps.io/CPI_GDP_Dashboard/ to access dashboard from any website you prefer.
III. Open this link https://github.com/MauxOs/NISR_HACKATHON_FINAL to access all related files to this app from github website.

2. Main R packages to be installed are: 'shiny', 'shinydashboard, 'plotly', 'tidyverse', 'readxl', ,'googlesheets4', 'shinythemes'. But don't worry we have included them within R script to ease your job.

3. Remember to first download used dataset. Simply, download R sript and excel file which contains all sheets we used to build this app, and then store them in single folder, then you run the app without changing anything like file path, the app itself will sort it out.
Note, if you use first two links which take you to shinyapp.io, you will never need to download anything, just click the link and then navigate the app.

4. Rscript: 'app.R' : Run the R code by double clicking this file and then inside RStudio, click RunApp button in upper-left corner.

5. Access the Dashboard: After running the app by clicking RunApp button, the app will appear/open in the pop up window and also in console, it will show you the URL which can be used to view/navigate the app within the preferred web browser. An example of URL you will find in your console: http://127.0.0.1:4788. Copy and paste the URL in preferred web browser then, boom!

6. Features:

- Explore CPI trends over time. - Visualize the percentage contributions of different categories to CPI in rural and urban areas. - Examine the rate of change of CPI on monthly and annual basis, and consider reading comments added underneath. - Eplore GDP growth rate since 2017 up to 2022 - Get insight on percentage contribution of each industry to GDP. - Interactive hover features for detailed insights.

7. Data Sources:

We have utilised CPI and GDP dataset which can be found here: https://www.statistics.gov.rw/publication/1873 and https://www.statistics.gov.rw/publication/1914. The main sheets (retrieved data) we utilised are included in github repository I shared earlier.

8. Feedback:

If you have any feedback, suggestions, or issues, please feel free to contact us at mauriceuhirwa@gmail.com and mjeanforbin@gmail.com. If you would like to have data in google sheet to work cloudly, don't hesitate to contact us to share the link with you!

Happy exploring!
