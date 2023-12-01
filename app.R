# Install and load required packages

library(shiny)
library(shinydashboard)
library(plotly)
library(readxl)
library(googlesheets4)
library(shinythemes)


# Import your dataset (replace file path with your actual file path)



# Define UI
ui <- dashboardPage( skin = "green",
  dashboardHeader(title = "CPI and GDP Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      id = "tabs",
      
      menuItem("CPI TREND", tabName = "dashboard", icon = icon("line-chart")),
      menuItem("Main categories Weight", tabName = "pie_chart", icon = icon("chart-pie")),
      menuItem("Inflation rate", tabName = "CPI", icon = icon("area-chart")),
      menuItem("GDP", tabName = "GDP", icon = icon("bar-chart")),
      menuSubItem("Expenditure on GDP",tabName = "expenditure",icon = icon("industry")),
      
      conditionalPanel(
        condition = "input.tabs === 'dashboard'",
        
        selectInput("variable", "Select a variable:",
                    choices = c("GENERAL INDEX (CPI)", "Food and non-alcoholic beverages", "Alcoholic beverages and tobacco",
                                "Clothing and footwear","Housing, water, electricity, gas and other fuels","Furnishing, household equipment and routine household maintenance",
                                "Health","Transport","Communication","Recreation and culture","Education","Restaurants and hotels",
                                "Miscellaneous goods and services"),
                    selected = "GENERAL INDEX (CPI)"),
        
      ),
      
      conditionalPanel(
        condition = "input.tabs === 'GDP'",
        selectInput("barvariable", "Select a variable:",
                    choices = c("GROSS DOMESTIC PRODUCT (GDP)","AGRICULTURE, FORESTRY & FISHING","INDUSTRY","SERVICES"),
                    selected = "GROSS DOMESTIC PRODUCT (GDP)"),
      ),
      
      menuItem("About",tabName = "help",icon = icon("circle-info"))
      
    )
  ),
  
  dashboardBody(
    tabItems(
      
      tabItem(tabName = "dashboard",
              fluidRow( box(plotlyOutput("lineChart"), width = 12, height = 700, status = "info",
              br(),
              box(  title = "Notes", width = 7,
                    "This interactive line chart shows the trend of General index (CPI) and twelve 12 main categories. 
                It shows how CPI and 12 main categories evolved since 2009 up to 2022. Our interactive dashboard provides a visual journey through time-series data, allowing you to analyze 
                and understand the changing trends of each category. Dive into the details, uncover patterns, and make data-driven decisions with ease.",
                    br(),
                    br(),
                    "You may navigate to the percentage (%)  weight tab on left side of the dashboard to get insight on at which percentage each category contribute to General index (CPI).",
                    status = "success",
                    
              )) ) 
              
      ),
      tabItem(tabName = "CPI", 
              fluidRow(
              box(
                title = "Inflation rate in Urban and Rural, This is percentage change on the same period 12 months earlier (November 2021 - November 2022).",
                height = 1600,
                br(),
                width = 12,
                status = "success",
                
                fluidRow( box(plotlyOutput("lineChart1", height = 450), height = 550, width = 12, status = "success")),
                br(),
                br(),
              
                fluidRow( box(plotlyOutput("lineChart2", height = 450), height = 550, width = 12, status = "success")),
                br(),
                br(),
                
                box(title = "Note", "Urban CPI will be the focus of this publication as it is the headline index for monetary
                    policy purposes.", status = "info"),
                
                box(title = "Urban General Index (CPI)",
                    "Urban CPI increased by 21.7 percent on annual basis (November 2022 and November 2021)
                and increased by 0.8 percent on monthly basis (November 2022 to October 2022). The annual 
                average inflation rate between November 2022 and November 2021 was 12.3 percent.", status = "info"),
                
                box(title =  "Rural General Index (CPI)",
                    "Rural CPI increased by 42.9 percent on annual basis and increased by 1.5 percent on monthly basis.", status = "info"),
                
                box(title =  "Overall Rwanda General Index (CPI)",
                    "Rwanda CPI increased by 33.8 percent on annual basis and increased by 1.3 percent on monthly basis.", status = "info"),
                
              ))),
      tabItem(tabName = "expenditure",
              fluidRow( 
                
                tabBox(id= "subset1", height = "620px", width = "690px",
                       tabPanel("Expenditure",
                                
                box(title = "Trend of Expenditure GDP in (Billions)",
                            status = "warning", height= 560, width = 12,
                           box( plotlyOutput("expenditure"), height = 500, width = 12,
                                br(),
                                br(),
                                )), 
                           br(),
                           br(), 
                        
                          box(title = "Expenditure GDP in 2022", status = "warning", height= 800, width = 12,
                          br(),
                          box(title = "Percentage contribution of main indicators of expenditure GDP to overall GDP in 2022.", 
                              br(),
                              plotlyOutput("expenditure_on_GDP"), height = 720, width = 12,
                              
                              box(title = "Expenditure GDP Describution",
                                  "In 2022, private final consumption expenditure was 74 percent (Frw 10,133 billions) of GDP while government final
                                    consumption expenditure was 17 percent (Frw 2,338 billion) which sum up to 91% of overall GDP at current price. 
                                    Gross capital formation was estimated at 24 percent (Frw 3,359 billions) of GDP.",
                                  br(),
                                  br(),
                                  "Total final consumption expenditure is combination of government expenditure and private (household, NGOs) expenditure.",
                                  br(),
                                  "Cross capital formation is combination all investments.",
                                  br(),
                                  "Resourse balance is difference of exported goods and services and imported goods and services.",
                                  br(),
                                  br(),
                                  width = 9, status = "info")))),
                          br(),
                tabPanel("Growth rate",
                         fluidRow(  box(title = "Trend of expendicture growth rate",status = "warning", height= 700, width = 12,
                                        br(),
                                        br(),
                                        plotlyOutput("expenditure_growth_rate"),
                                        br(),
                                        br(),
                                        box(title = "Notes", "This trend of growth rate graph, shows an insight in how the GDP has evolved over time. 
                                            In 2020, growth rate significantly dropped from 12.1% in 2019 to 3.1% due to COVID19 pandemic.",
                                            br(),
                                            "After COVID19, growth rate resumed an uptrend where in 2022 growth rate reaches 25.5%", status = "info")),
                                    br(),
                                    br(),
                                    box(title = "Trend of implicity GDP deflator growth rate", status = "warning", height= 730, width = 12,
                                        br(),
                                        br(),
                                        plotlyOutput("expenditure_implicity_gdp_growth_rate"),
                                        br(),
                                        br(),
                                        box(title = "Notes", "This is the measure of changes in prices of all goods and services produced in an economy.",
                                            br(),
                                            br(),
                                            "The rate of change in prices were low since 2010 until 2016, and in 2017 the rate skyrocketted by 3.1%, and in 2018 rate dropped by 8.7%. 
                                            In 2022, rate skyrocketted by 13.3% due to Russian - Ukrain war started in February 2022.", status = "info")))))),
              ),
      
                
      tabItem(tabName = "GDP",
              fluidRow(box(
                title = "Percentage Contribution of Each Industry to 2022 GDP, Estmated at Frw 13,716 billions",
                width = 12,
                status = "success",
                height = 1350,
                br(),
                tabItem(tabName = "Box",
                        valueBox(
                          value =GDP$INDUSTRY ,  
                          subtitle = "Contribution of Industries",
                          icon = icon("bar-chart"),
                          color = "teal"
                        ),
                        
                        valueBox(
                          value =GDP$`AGRICULTURE, FORESTRY & FISHING` ,  
                          subtitle = "Contribution of Agriculture, Forestry & Fishing",
                          icon = icon("area-chart"),
                          color = "green"
                        ),
                        valueBox(
                          value =GDP$SERVICES ,  
                          subtitle = "Contribution of Services",
                          icon = icon("university"),
                          color = "blue"
                        ),
                        valueBox(
                          value =GDP$`TAXES LESS SUBSIDIES ON PRODUCTS` ,  
                          subtitle = "Contribution of Taxes Less Subsidies on Product",
                          icon = icon("coins"),
                          color = "orange",
                        
                        ),
                        br(),
                        tabItem(tabName = "bar_chart",
                                box(
                                  br(),
                                  br(),
                                  title = "Variation of Percentage GDP growth From 2017- 2022.",
                                  width = 9,
                                  status = "success",
                                  height = 990,
                                  box(plotlyOutput("barChart", width = 700), width = 12, height = 890, status = "success",
                                  
                                      br(),
                                      br(),
                                  box(title = "Gross Domestic Product and its Main Sectors",
                                      "In 2022, GDP at current market prices was estimated at Frw 13,716 billion, up from Frw 10.930
                                      billion in 2021. Services sector contributed 47 percent of GDP, Agriculture sector contributed 25
                                      percent of the GDP, and Industry sector contributed 21 percent of GDP while 7 percent was
                                      attributed to adjustment for taxes less subsidies on products.", width = 12, status = "info"),
                                  box(title =  "Growth rate by kind of activity",
                                      "In 2022, the economy continued to grow throughout the year. GDP growth was 7.9 percent in the
                                      first quarter, 7.5 percent in the second quarter, 10 percent in the third quarter and 7.3 percent in
                                      the fourth quarter. This led the year 2022 to grow by 8.2 percent when compared to 2021.",
                                      br(),
                                      br(),
                                      
                                      "In agriculture, the growth was 2 percent and contributed 0.4 percentage points to the overall
                                      growth.",
                                      br(),
                                      br(),
                                      
                                      "In industry, the growth was 5 percent and contributed 0.9 percentage points to the overall growth.",
                                      br(),
                                      br(),
                                      "In Services, the overall growth in service sector was 12 percent and contributed 5.7 percentage points to overall growth.", width = 12, status = 
                                        "info")),
                                  
                                ))),
                ),
              )),
      
      tabItem(tabName = "help",
              box(title = "Guidance on using this dashboard.", width = 50, height = 1050,  #status = "info",
                  br(),
                  
"_____________________________________________________CPI and GDP Dashboard_______________________________________________________",
br(),
br(),


"Welcome to the CPI and GDP Dashboard! This interactive Shiny dashboard allows you to explore the trends in the Consumer Price Index (CPI), 
the percentage contributions of Main Categories, Variation in CPI (inflation rate) Comparing prices in both rural and urban economies, additionally, 
You will navigate through GDP Tabs to get insight about GDP growth rate over years, Percentage Contribution of Each Industry to GDP, and expenditure GDP.",
br(),
br(),

" Author: Maurice HIRWA UWIMANA and MUGABO Jeanforbin",
br(),
  "Date: November 30, 2023",
br(),
br(),

"Getting Started",
br(),
br(),

"Follow these steps to set up and explore the CPI and GDP Dashboard:",
br(),
br(),

"1. There are three ways you can this dashboard:",
br(),
"I. Open this link https://mauxos.shinyapps.io/CPI_GDP_Report/ to access R markdown; an interactive report.",
br(),
"II. Open this link https://mauxos.shinyapps.io/CPI_GDP_Dashboard/ to access dashboard from any website you prefer.",
br(),
"III. Open this link https://github.com/MauxOs/NISR_HACKATHON_FINAL to access all related files to this app from github website.",
br(),
br(),

"2. Main R packages to be installed are: 'shiny', 'shinydashboard, 'plotly', 'tidyverse', 'readxl',
,'googlesheets4', 'shinythemes'. But don't worry we have included them within R script to ease your job.",
br(),
br(),

"3.  Remember to first download used dataset.
    Simply, download R sript and excel file which contains all sheets we used to build this app, and then store them in single folder, 
then you run the app without changing anything like file path, the app itself will sort it out.",

br(),
"Note, if you use first two links which take you to shinyapp.io, you will never need to download anything, just click the link and then navigate the app.",
 br(),
br(),

"4. Rscript: 'app.R' : Run the R code by double clicking this file and then inside RStudio, click RunApp button in upper-left corner.",
br(),
br(),

"5. Access the Dashboard: After running the app by clicking RunApp button, the app will appear/open in the pop up window and also in console, 
it will show you the URL which can be used to view/navigate the app within the preferred web browser. An example of URL you will find in your console: 
http://127.0.0.1:4788. Copy and paste the URL in preferred web browser then, boom!",
br(),
br(),

"6. Features:",
br(),
br(),
   "- Explore CPI trends over time.
   - Visualize the percentage contributions of different categories to CPI in rural and urban areas.
   - Examine the rate of change of CPI on monthly and annual basis, and consider reading comments added underneath.
   - Eplore GDP growth rate since 2017 up to 2022
   - Get insight on percentage contribution of each industry to GDP.
   - Interactive hover features for detailed insights.",
br(),
br(),

"7. Data Sources:",
br(),
br(),

"We have utilised CPI and GDP dataset which can be found here: https://www.statistics.gov.rw/publication/1873 and https://www.statistics.gov.rw/publication/1914. 
The main sheets (retrieved data) we utilised are included in github repository I shared earlier.",
br(),
br(),

"8. Feedback:",
br(),
br(),

"If you have any feedback, suggestions, or issues, please feel free to contact us at mauriceuhirwa@gmail.com and mjeanforbin@gmail.com.
If you would like to have data in google sheet to work cloudly, don't hesitate to contact us to share the link with you!",
br(),
br(),


   "Happy exploring!",
                  status= "primary")),
      
      tabItem(tabName = "pie_chart",
              box(
                title = "Interactive pie charts presenting percentage weights of main categories to CPI IN Rural and Urban areas & Other Selected Urban indices.",
                br(),
                br(),
                
                plotlyOutput("Plot0"),
                width = 15,
                br(),
                
                plotlyOutput("Plot1"),
                br(),
                br(),
                
                plotlyOutput("Plot2"),
                br(),
                
                box(
                  title = "Notes",
                  "Delve into yearly variations and witness how certain sectors influence CPI dynamics differently each year.",br(),br(),
                  "Hover over each sector to interactively explore its contribution, providing a nuanced understanding of the economic landscape.", br(),br(),
                  "These pie charts offer insights into how each sector’s contribution influences inflation, painting a comprehensive picture of economic dynamics.",br(),br(),
                  
                  status = "primary"
                ),
                
                box(
                  title = "Brief Overview",
                  "Explore the urban CPI landscape, where “Food and non-alcoholic beverages”, 
            “Housing, water, electricity, gas, and other fuels”, and “Transport” play pivotal roles 
            in shaping economic trends.",br(), br(),"In rural areas, the CPI is shaped by the significant contributions of “Food and non-alcoholic beverages”, 
            “Vegetables”, and “Housing, water, electricity, gas, and other fuels”.",br(), br()," Notice the noteworthy impact of “Food and non-alcoholic beverages”, “Housing, water, electricity, gas, and other fuels”, 
            and “Vegetables” on the CPI in both rural and urban settings.",
                  status = "info"
                ),
                
                box(
                  title = "Brief Description",
                  "Other selected urban indices, the CPI is shaped by the significant contributions of “General index excluding fresh products and energy”, “Local goods index”, 
                  and “Food and non-alcoholic beverages”.",
                  
                  status = "info"
                ),
                
                box(
                  title = "Note",
                  "These pie charts offer insights into how each sector’s contribution influences inflation, painting a comprehensive picture of economic dynamics.",br(),
                  
                  status = "primary"
                ),
                
                box("Thank you!",status = "success")
              ),
      )
    )
  ) 
) 

# Define server logic
server <- function(input, output) {
  # Reactive plot
  
  #Google Sheets API authentication flow ----
  

  #options(gargle_oauth_cache = ".cache") # designate project-specific cache
  #gargle::gargle_oauth_cache() # check the value of the option
  #googlesheets4::gs4_auth()# trigger auth on purpose to store a token in the specified cache
  cache_directory <- ".cache/" # can add to config file
  #list.files(cache_directory) # see your token file in the cache
  #googlesheets4::gs4_deauth() # de auth
  
  gs4_auth(email = "mauriceuhirwa@gmail.com", cache = cache_directory)
  
  CPI <- read_sheet(gs4_get("https://docs.google.com/spreadsheets/d/1uqp89asCG7_vhEawe6CjMyEsszREKvtvGIxiCFH_7oI/edit?pli=1#gid=1263202409"), 
                    sheet = "All Rwanda")
  
  GDP <- read_sheet(gs4_get("https://docs.google.com/spreadsheets/d/1uqp89asCG7_vhEawe6CjMyEsszREKvtvGIxiCFH_7oI/edit?pli=1#gid=1263202409"), 
                    sheet = "Contribution")
  
  GDP_growth_rate <- read_sheet(gs4_get("https://docs.google.com/spreadsheets/d/1uqp89asCG7_vhEawe6CjMyEsszREKvtvGIxiCFH_7oI/edit?pli=1#gid=1263202409"), 
                                sheet = "Growth rate")
  
  
  urban_CPI <- read_sheet(gs4_get("https://docs.google.com/spreadsheets/d/1uqp89asCG7_vhEawe6CjMyEsszREKvtvGIxiCFH_7oI/edit?pli=1#gid=1263202409"),  
                          sheet = "Urban")
  
  rural_CPI <- read_sheet(gs4_get("https://docs.google.com/spreadsheets/d/1uqp89asCG7_vhEawe6CjMyEsszREKvtvGIxiCFH_7oI/edit?pli=1#gid=1263202409"), 
                          sheet = "Rural")
  
  
  others_CPI <- read_sheet(gs4_get("https://docs.google.com/spreadsheets/d/1uqp89asCG7_vhEawe6CjMyEsszREKvtvGIxiCFH_7oI/edit?pli=1#gid=1263202409"),  
                           sheet = "Other")
  
  CPI_CHANGE_ANNUAL <- read_sheet(gs4_get("https://docs.google.com/spreadsheets/d/1uqp89asCG7_vhEawe6CjMyEsszREKvtvGIxiCFH_7oI/edit?pli=1#gid=1263202409"), 
                                  sheet = "Annual")
  
  CPI_CHANGE_MONTHLY <- read_sheet(gs4_get("https://docs.google.com/spreadsheets/d/1uqp89asCG7_vhEawe6CjMyEsszREKvtvGIxiCFH_7oI/edit?pli=1#gid=1263202409"),  
                                   sheet = "Monthly")
  
  Expendicture_on_GDP <- read_sheet(gs4_get("https://docs.google.com/spreadsheets/d/1uqp89asCG7_vhEawe6CjMyEsszREKvtvGIxiCFH_7oI/edit?pli=1#gid=1263202409"),  
                                    sheet = "Expenditure")
  
  GDP_2022 <- read_sheet(gs4_get("https://docs.google.com/spreadsheets/d/1uqp89asCG7_vhEawe6CjMyEsszREKvtvGIxiCFH_7oI/edit?pli=1#gid=1263202409"),  
                         sheet = "GDP2022")
  
  GDP_expenditure_growth <- read_sheet(gs4_get("https://docs.google.com/spreadsheets/d/1uqp89asCG7_vhEawe6CjMyEsszREKvtvGIxiCFH_7oI/edit?pli=1#gid=1263202409"),
                                       sheet = "GDP Growth rate")
  
  
  
  output$lineChart <- renderPlotly({
    # Create line chart based on selected variable
    
    
    Trend <- plot_ly(CPI, x = ~Date, y = ~get(input$variable), type = 'scatter', mode = 'lines', fill='tozeroy', 
                     color = I("blue"),
                     name = input$variable) %>%
      layout(title =paste("Trend of",input$variable,paste("in Rwanda")),
             xaxis = list(title = "Time"),
             yaxis = list(title = paste("Values of",input$variable)))
    
  })
  
  
  
  output$Plot0 <- renderPlotly({
    
    Urban_plot <- plot_ly(urban_CPI, labels = urban_CPI$ITEM, values = urban_CPI$Weights, type = "pie", textinfo = "percent", 
                          insidetextfont = list(color = "white"), 
                          
                          marker = list(line = list(color = "white", width = 6))) %>%
      layout(title = "Percentage Weight of Each Category To CPI In Urban Area")
    
    
    Urban_plot
    
  })
  
  
  output$Plot1 <- renderPlotly({
    
    rural_plot <- plot_ly(rural_CPI, labels = rural_CPI$ITEM, values = rural_CPI$Weights, type = "pie", textinfo = "percent", 
                          insidetextfont = list(color = "white"), 
                          
                          marker = list(line = list(color = "white", width = 6))) %>%
      
      layout(title = "Percentage Weight of Each Category To CPI In Rural Area")
    
    
    rural_plot
    
  }) 
  
  
  output$Plot2 <- renderPlotly({
    
    other_plot <- plot_ly(others_CPI, labels = others_CPI$ITEM, values = others_CPI$Weights, type = "pie", textinfo = "percent", 
                          insidetextfont = list(color = "white"), 
                          
                          marker = list(line = list(color = "white", width = 6))) %>%
      layout(title = "Percentage Weight of Each Category To CPI In Other Selected Urban Indices")
    
    
    other_plot
    
  }) 
  
  
  output$barChart <- renderPlotly({
    # Create line chart based on selected variable
    
    
    fig <- plot_ly(GDP_growth_rate, x = ~Date, y = ~get(input$barvariable), type = 'bar', 
                   color = I("maroon"),
                   name = input$barvariable) %>%
      layout(title =paste("Growth rate of",input$barvariable,paste("in Rwanda")),
             xaxis = list(title = "Time"),
             yaxis = list(title = paste("% Contribution of ",input$barvariable)))
  })
  
  output$lineChart1 <- 
    renderPlotly({
      plot_ly(CPI_CHANGE_ANNUAL,x = ~CPI_CHANGE_ANNUAL$Date) %>%
        add_lines(y = ~CPI_CHANGE_ANNUAL$`Urban CPI Annual Change`, name = "Urban CPI Annual Change", line = list(color = "blue")) %>%
        add_lines( y = ~CPI_CHANGE_ANNUAL$`Rural CPI Annual Change`, name = "Rural CPI Annual Change", line = list(color = "red", dash = "dash")) %>%
        add_lines( y = ~CPI_CHANGE_ANNUAL$`Rwanda CPI Annual Change`, name = "Rwanda CPI Annual Change", line = list(color = "green")) %>% 
        layout(title = "Annual variation of CPI",
               xaxis = list(title = "Date"),
               yaxis = list(title = "CPI Value in %"))
      
    })
  
  
  output$lineChart2 <- 
    renderPlotly({
      plot_ly(CPI_CHANGE_MONTHLY,x = ~CPI_CHANGE_MONTHLY$Date) %>%
        add_lines(y = ~CPI_CHANGE_MONTHLY$`Urban CPI Monthly Change`, name = "Urban CPI Monthly Change", line = list(color = "blue")) %>%
        add_lines( y = ~CPI_CHANGE_MONTHLY$`Rural CPI Monthly Change`, name = "Rural CPI Monthly Change", line = list(color = "red", dash = "dash")) %>%
        add_lines( y = ~CPI_CHANGE_MONTHLY$`Rwanda CPI Monthly Change`, name = "Rwanda CPI Monthly Change", line = list(color = "green")) %>% 
        layout(title = "Monthly variation of CPI",
               xaxis = list(title = "Date"),
               yaxis = list(title = "CPI Value in %"))
      
    })
  output$expenditure <-renderPlotly({
    
    plot_ly(Expendicture_on_GDP,x = ~Expendicture_on_GDP$Date) %>%
      add_bars(y = ~Expendicture_on_GDP$`Total final consumption expenditure`, name = "Total final consumption expenditure") %>%
      add_bars( y = ~Expendicture_on_GDP$`Gross capital formation`, name = "Gross capital formation") %>%
      add_bars( y = ~Expendicture_on_GDP$`Resource balance`, name = "Resource balance") %>% 
      add_bars( y = ~Expendicture_on_GDP$`Exports of goods & services`, name = "Exports of goods & services") %>%
      add_bars( y = ~Expendicture_on_GDP$`Imports of goods & services`, name = "Imports of goods & services") %>%
      layout(title = "Trend of  expendicture on GDP at current prices",
             xaxis = list(title = "Date"),
             yaxis = list(title = "Billions (RWF)",tickformat = "billions"))
  })
  
  output$expenditure_on_GDP <- renderPlotly({
    plot_ly(labels = GDP_2022$Valiable,values = GDP_2022$Value,hole=0.3,type="pie" ) %>% 
      layout(
        annotations= list(
          x=0.5,
          y=0.5,
          text= "13,716 Billions",showarrow=FALSE
        )
      )
    
  })
  
  output$expenditure_growth_rate <-renderPlotly({
    plot_ly(GDP_expenditure_growth,x = ~GDP_expenditure_growth$Date,y = ~GDP_expenditure_growth$`GDP at current prices growth rate`,
            type = "bar",color = I("brown")) %>% 
      add_lines(y = ~GDP_expenditure_growth$`GDP at current prices growth rate`, name = "GDP at current prices growth rate", line = list(color = "blue")) %>% 
      layout(title = "Growth rate of GDP at current price",
             xaxis = list(title = "Date"),
             yaxis = list(title = "values in (%)"))
    
  })
  
  output$expenditure_implicity_gdp_growth_rate <-renderPlotly({
    
    plot_ly(GDP_expenditure_growth,x = ~GDP_expenditure_growth$Date,y = ~GDP_expenditure_growth$`Implicit GDP deflator growth rate`,
            type = "bar",color = I("blue")) %>% 
      add_lines(y = ~GDP_expenditure_growth$`Implicit GDP deflator growth rate`, name = "Implicit GDP deflator growth rate", line = list(color = "red")) %>% 
      layout(title = "Growth rate of implicit GDP deflator",
             xaxis = list(title = "Date"),
             yaxis = list(title = "values in (%)"))
  })
}

# Run the Shiny App
shinyApp(ui, server)

