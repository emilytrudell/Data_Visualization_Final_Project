# Shiny Application - Asthma Exacerbation Risk Score Profile

library(shiny)
library(data.table)
library(plotly)
packageVersion('plotly')


# Define UI for app - fluid page to automatically size app to fit user window
ui <- fluidPage(
  
  # app title
  titlePanel("Asthma Exacerbation Risk Score Profile"),
  
  # Sidebar input
  sidebarLayout(
    sidebarPanel(
      helpText("Answer the following questions about your patient's current health status."),
      helpText("Click 'Calculate Score' to see a detailed asthma risk profile. 
               Select 'No' if an answer is unknown"),
      helpText("Select 'No' if an answer is unknown"),
      #User inputs
      #patient current age variable - enter as continuous
      sliderInput("age", "Select the patient's age (in years)", min=0, max=26, value="years", step=1
      ),
      #Outpatient exacerbations within the last 12 months - 2 points for yes
      radioButtons("outpt", "Has the patient been treated in the office setting for an asthma exacerbation the last 12 months?",
                   choices= c("No"=0, "Yes"=2, "Unknown"=NULL),
                   inline = TRUE
      ),
      #Emergency department exacerbations within the last 12 months - 1 point for yes
      radioButtons("ed", "Has the patient been treated in an emergency department for an asthma exacerbation the last 12 months?",
                   choices= c("No"=0, "Yes"=1, "Unknown"=NULL),
                   inline = TRUE
      ),
      #Inpatient excerbations within the last 12 months - 1 point for yes
      radioButtons("inpt", "Has the patient been treated in a hospital inpatient setting for an asthma exacerbation the last 12 months?",
                   choices= c("No"=0, "Yes"=1, "Unknown"=NULL),
                   inline = TRUE
      ),
      #Any asthma medications filled in the last 12 months - 5 points for yes
      radioButtons("med_fill_yn", "Has patient filled at least one asthma medication within the last 12 months?",
                   choices= c("No"=0, "Yes"=5, "Unknown"=NULL),
                   inline = TRUE
      ),
      #Inhaled steroid combination medication filled in the last 12 months - 3 points for yes
      radioButtons("isc_fill_yn", "Has patient filled at least one inhaled steroid combination medication within the last 12 months?",
                   choices= c("No"=0, "Yes"=3, "Unknown"=NULL),
                   inline = TRUE
      ),      
      #Oral steroid medication filled in the last 12 months - 2 points for yes
      radioButtons("os_fill_yn", "Has patient filled at least one inhaled steroid combination medication within the last 12 months?",
                   choices= c("No"=0, "Yes"=2, "Unknown"=NULL),
                   inline = TRUE
      ),      
      #Concurrent diagnosis of any allergy - 1 point for yes
      radioButtons("allergy", "Has the patient been diagnosed with any environmental or food allergies?",
                   choices= c("No"=0, "Yes"=1, "Unknown"=NULL),
                   inline = TRUE
      ),    
      #Count of non-exacerbation outpatient visits within the last 12 months - enter as continuous
      sliderInput("outpt_maint_vis", "Enter the number of times the patient has been seen in the office for a non-exacerbation asthma visit within the last 12 months",
                  min=0, max=10, value="years", step=1
      ),
      #Calculate score button - prevents score from calculating while user is entering data
      submitButton("Calculate Score")
      
      ),
    
    
    # Plots with text headers
    mainPanel(
      fluidRow(
        #AER Score
        strong(textOutput(outputId = "score_text1")),
        textOutput(outputId = "score_text2"),
        splitLayout(cellWidths = c("50%","50%"),
                    textOutput(outputId = "score_text3"),
                    textOutput(outputId = "score_text4")),
        splitLayout(cellWidths = c("50%","50%"),
                    plotlyOutput(outputId = "score_plot1"),
                    plotlyOutput(outputId = "score_plot2")),
        #age variable
        strong(textOutput(outputId = "age_text1")),
        splitLayout(cellWidths = c("50%","50%"),
        textOutput(outputId = "age_text2"),
        textOutput(outputId = "age_text3")),
        splitLayout(cellWidths = c("50%","50%"),
                    plotlyOutput(outputId = "age_plot1"),
                    plotlyOutput(outputId = "age_plot2")),
        #outpatient exacerbation variable
        strong(textOutput(outputId = "outpt_text1")),
        splitLayout(cellWidths = c("50%","50%"),
                    textOutput(outputId = "outpt_text2"),
                    textOutput(outputId = "outpt_text3")),
        splitLayout(cellWidths = c("50%","50%"),
                    plotlyOutput(outputId = "outpt_plot1"),
                    plotlyOutput(outputId = "outpt_plot2")),
        #ed exacerbation variable
        strong(textOutput(outputId = "ed_text1")),
        splitLayout(cellWidths = c("50%","50%"),
                    textOutput(outputId = "ed_text2"),
                    textOutput(outputId = "ed_text3")),
        splitLayout(cellWidths = c("50%","50%"),
                    plotlyOutput(outputId = "ed_plot1"),
                    plotlyOutput(outputId = "ed_plot2")),
        #inpatient exacerbation variable
        strong(textOutput(outputId = "inpt_text1")),
        splitLayout(cellWidths = c("50%","50%"),
                    textOutput(outputId = "inpt_text2"),
                    textOutput(outputId = "inpt_text3")),
        splitLayout(cellWidths = c("50%","50%"),
                    plotlyOutput(outputId = "inpt_plot1"),
                    plotlyOutput(outputId = "inpt_plot2")),
        #any medication filled variable
        strong(textOutput(outputId = "med_fill_text1")),
        textOutput(outputId = "med_fill_text2"),
        splitLayout(cellWidths = c("50%","50%"),
                    textOutput(outputId = "med_fill_text3"),
                    textOutput(outputId = "med_fill_text4")),
        splitLayout(cellWidths = c("50%","50%"),
                    plotlyOutput(outputId = "med_fill_plot1"),
                    plotlyOutput(outputId = "med_fill_plot2")),
        #inhaled steroid combination fill variable
        strong(textOutput(outputId = "isc_fill_text1")),
        textOutput(outputId = "isc_fill_text2"),
        splitLayout(cellWidths = c("50%","50%"),
                    textOutput(outputId = "isc_fill_text3"),
                    textOutput(outputId = "isc_fill_text4")),
        splitLayout(cellWidths = c("50%","50%"),
                    plotlyOutput(outputId = "isc_fill_plot1"),
                    plotlyOutput(outputId = "isc_fill_plot2")),
        #oral steriod fill variable
        strong(textOutput(outputId = "os_fill_text1")),
        textOutput(outputId = "os_fill_text2"),
        splitLayout(cellWidths = c("50%","50%"),
                    textOutput(outputId = "os_fill_text3"),
                    textOutput(outputId = "os_fill_text4")),
        splitLayout(cellWidths = c("50%","50%"),
                    plotlyOutput(outputId = "os_fill_plot1"),
                    plotlyOutput(outputId = "os_fill_plot2")),
        #concurrent allergy diagnosis variable
        strong(textOutput(outputId = "allergy_text1")),
        splitLayout(cellWidths = c("50%","50%"),
                    textOutput(outputId = "allergy_text2"),
                    textOutput(outputId = "allergy_text3")),
        splitLayout(cellWidths = c("50%","50%"),
                    plotlyOutput(outputId = "allergy_plot1"),
                    plotlyOutput(outputId = "allergy_plot2")),
        #outpatient maintenance viit variable
        strong(textOutput(outputId = "outpt_maint_vis_text1")),
        textOutput(outputId = "outpt_maint_vis_text2"),
        splitLayout(cellWidths = c("50%","50%"),
                    textOutput(outputId = "outpt_maint_vis_text3"),
                    textOutput(outputId = "outpt_maint_vis_text4")),
        splitLayout(cellWidths = c("50%","50%"),
                    plotlyOutput(outputId = "outpt_maint_vis_plot1"),
                    plotlyOutput(outputId = "outpt_maint_vis_plot2"))
      )
    )
  )
)




# Define server logic to plot variables
server <- function(input, output) {
  
  
  #evaluate user inputs
  #age - continuous variable, break into groups
  age_val             <- reactive({input$age})
  age_points          <- reactive(if (age_val()<7) 2 else (if (age_val()<12) 1 else 0))
  age_points_txt      <- reactive(if (age_val()<7) {"2 points"} else (if (age_val()<12) {"1 point"} else {"0 points"}))
  age_group           <- renderText({if (age_val()<7) {"less than 7"} else (if (age_val()<12) {"between 7 and 11"} else {"older than 11"}) })
  age_group_pct       <- renderText({if (age_val()<7) {"25%"} else (if (age_val()<12) {"36%"} else {"39%"}) })
  age_group_risk_txt  <- renderText({if (age_val()<7) {"2% of patients younger than age 7 have an asthma exacerbation in the next 12 months, twice the risk of an asthma exacerbation than patients 12 and older"} 
    else (if (age_val()<12) {"1.4 % or patients between ages 7 and 11 have an asthma exacerbation in the next 12 months, 1.5 times the risk of an asthma exacerbation than patients 12 or older"} 
          else {"1% of patients age 12 and older have an asthma exacerbation in the next 12 months. Older patients are not at an increased risk due to age alone"}) })
  #outpatient exacerbations - yes/no variable
  outpt_points        <- renderText({as.numeric(input$outpt)})
  outpt_points_txt       <- renderText({if (outpt_points()==0) {"0 points"} else {"2 points"} })
  outpt_group            <- renderText({if (outpt_points()==0) {"No events in the last 12 months"} else {"At least one event in the last 12 months"} })
  outpt_group_pct        <- renderText({if (outpt_points()==0) {"99% of patients did not receive outpatient care for an asthma exacerbation in the last 12 months"} else {"Only 1% of patients received outpatient care for an asthma exacerbation in the last 12 months"} })
  outpt_group_risk_txt   <- renderText({if (outpt_points()==0) {"1% of patients without an outpatient asthma event in the last 12 months have an asthma exacerbation in the next 12 months"} 
    else {"25% of patients who had an outpatient event for asthma in the last 12 months have another asthma exacerbation in the next 12 months, 28 times the risk of those without an event in the last 12 months"} })
  #ed exacerbations - yes/no variable
  ed_points           <- renderText({as.numeric(input$ed)})
  ed_points_txt       <- renderText({if (ed_points()==0) {"0 points"} else {"1 point"} })
  ed_group            <- renderText({if (ed_points()==0) {"No events in the last 12 months"} else {"At least one event in the last 12 months"} })
  ed_group_pct        <- renderText({if (ed_points()==0) {"99.7% of patients did not have an ED event for asthma in the last 12 months"} else {"Only 0.3% of patients had an ED event for asthma in the last 12 months"} })
  ed_group_risk_txt   <- renderText({if (ed_points()==0) {"1.3% of patients without an ED event in the last 12 months have an asthma exacerbation in the next 12 months"} 
    else {"19% of patients who had an ED event for asthma in the last 12 months have another asthma exacerbation in the next 12 months, 17 times the risk of those without an event in the last 12 months"} })
  #inpatient exacerbations - yes/no variable
  inpt_points           <- renderText({as.numeric(input$inpt)})
  inpt_points_txt       <- renderText({if (inpt_points()==0) {"0 points"} else {"1 point"} })
  inpt_group            <- renderText({if (inpt_points()==0) {"No hospitalizations for asthma in the last 12 months"} else {"At least one hospitalization for asthma in the last 12 months"} })
  inpt_group_pct        <- renderText({if (inpt_points()==0) {"99.9% of patients did not have an inpatient hospitalization for asthma in the last 12 months"} else {"Only 0.1% of patients had an hospitalization event for asthma in the last 12 months"} })
  inpt_group_risk_txt   <- renderText({if (inpt_points()==0) {"1.4% of patients without an inpatient hospitalization in the last 12 months have an asthma exacerbation in the next 12 months"} 
    else {"17% of patients who had an inpatient hospitalization for asthma in the last 12 months have another asthma exacerbation in the next 12 months, 15 times the risk of those without a hospitalization in the last 12 months"} })
  #asthma medication fills - yes/no variable
  med_fill_points           <- renderText({as.numeric(input$med_fill_yn)})
  med_fill_points_txt       <- renderText({if (med_fill_points()==0) {"0 points"} else {"5 points"} })
  med_fill_group            <- renderText({if (med_fill_points()==0) {"No asthma medications filled in last 12 months"} else {"At least one asthma medication filled in the last 12 months"} })
  med_fill_group_pct        <- renderText({if (med_fill_points()==0) {"90% of patients did not fill a prescription for an asthma medication in the last 12 months"} else {"10% of patients filled a prescription for an asthma medication in the last 12 months"} })
  med_fill_group_risk_txt   <- renderText({if (med_fill_points()==0) {"0.6% of patients without an asthma medication prescription the last 12 months have an asthma exacerbation in the next 12 months"} 
    else {"8% of patients who have been prescribed a medication asthma in the last 12 months have an asthma exacerbation in the next 12 months, 15 times the risk of those without a prescription"} })
  #inhaled steroid combo medication fills - yes/no variable
  isc_fill_points           <- renderText({as.numeric(input$isc_fill_yn)})
  isc_fill_points_txt       <- renderText({if (isc_fill_points()==0) {"0 points"} else {"3 points"} })
  isc_fill_group            <- renderText({if (isc_fill_points()==0) {"No inhaled steroid combination medications filled in last 12 months"} else {"At least one inhaled steroid combination medication filled in the last 12 months"} })
  isc_fill_group_pct        <- renderText({if (isc_fill_points()==0) {"99.7% of patients did not fill a prescription for an inhaled steroid combination medication in the last 12 months"} else {"0.3% of patients filled a prescription for an inhaled steroid combination medication in the last 12 months"} })
  isc_fill_group_risk_txt   <- renderText({if (isc_fill_points()==0) {"1% of patients without an inhaled steroid combination medication prescription in the last 12 months have an asthma exacerbation in the next 12 months"} 
    else {"28% of patients who have been prescribed an inhaled steroid combination medication in the last 12 months have an asthma exacerbation in the next 12 months, 22 times the risk of those without a prescription"} })
  #oral steroid medication fills - yes/no variable
  os_fill_points           <- renderText({as.numeric(input$os_fill_yn)})
  os_fill_points_txt       <- renderText({if (os_fill_points()==0) {"0 points"} else {"2 points"} })
  os_fill_group            <- renderText({if (os_fill_points()==0) {"No oral steroid medications filled in last 12 months"} else {"At least one oral steroid medication filled in the last 12 months"} })
  os_fill_group_pct        <- renderText({if (os_fill_points()==0) {"95% of patients did not fill a prescription for an oral steroid medication in the last 12 months"} else {"5% of patients filled a prescription for an oral steroid medication in the last 12 months"} })
  os_fill_group_risk_txt   <- renderText({if (os_fill_points()==0) {"1% of patients without an oral steroid medication prescription the last 12 months have an asthma exacerbation in the next 12 months"} 
    else {"10% of patients who have been prescribed an oral steroid medication in the last 12 months have an asthma exacerbation in the next 12 months, 10 times the risk of those without a prescription"} })
  #concurrent allergy diagnosis - yes/no variable
  allergy_points           <- renderText({as.numeric(input$allergy)})
  allergy_points_txt       <- renderText({if (allergy_points()==0) {"0 points"} else {"1 point"} })
  allergy_group            <- renderText({if (allergy_points()==0) {"No concurrent allergy diagnosis"} else {"Patient has at least one concurrent allergy"} })
  allergy_group_pct        <- renderText({if (allergy_points()==0) {"85% of patients do not carry an allergy diagnosis"} else {"15% of patients carry an allergy diagnosis"} })
  allergy_group_risk_txt   <- renderText({if (allergy_points()==0) {"1% of patients without an allergy diagnosis have an asthma exacerbation within the next 12 months"} 
    else {"3% of patients who carry a concurrent allergy diagnosis have an asthma exacerbation in the next 12 months, 3 times the risk of those without any allergy"} })
  
  #outpatient maintence visits - continuous variable, break into groups
  outpt_maint_vis_val             <- reactive({input$outpt_maint_vis})
  outpt_maint_vis_points          <- reactive(if (outpt_maint_vis_val()<2) 0 else (if (outpt_maint_vis_val()<7) 2 else 5))
  outpt_maint_vis_points_txt      <- reactive(if (outpt_maint_vis_val()<2) {"0 points"} else (if (outpt_maint_vis_val()<7) {"2 points"} else {"5 points"}))
  outpt_maint_vis_group           <- renderText({if (outpt_maint_vis_val()<2) {"1 or no"} else (if (outpt_maint_vis_val()<7) {"between 2 and 6"} else {"more than 6"}) })
  outpt_maint_vis_group_pct       <- renderText({if (outpt_maint_vis_val()<2) {"96%"} else (if (outpt_maint_vis_val()<7) {"4%"} else {"0.1%"}) })
  outpt_maint_vis_group_risk_txt  <- renderText({if (outpt_maint_vis_val()<2) {"1% of patients with 1 or no asthma visit in the last 12 months have an asthma exacerbation in the next 12 months"} 
    else (if (outpt_maint_vis_val()<7) {"11% or patients seen 2-6 times in the office for asthma within the last 12 months have an asthma exacerbation in the next 12 months, 12 times the risk of an asthma exacerbation than patients with one or no visits"} 
          else {"32% of patients who have been seen more than 6 times in the office for asthma within the last 12 months have an asthma exacerbation in the next 12 months, 33 times the risk of an asthma exacerbation than patients with one or no visits"}) })
  
  
  #Calculate asthma risk score - sum of points for each element
  Total_points          <- function() { age_points()+
      as.numeric(input$outpt) + 
      as.numeric(input$ed) +
      as.numeric(input$inpt) + 
      as.numeric(input$med_fill_yn) +
      as.numeric(input$isc_fill_yn) +
      as.numeric(input$os_fill_yn) +
      as.numeric(input$allergy) +
      as.numeric(input$outpt_maint_vis)
  }
  
  #test for score evaluation
  score_txt2      <- reactive({if (Total_points()<7) {"No referral to Medical Home Asthma Program"} 
    else (if (Total_points()<9) {"Consider referring the patient to the Medical Home Asthma Program"} 
          else (if (Total_points()<12) {"Refer the patient to the Medical Home Asthma Program"} 
                else {"Refer the patient to the Medical Home Asthma Program"}))})
  score_txt3      <- reactive({if (Total_points()<7) {"95% of all patients have a risk score less than 7"} 
    else (if (Total_points()<9) {"3% of patients have a risk score of 8 or 9"} 
          else (if (Total_points()<12) {"2% of patients have a risk score between 9 and 11"} 
                else {"0.5% of patients have a risk score of 12 or greater"}))})
  score_txt4      <- reactive({if (Total_points()<7) {"Patients with a risk score less than 7 have low risk for an asthma exacerbation within the next 12 months"} 
    else (if (Total_points()<9) {"Patients with a risk score of 7 or 8 have a slightly elevated risk of an asthma exacerbation within the next 12 months"} 
          else (if (Total_points()<12) {"Patients with a risk score between 9 and 11 have a moderate risk of an asthma exacerbation within the next 12 months"} 
                else {"Patients with a risk score of 12 or greater have a high risk of an asthma exacerbation within the next 12 months"}))})
  
  
  #define colors
  color_yellow = "#F2A900"
  color_blue   = "#003087"
  
  #dataframes for bar charts  
  #Score
  c_score_labs <- c("score 0-6", "score 7-8", "score 9-11", "score 12 up")
  c_score_values  <- c(1,2,3,4)
  c_score_pct  <- c(95, 3, 2, 0.5)
  c_score_risk <- c(0.7, 10, 13.5, 34.5)
  c_score_stats <- data.frame(c_score_labs, c_score_values, c_score_pct, c_score_risk)
  c_score_colors <-   (reactive({if (Total_points()<7)            {c(color_yellow, color_blue, color_blue, color_blue)} 
    else (if (Total_points()<9) {c(color_blue, color_yellow, color_blue, color_blue)}  
          else (if (Total_points()<12) {c(color_blue, color_blue, color_yellow, color_blue)}  
                else {c(color_blue, color_blue, color_blue, color_yellow)} ))}))
  
  
  
  #lables, values for binary vars
  c_labs <- c("without", "with")
  c_yn_values <- c(0,1)
  #age data
  c_age_labs <- c("age 0-6", "age 7-11", "age 12 up")
  c_age_values  <- c(1,2,3)
  c_age_pct  <- c(25, 36, 39)
  c_age_risk <- c(2, 1.4, 1)
  c_age_stats <- data.frame(c_age_labs, c_age_values, c_age_pct, c_age_risk)
  c_age_colors <- (reactive({if (age_val()<7)       {c(color_yellow, color_blue, color_blue)} 
    else (if (age_val()<12) {c(color_blue, color_yellow, color_blue)} 
          else                    {c(color_blue, color_blue, color_yellow)} )}))
  
  #outpatient exacerbation data
  c_outpt_pct  <- c(99, 1)
  c_outpt_risk <- c(1.3, 19)
  c_outpt_colors <- (reactive({if(outpt_points()==0) {c(color_yellow, color_blue)} else {c(color_blue, color_yellow)} }))
  c_outpt_stats <- data.frame(c_labs, c_yn_values, c_outpt_pct, c_outpt_risk)  
  #ed exacerbation data
  c_ed_pct  <- c(97.3, 0.7)
  c_ed_risk <- c(1.3, 18.5)
  c_ed_colors <- (reactive({if(ed_points()==0) {c(color_yellow, color_blue)} else {c(color_blue, color_yellow)} }))
  c_ed_stats <- data.frame(c_labs, c_yn_values, c_ed_pct, c_ed_risk)
  #inpatient exacerbation data
  c_inpt_pct  <- c(99.9, 0.1)
  c_inpt_risk <- c(1.4, 17)
  c_inpt_colors <- (reactive({if(inpt_points()==0) {c(color_yellow, color_blue)} else {c(color_blue, color_yellow)} }))
  c_inpt_stats <- data.frame(c_labs, c_yn_values, c_inpt_pct, c_inpt_risk) 
  #medication fill data
  c_med_fill_pct  <- c(90, 10)
  c_med_fill_risk <- c(0.6, 8.3)
  c_med_fill_colors <- (reactive({if(med_fill_points()==0) {c(color_yellow, color_blue)} else {c(color_blue, color_yellow)} }))
  c_med_fill_stats <- data.frame(c_labs, c_yn_values, c_med_fill_pct, c_med_fill_risk) 
  #ISC fill data
  c_isc_fill_pct  <- c(99.7, 0.3)
  c_isc_fill_risk <- c(1.3, 28.3)
  c_isc_fill_colors <- (reactive({if(isc_fill_points()==0) {c(color_yellow, color_blue)} else {c(color_blue, color_yellow)} }))
  c_isc_fill_stats <- data.frame(c_labs, c_yn_values, c_isc_fill_pct, c_isc_fill_risk)  
  #oral steriod fill data
  c_os_fill_pct  <- c(95.4, 4.6)
  c_os_fill_risk <- c(1, 10)
  c_os_fill_colors <- (reactive({if(os_fill_points()==0) {c(color_yellow, color_blue)} else {c(color_blue, color_yellow)} }))
  c_os_fill_stats <- data.frame(c_labs, c_yn_values, c_os_fill_pct, c_os_fill_risk)  
  #allergy data
  c_allergy_pct  <- c(99.7, 0.3)
  c_allergy_risk <- c(1.3, 28.3)
  c_allergy_colors <- (reactive({if(allergy_points()==0) {c(color_yellow, color_blue)} else {c(color_blue, color_yellow)} }))
  c_allergy_stats <- data.frame(c_labs, c_yn_values, c_allergy_pct, c_allergy_risk)  
  #outpatient maintenance data
  c_outpt_maint_vis_labs <- c("vis 0-1", "vis 2-6", "vis 7+")
  c_outpt_maint_vis_values  <- c(1,2,3)
  c_outpt_maint_vis_pct  <- c(96.3, 3.6, 0.1)
  c_outpt_maint_vis_risk <- c(1, 11, 32)
  c_outpt_maint_vis_stats <- data.frame(c_outpt_maint_vis_labs, c_outpt_maint_vis_values, c_outpt_maint_vis_pct, c_outpt_maint_vis_risk)
  c_outpt_maint_vis_colors <- (reactive({if (outpt_maint_vis_val()<2)       {c(color_yellow, color_blue, color_blue)} 
    else (if (outpt_maint_vis_val()<7) {c(color_blue, color_yellow, color_blue)} 
          else                    {c(color_blue, color_blue, color_yellow)} )})) 
  
  
  
  
  
  
  #Outputs
  output$score_text1 <- renderText(paste("Patient Asthma Exacerbation Risk Score:", Total_points()))
  output$score_text2 <- renderText(paste("Recommendation:", score_txt2()))
  output$score_text3 <- renderText(paste(score_txt3()))
  output$score_text4 <- renderText(paste(score_txt4()))
  output$score_plot1  <- renderPlotly(plot_ly(
    x=c(" 0-6", " 7-9", " 9-11", ">=12"), 
    y=c_score_stats$c_score_pct, 
    marker=list(color=c_score_colors()),
    type="bar")
  )    
  output$score_plot2  <- renderPlotly(plot_ly(
    x=c(" 0-6", " 7-9", " 9-11", ">=12"), 
    y=c_score_stats$c_score_risk, 
    marker=list(color=c_score_colors()),
    type="bar")
  )
  
  #age
  output$age_text1 <- renderText(paste("Patient age:", age_group(),"years of age, ", age_points_txt()))
  output$age_text2 <- renderText(paste("Patients age", age_group()," represent", age_group_pct()," of your patient panel."))
  output$age_text3 <- renderText(paste(age_group_risk_txt()))
  output$age_plot1  <- renderPlotly(plot_ly(
    x=c(" 0-6 years", " 7-11 years", "12+ Years"), 
    y=c_age_stats$c_age_pct, 
    marker=list(color=c_age_colors()),
    type="bar")
  )    
  output$age_plot2  <- renderPlotly(plot_ly(
    x=c(" 0-6 years", " 7-11 years", "12+ Years"), 
    y=c_age_stats$c_age_risk, 
    marker=list(color=c_age_colors()),
    type="bar")
  )
  #outpatient exacerbation
  output$outpt_text1  <- renderText(paste("Outpatient care for asthma exacerbation: ", outpt_group(),", ", outpt_points_txt()))
  output$outpt_text2  <- renderText(paste(outpt_group_pct()))
  output$outpt_text3  <- renderText(paste(outpt_group_risk_txt()))      
  output$outpt_plot1  <- renderPlotly(plot_ly(
    x=c(" No Exacerbation", ">=1 Exacerbation"), 
    y=c_outpt_stats$c_outpt_pct, 
    marker=list(color=c_outpt_colors()),
    type="bar")
  )
  output$outpt_plot2  <- renderPlotly(plot_ly(
    x=c(" No Exacerbation", ">=1 Exacerbation"), 
    y=c_outpt_stats$c_outpt_risk, 
    marker=list(color=c_outpt_colors()),
    type="bar")
  )
  #ed exacerbation
  output$ed_text1  <- renderText(paste("Emergency care for asthma exacerbation: ", ed_group(),", ", ed_points_txt()))
  output$ed_text2  <- renderText(paste(ed_group_pct()))
  output$ed_text3  <- renderText(paste(ed_group_risk_txt()))     
  output$ed_plot1  <- renderPlotly(plot_ly(
    x=c(" No Exacerbation", ">=1 Exacerbation"), 
    y=c_ed_stats$c_ed_pct, 
    marker=list(color=c_ed_colors()),
    type="bar")
  )
  output$ed_plot2  <- renderPlotly(plot_ly(
    x=c(" No Exacerbation", ">=1 Exacerbation"), 
    y=c_ed_stats$c_ed_risk, 
    marker=list(color=c_ed_colors()),
    type="bar")
  )
  #inpatient exacerbation
  output$inpt_text1  <- renderText(paste("Inpatient hospitalization for asthma exacerbation: ", inpt_group(),", ", inpt_points_txt()))
  output$inpt_text2  <- renderText(paste(inpt_group_pct()))
  output$inpt_text3  <- renderText(paste(inpt_group_risk_txt()))     
  output$inpt_plot1  <- renderPlotly(plot_ly(
    x=c(" No Exacerbation", ">=1 Exacerbation"), 
    y=c_inpt_stats$c_inpt_pct, 
    marker=list(color=c_inpt_colors()),
    type="bar")
  )
  output$inpt_plot2  <- renderPlotly(plot_ly(
    x=c(" No Exacerbation", ">=1 Exacerbation"), 
    y=c_inpt_stats$c_inpt_risk, 
    marker=list(color=c_inpt_colors()),
    type="bar")
  )    
  
  #asthma medication filled
  output$med_fill_text1  <- renderText(paste("Asthma medication prescription: ", med_fill_group(),", ", med_fill_points_txt()))
  output$med_fill_text2  <- renderText(paste("Receiving a prescription for an asthma medication indicates a level of disease severity associated with a higher risk of a future exacerbation."))
  output$med_fill_text3  <- renderText(paste(med_fill_group_pct()))
  output$med_fill_text4  <- renderText(paste(med_fill_group_risk_txt()))      
  output$med_fill_plot1  <- renderPlotly(plot_ly(
    x=c(" No Fill", ">=1 Fill"), 
    y=c_med_fill_stats$c_med_fill_pct, 
    marker=list(color=c_med_fill_colors()),
    type="bar")
  )
  output$med_fill_plot2  <- renderPlotly(plot_ly(
    x=c(" No Fill", ">=1 Fill"), 
    y=c_med_fill_stats$c_med_fill_risk, 
    marker=list(color=c_med_fill_colors()),
    type="bar")
  )   
  #ISC medication filled
  output$isc_fill_text1  <- renderText(paste("Inhaled steroid combination prescription: ", isc_fill_group(),", ", isc_fill_points_txt()))
  output$isc_fill_text2  <- renderText(paste("Receiving a prescription for an inhaled steroid combination medication indicates a level of disease severity associated with a higher risk of a future exacerbation, on top of the risk associated with filling any medication (above)."))
  output$isc_fill_text3  <- renderText(paste(isc_fill_group_pct()))
  output$isc_fill_text4  <- renderText(paste(isc_fill_group_risk_txt())) 
  output$isc_fill_plot1  <- renderPlotly(plot_ly(
    x=c(" No Fill", ">=1 Fill"), 
    y=c_isc_fill_stats$c_isc_fill_pct, 
    marker=list(color=c_isc_fill_colors()),
    type="bar")
  )
  output$isc_fill_plot2  <- renderPlotly(plot_ly(
    x=c(" No Fill", ">=1 Fill"), 
    y=c_isc_fill_stats$c_isc_fill_risk, 
    marker=list(color=c_isc_fill_colors()),
    type="bar")
  )  
  #oral steroid medication filled
  output$os_fill_text1  <- renderText(paste("Oral steroid prescription: ", os_fill_group(),", ", os_fill_points_txt()))
  output$os_fill_text2  <- renderText(paste("Receiving a prescription for an oral steroid medication indicates a level of disease severity associated with a higher risk of a future exacerbation, on top of the risk associated with filling any medication (above)."))
  output$os_fill_text3  <- renderText(paste(os_fill_group_pct()))
  output$os_fill_text4  <- renderText(paste(os_fill_group_risk_txt()))   
  output$os_fill_plot1  <- renderPlotly(plot_ly(
    x=c(" No Fill", ">=1 Fill"), 
    y=c_os_fill_stats$c_os_fill_pct, 
    marker=list(color=c_os_fill_colors()),
    type="bar")
  )
  output$os_fill_plot2  <- renderPlotly(plot_ly(
    x=c(" No Fill", ">=1 Fill"), 
    y=c_os_fill_stats$c_os_fill_risk, 
    marker=list(color=c_os_fill_colors()),
    type="bar")
  )   
  
  #concurrent allergy diagnosis
  output$allergy_text1  <- renderText(paste("Concurrent allergy diagnosis: ", allergy_group(),", ", allergy_points_txt()))
  output$allergy_text2  <- renderText(paste(allergy_group_pct()))
  output$allergy_text3  <- renderText(paste(allergy_group_risk_txt()))  
  output$allergy_plot1  <- renderPlotly(plot_ly(
    x=c(" No Allergy", ">=1 Allergy"), 
    y=c_allergy_stats$c_allergy_pct, 
    marker=list(color=c_allergy_colors()),
    type="bar")
  )
  output$allergy_plot2  <- renderPlotly(plot_ly(
    x=c(" No Allergy", ">=1 Allergy"), 
    y=c_allergy_stats$c_allergy_risk, 
    marker=list(color=c_allergy_colors()),
    type="bar")
  )   
  #Outpatient maintenance visits
  output$outpt_maint_vis_text1 <- renderText(paste("Outpatient non-exacerbation visits:", outpt_maint_vis_group(),"non-exacerbation outpatient visits within the last 12 months, ", outpt_maint_vis_points_txt()))
  output$outpt_maint_vis_text2 <- renderText(paste("Routine outpatient care for asthma is recommended, but indicates a level of disease severity associated with a higher risk of a future exacerbation."))
  output$outpt_maint_vis_text3 <- renderText(paste(outpt_maint_vis_group_pct(), "of patients had", outpt_maint_vis_group(),"outpatient maintenance visits for asthma within the last 12 months"))
  output$outpt_maint_vis_text4 <- renderText(paste(age_group_risk_txt())) 
  output$outpt_maint_vis_plot1  <- renderPlotly(plot_ly(
    x=c(" 0-1 Visit", " 2-6 Visits", ">=7 Visits"), 
    y=c_outpt_maint_vis_stats$c_outpt_maint_vis_pct, 
    marker=list(color=c_outpt_maint_vis_colors()),
    type="bar")
  )
  output$outpt_maint_vis_plot2  <- renderPlotly(plot_ly(
    x=c(" 0-1 Visit", " 2-6 Visits", ">=7 Visits"), 
    y=c_outpt_maint_vis_stats$c_outpt_maint_vis_risk, 
    marker=list(color=c_outpt_maint_vis_colors()),
    type="bar")
  ) 
  
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)





















