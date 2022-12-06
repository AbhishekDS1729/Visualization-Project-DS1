#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyjs)
library(shinydashboard)
library(rlang)
library(ggplot2)
library(ggpubr)
library(gridExtra)
library(dgof)
library(data.table)
library(bslib)
library(dashboardthemes)
library(egg)
library(ggcorrplot)


diabetes <- read.csv("./Data/diabetes.csv")
attach(diabetes)
# Define UI for application that draws a histogram
ui <- dashboardPage(
        dashboardHeader(title = "Diabetes Visualization"),  
        dashboardSidebar(
        useShinyjs(),
        sidebarMenu(
          
          sidebarSearchForm("searchtext","buttonsearch","Search"),
            menuItem("Introduction", tabName = "1",icon = icon("dashboard")),
            menuItem("Variable Description", tabName = "2", icon = icon("pen"),
              menuSubItem("Pregnancies", tabName = "5"),
              menuSubItem("Glucose", tabName = "6"),
              menuSubItem("BloodPressure", tabName = "7"),
              menuSubItem("SkinThickness", tabName = "8"),
              menuSubItem("Insulin", tabName = "9"),
              menuSubItem("BMI", tabName = "10"),
              menuSubItem("DiabetesPedigreeFunction", tabName = "11"),
              menuSubItem("Age", tabName = "12"),
              menuSubItem("Outcome", tabName = "13")
            ),  
          menuItem("Variable Visualization", tabName = "3",icon = icon("bar-chart-o"),
            menuSubItem("Univariate Data Visualization",tabName = "14"),
            menuSubItem("Bivariate Data Visualization", tabName = "15")
          ),
          menuItem("Conclusion", tabName = "4",icon = icon("scroll"))
       ) 
      ),
        dashboardBody(shinyDashboardThemes(
          theme = "purple_gradient"
        ),
          tabItems(
            tabItem(tabName = "1",
                    h1("Introduction",align = "center"),
            fluidRow(align = "center",
                     
                     verbatimTextOutput("text1")
                    )
            ),
              
            
            tabItem(tabName = "2",
                    h1("Variable Description",align = "center"),
                    fluidRow(align = "center",
                             
                             verbatimTextOutput("text2")
                    )
                    ),
            
            tabItem(tabName = "5",
                    h1("Pregnancies",align = "center"),
            fluidRow(
                    box(plotOutput("Barplot1"))
                    ),
            fluidRow(
              align = "center",
              verbatimTextOutput("text3")
            ),
                    
                    
            ),
            tabItem(tabName = "6",
                    h1("Glucose",align = "center"),
             fluidRow(
               box(plotOutput("Histogram1"))
               ),
             fluidRow(
               align = "center",
               verbatimTextOutput("text4")
             ),
             
            ),
            tabItem(tabName = "7",
                    h1("BloodPressure",align = "center"),
            fluidRow(
              box(plotOutput("Histogram2"))
            ),
            fluidRow(
              align = "center",
              verbatimTextOutput("text5")
            ),
            
            ),
            
            
            tabItem(tabName = "8",
                    h1("SkinThickness",align = "center"),
                    fluidRow(
                      box(plotOutput("Histogram3"))
                    ),
            fluidRow(
                      align = "center",
                      verbatimTextOutput("text6")
            ),
            ),
            
            tabItem(tabName = "9",
                    h1("Insulin",align = "center"),
                    
                    fluidRow(
                      box(plotOutput("Histogram4"))
                    ),        
            fluidRow(
                      align = "center",
                      verbatimTextOutput("text7")
                    ),        
            ),
            
            
            tabItem(tabName = "10",
                    h1("BMI",align = "center"),
                    fluidRow(
                      box(plotOutput("Histogram5"))
                    ),
            fluidRow(
                      align = "center",
                      verbatimTextOutput("text8")
                    ),        
            ),
            tabItem(tabName = "11",
                    h1("DiabetesPedigreeFunction ",align = "center"),
                    fluidRow(
                      box(plotOutput("Histogram6"))
                    ),
            fluidRow(
                      align = "center",
                      verbatimTextOutput("text9")
                    ),
            ),
            tabItem(tabName = "12",
                    h1("Age",align = "center"),
                    fluidRow(
                      box(plotOutput("Histogram7"))
                    ),
            fluidRow(
                      align = "center",
                      verbatimTextOutput("text10")
                    ),      
            ),
            tabItem(tabName = "13",
                    h1("Outcome",align = "center"),
                    fluidRow(
                      box(plotOutput("Pi1"))
                    ),
            fluidRow(
                      align = "center",
                      verbatimTextOutput("text11")
                    ),        
            ),
            
            tabItem(tabName = "3",
                    h1("Variable Visualization",align = "center"),
            fluidRow(
              align = "center",
              verbatimTextOutput("text12")
              ),
                          
            ),
            tabItem(tabName = "14",
                    h1("Univariate Data Visualization",align = "center"),
                    fluidPage(
                      sidebarLayout(
                        sidebarPanel(
                          radioButtons("type", "Type of plot", choices = c("Density / Frequency Distribution", "Boxplot")),
                          selectInput("coloumn","Choose Variable",choices = c("Pregnancies","Glucose","BloodPressure","SkinThickness","Insulin","BMI","DiabetesPedigreeFunction","Age","Outcome")),
                          actionButton("uni","Apply")
                        ),
                        mainPanel(plotOutput("Plots"),textOutput("Comments"))
                      )), 
                    
                    
            ),
            tabItem(tabName = "15",
                    h1("Bivariate Data Visualization",align = "center"),
                    fluidPage(
                      sidebarLayout(
                        sidebarPanel(
                          selectInput("coloumn1","Choose Variable",choices = c("Age and Outcome","Glucose and Blood Pressure","Glucose and Diabetes Pedigree Function vs Pregnancies","Correlation Matrix","BMI and Outcome",
                                                                               "Insulin and Glucose","Blood Pressure and Diabetes Pedigree Function","Blood Pressure and Insulin","Glucose and BMI",
                                                                               "Glucose and Outcome","BMI and Insulin","Age and Blood Pressure")),
                          actionButton("uni1","Apply")
                        ),
                        mainPanel(plotOutput("Plots1"),textOutput("Comments1"))
                      )),
                    
                    
                    
                    
                    
                    ),
                    
            
            
            tabItem(tabName = "4",
                    h1("Conclusion",align = "center"),
                    fluidRow(align = "center",
                             
                             verbatimTextOutput("text14")
                    )
            )
          )
          
          
          )
      )
      
      # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
# Define server logic required to draw a histogram
server <- function(input, output) {
  
  observeEvent(input$uni,
         
         if(input$coloumn=="Pregnancies"){
           output$Plots<-renderPlot({
             if(input$type == "Density / Frequency Distribution"){
             ggplot(diabetes,aes(x = Pregnancies))+
               geom_bar(color = "black",fill = "green")}
             else if(input$type == "Boxplot"){ggplot(diabetes,aes(y = Pregnancies))+
                 geom_boxplot(outlier.color = "violet")}
             
             
           })
           output$Comments<-renderText({
             paste0("As we can see from the barplot, 'Pregnancies' is positively skewed, that is, the longer tail is towards higher frequency.")
           })}
         
         else if(input$coloumn=="Glucose"){
           
           output$Plots<-renderPlot({
             if(input$type == "Density / Frequency Distribution"){
             ggplot(diabetes,aes(x = Glucose))+
               geom_histogram(color = "blue", fill = "red")}
             else if(input$type == "Boxplot"){ggplot(diabetes,aes(y = Glucose))+
                 geom_boxplot(outlier.color = "grey")}
             
             })
           
           output$Comments<-renderText({
             paste0("As we can see from the frequency distribution of the variable Glucose, mostly the frequency distribution is concentrated towards the middlemost values.")
           })
         }
         else if(input$coloumn=="BloodPressure"){
           
           output$Plots<-renderPlot({
             if(input$type == "Density / Frequency Distribution"){
             ggplot(diabetes,aes(x = BloodPressure))+
               geom_histogram(color = "blue", fill = "pink")}
             else if(input$type == "Boxplot"){ggplot(diabetes,aes(y = BloodPressure))+
                 geom_boxplot(outlier.color = "blue")}
           })
           output$Comments<-renderText({
             paste0("Here we have a histogram from which we can depict the bloodpressure markings of our population under consideration. The value 0 corresponds to the ones for whom the bloodpressure was not measured.")
           })
         }
         else if(input$coloumn=="SkinThickness"){
           
           output$Plots<-renderPlot({
             if(input$type == "Density / Frequency Distribution"){
             ggplot(diabetes,aes(x = SkinThickness))+
               geom_histogram(color = "black", fill = "cyan")}
             else if(input$type == "Boxplot"){ggplot(diabetes,aes(y = SkinThickness))+
                 geom_boxplot(outlier.color = "green")}
           })
           output$Comments<-renderText({
             paste0("Here we have a histogram from which we can depict the skinthickness markings of our population under consideration. The histogram denotes that the variable is somewhat symmetrically distributed without the observation 0 which signifies . The value 0 
                    corresponds to the ones for whom the skinthickness was not measured.")
           })
         }
         else if(input$coloumn=="Insulin"){
           
           output$Plots<-renderPlot({
             if(input$type == "Density / Frequency Distribution"){
             ggplot(diabetes,aes(x = Insulin))+
               geom_histogram(color = "black", fill = "white")}
             else if(input$type == "Boxplot"){ggplot(diabetes,aes(y = Insulin))+
                 geom_boxplot(outlier.color = "yellow")}
           })
           output$Comments<-renderText({
             paste0("Here we have a histogram from which we can depict the insulin markings of our population under consideration. From the histogram it is clear that the variable under consideration is positively skewed. That is, the variable has its longer tail towards the higher frequency.")
           })
         }
         else if(input$coloumn=="BMI"){
           
           output$Plots<-renderPlot({
             if(input$type == "Density / Frequency Distribution"){
             ggplot(diabetes,aes(x = BMI))+
               geom_histogram(color = "black", fill = "red")}
             else if(input$type == "Boxplot"){ggplot(diabetes,aes(y = BMI))+
                 geom_boxplot(outlier.color = "orange")}
           })
           output$Comments<-renderText({
             paste0("Here we have a histogram from which we can depict the BMI (Body Mass Index) markings of our population under consideration. The value 0 corresponds to the ones for whom the BMI (Body Mass Index) was not measured.")
           })
         }
         else if(input$coloumn=="DiabetesPedigreeFunction"){
           
           output$Plots<-renderPlot({
             if(input$type == "Density / Frequency Distribution"){
             ggplot(diabetes,aes(x = DiabetesPedigreeFunction))+
               geom_histogram(color = "blue", fill = "grey")}
             else if(input$type == "Boxplot"){ggplot(diabetes,aes(y = DiabetesPedigreeFunction))+
                 geom_boxplot(outlier.color = "red")}
           })
           output$Comments<-renderText({
             paste0("Here we have a histogram from which we can depict the diabetes pedigree function markings of our population under consideration. The value 0 corresponds to the ones for whom the diabetes pedigree function was not measured.")
           })
         }
         else if(input$coloumn=="Age"){
           
           output$Plots<-renderPlot({
             if(input$type == "Density / Frequency Distribution"){
             ggplot(diabetes,aes(x = Age))+
               geom_histogram(color = "red", fill = "pink")}
             else if(input$type == "Boxplot"){ggplot(diabetes,aes(y = Age))+
                 geom_boxplot(outlier.color = "black")}
           })
           output$Comments<-renderText({
             paste0("This histogram depicts the age of the population under consideration.")
           })
         }
         else if(input$coloumn=="Outcome"){
           
           output$Plots<-renderPlot({
             df <- data.frame(table(diabetes$Outcome))
             colnames(df) <- c("Outcome","Freq")
             ggplot(df, aes(x="", y=Freq, fill = Outcome)) + coord_polar("y") + geom_bar(stat="Identity", width = 1) + scale_fill_brewer(palette = "Set1")
           })
           output$Comments<-renderText({
             paste0("The pie chart shows that for our population under study, most of the population members don't have diabetes and the rest do.")
           })
         }          
)
  
  
  
  observeEvent(input$uni1,
               if(input$coloumn1 == "Age and Outcome"){
                 output$Plots1 = renderPlot({
                   ggplot(diabetes,aes(x = Age,fill = factor(Outcome)))+
                     geom_density(alpha = 0.7)+
                     labs(title = "Impact of Age over Outcome",fill = "Outcome")
                 })
               }
               
               else if(input$coloumn1 == "Glucose and Blood Pressure"){
                 output$Plots1 = renderPlot({
                   ggplot(diabetes,aes(x = Glucose, y = BloodPressure, size = Age, color = as.factor(Outcome)))+
                     geom_jitter(alpha = 0.5)+
                     labs(title = "Glucose Level and Blood Pressure against Age", fill = "Outcome")
                 })
               }
               
               else if(input$coloumn1 == "Glucose and Diabetes Pedigree Function vs Pregnancies"){
                 output$Plots1 = renderPlot({
                   ggplot(diabetes,aes(x = Glucose,y = DiabetesPedigreeFunction,color = Pregnancies))+
                     geom_jitter(alpha = 0.6 )+
                     labs(title = "Relationship between Glucose and Diabetes Pedigree Function vs Pregnancies",color = "Pregnancies")
                 })
               }
               
               else if(input$coloumn1 == "Correlation Matrix"){
                 output$Plots1 = renderPlot({
                   c = round(cor(diabetes),1)
                   
                   ggcorrplot(c,lab = TRUE)+
                     labs(title = "Correlation Matrix of the attributes")
                 })
               }
               
               
               else if(input$coloumn1 == "BMI and Outcome"){
                 output$Plots1 = renderPlot({
                   ggplot(diabetes,aes(x = BMI,fill = factor(Outcome)))+
                     geom_density(alpha = 0.4)+
                     labs(title = "Distribution of BMI and Outcome",fill = "Outcome")
                   
                   })
               }
               
               else if(input$coloumn1 == "Insulin and Glucose"){
                 output$Plots1 = renderPlot({
                   ggplot(diabetes,aes(x = Insulin,y = Glucose))+
                     geom_point(aes(color = as.factor(Outcome)))+
                     geom_smooth()+
                     labs(color = "Outcome")
                   
                 })
               }
               
               else if(input$coloumn1 == "Blood Pressure and Diabetes Pedigree Function"){
                 output$Plots1 = renderPlot({
                   ggplot(diabetes,aes(x = BloodPressure, y = DiabetesPedigreeFunction))+
                     geom_point(aes(color = as.factor(Outcome)))+
                     geom_smooth()+
                     labs(color = "Outcome")
                   
                   
                 })
               }
               
               
               else if(input$coloumn1 == "Blood Pressure and Insulin"){
                 output$Plots1 = renderPlot({
                   ggplot(diabetes,aes(x = BloodPressure, y = Insulin))+
                     geom_point(aes(color = as.factor(Outcome)))+
                     geom_smooth()+
                     labs(color = "Outcome")
                   
                   
                 })
               }
               
               else if(input$coloumn1 == "Glucose and BMI"){
                 output$Plots1 = renderPlot({
                   ggplot(diabetes,aes(x = Glucose, y = BMI))+
                     geom_point(aes(color = as.factor(Outcome)))+
                     geom_smooth()+
                     labs(color = "Outcome")
                   
                   
                 })
               }
               
               else if(input$coloumn1 == "Glucose and Outcome"){
                 output$Plots1 = renderPlot({
                   ggplot(diabetes,aes(x = Glucose,fill = factor(Outcome)))+
                     geom_density(alpha = 0.4)+
                     labs(title = "Distribution of Glucose",fill = "Outcome")
                   
                   
                 })
               }
               
               else if(input$coloumn1 == "BMI and Insulin"){
                 output$Plots1 = renderPlot({
                   ggplot(diabetes,aes(x = BMI, y = Insulin))+
                     geom_point(aes(color = as.factor(Outcome)))+
                     geom_smooth()+
                     labs(color = "Outcome")
                   
                   
                   
                 })
               }
               
               else if(input$coloumn1 == "Age and Blood Pressure"){
                 output$Plots1 = renderPlot({
                   ggplot(diabetes,aes(x = Age, y = BloodPressure))+
                     geom_point(aes(color = as.factor(Outcome)))+
                     geom_smooth()+
                     labs(color = "Outcome")
                   
                   
                   
                 })
               }
               
               
               
               )
  
  
  
  
  
  
  
  
  
  output$text1 <- renderText({
    paste0("PIMA Indians are native Americans who are based in Arizona Area. In 
    the first component of our project, we have taken the PIMA Indians Diabetes 
    dataset for females.\n In the first component of our project, we have visualised the attributes and have done some
    Exploratory Data Analysis (EDA) and showed how the attributes are related to each other through
    the use of R Programming.\n In this component of the project, we will build a web app in the
    form of RShiny Dashboard and show some univariate and bivariate plots of our dataset. The main motive 
    of this project is to understand whetjer and if yes, how much effect the independent variables have
    over the dependent variable.\n The dataset is available at https://www.kaggle.com/datasets/uciml/pima-indians-diabetes-database.")
  })
  
  output$text2 <- renderText({
    paste0("This dataset contains of 8 predictor (independent) variables and one target (dependent) variable,
namely Outcome. The predictor variables are Pregnancies, Glucose, BloodPressure, SkinThickness,
Insulin, BMI, DiabetesPedigreeFunction and Age.\n
In the next subsections of this section, we will try to provide a small description of each of the
attributes of the dataset.")
  })
  
  output$text3 = renderText({
    paste0("This column of the dataset shows the number of times a PIMA Indian female has gotten pregnant in her entire life so far. We can show how number of pregnancies
    affect the chance of that person being diabetic. This is a quantitative numeric variable. Through this barplot, we have plotted the number of times our concentrated 
    population members have gotten pregnant.")
  })
  
  output$text4 = renderText({
    
    paste0("This column of the dataset shows the Plasma Glucose concentration in 2 hours of an oral Glucose
Tolerance Test. This is a continuous numeric variable. We can show either this correctly predicts
whether a person has diabetes or not. The histogram above depicts the distribution of Glucose in the
targetted population.
")
    
  })
  
  output$text5 = renderText({
    paste0("This column of the dataset shows the Diastolic Blood Pressure in mm Hg of a person. In later part of
this report we will show whether BloodPressure correctly predicts whether a person has diabetes or
not. This is a continuous numeric variable. The histogram shown above is a representation of the distribution
of Blood Pressure among the PIMA Indian female population under study.
           ")
  })
     
  output$text6 = renderText({
    paste0("This column of the dataset shows the Triceps skin fold thickness in mm of PIMA Indian females who
are under consideration. This column will be useful to show whether obesity is somewhat related to
someone having diabetes or not. Although skin thickness is not related to obesity linearly, but we can
assume they are somewhat correlated. This is a continuous numeric variable. The histogram shown above is a representation of the distribution
of Skin Thickness among the PIMA Indian female population under study.
           ")
  })
  
  output$text7 = renderText({
    paste0("This column of the dataset shows the 2-Hour serum insulin in mu U/ml. This column will be useful to
show whether insulin levels are related to whether a person has diabetes or not. This is a continuous
numeric variable. The histogram shown above is a representation of the distribution
of Insulin among the PIMA Indian female population under study.
           ")
  })
  
  output$text8 = renderText({
  paste0("This column of the dataset shows the Body Mass Index (Weight in kg / (Height in m)2) of PIMA
Indian Female. This will actually show whether a person with maintained height-mass ratio or a
person with obese body or malnutrition-ed body will have higher chance of having diabetes. This is a
continuous numeric variable. The histogram shown above is a representation of the distribution
of Body Mass Index (BMI) among the PIMA Indian female population under study.
           ")
  })
  
  output$text9 = renderText({
    paste0("This column of the dataset depicts the Diabetes Pedigree Function for the given population. Diabetes
Pedigree Function is defined as - Diabetes Pedigree Function: indicates the function which scores
likelihood of diabetes based on family history. This is a continuous numeric variable. The histogram shown above is a representation of the distribution
of Diabetes Pedigree Function among the PIMA Indian female population under study.
           ")
  })
  
  
  output$text10 = renderText({
    paste0("This column of the dataset depicts the age of the population. Later on in this report we will show
whether the chance of having diabetes increases with age or not. This is a continuous numeric vari-
able. The histogram shown above is a representation of the distribution
of Age among the PIMA Indian female population under study.
           ")
  })
  
  
  output$text11 = renderText({
    paste0("Outcome is a categorical variable which takes the value 1 if a person has diabetes and takes the value
0 if a person does not have diabetes. The pie chart or pie diagram shown above is a representation of the distribution
of Outcome among the PIMA Indian female population under study.
           ")
  })
  
  output$text12 = renderText({
    paste0("In this section of our project, we will do some visualization on univariate and bivariate along with some 
multivariate sections of the data. The main motive of this visualization is to find whether the independent variables affect the dependent
variables or not. This project is designed to visualize the effects of different factors over the reason of diabetes. This section serves 
as the most important component of the project.")
  
    
  })
  
    output$text14 = renderText({
      paste0("In this dashboard we have explored how different independent variables affect the dependent variable that is Outcome, which depicts whether \
             a person under consideration has diabetes or not.In the first section we have introduced the dataset. In the second section, we have described each
             of the variables. In the third section we have done some univariate and bivariate along with some multivariate plots, which was the main motive of this project. Further plans regarding
             this project is that whenever the data is available for PIMA Indian Male population's diabetes, we can push the data from backend and then see the results from the available plots and
             compare as well as check whether the results come out to be similar for female population and the male population. We can further fit some models to see whether the independent variables
             are significant for predicting the dependent variable or not.")
    
    })
  
  output$Barplot1 = renderPlot({
    ggplot(diabetes,aes(x = Pregnancies))+
      geom_bar(color = "black",fill = "green")
  })
  
  output$Histogram1 = renderPlot({
    ggplot(diabetes,aes(x = Glucose))+
      geom_histogram(color = "blue", fill = "red")
  })
  
  output$Histogram2 = renderPlot({
    ggplot(diabetes,aes(x = BloodPressure))+
      geom_histogram(color = "blue", fill = "pink")
  })
  
  output$Histogram3 = renderPlot({
    ggplot(diabetes,aes(x = SkinThickness))+
      geom_histogram(color = "black", fill = "cyan")
  })
  
  output$Histogram4 = renderPlot({
    ggplot(diabetes,aes(x = Insulin))+
      geom_histogram(color = "black", fill = "white")
  })
  
  output$Histogram5 = renderPlot({
    ggplot(diabetes,aes(x = BMI))+
      geom_histogram(color = "black", fill = "red")
  })
  
  output$Histogram6 = renderPlot({
    ggplot(diabetes,aes(x = DiabetesPedigreeFunction))+
      geom_histogram(color = "blue", fill = "grey")
  })
  
  output$Histogram7 = renderPlot({
    ggplot(diabetes,aes(x = Age))+
      geom_histogram(color = "red", fill = "pink")
  })
  
  output$Pi1 = renderPlot({
    df <- data.frame(table(diabetes$Outcome))
    colnames(df) <- c("Outcome","Freq")
    ggplot(df, aes(x="", y=Freq, fill = Outcome)) + coord_polar("y") + geom_bar(stat="Identity", width = 1) + scale_fill_brewer(palette = "Set1")
  })
  
  data_segmentation =  reactive({
    if (input$Univ == "Pregnancies"){
      diabetes[,1]
    }
    else if (input$Univ == "Glucose"){
      diabetes[,2]
    }
    else if (input$Univ == "BloodPressure"){
      diabetes[,3]
    }
    else if (input$Univ == "SkinThickness"){
      diabetes[,4]
    }
    else if (input$Univ == "Insulin"){
      diabetes[,5]
    }
    else if (input$Univ == "BMI"){
      diabetes[,6]
    }
    else if (input$Univ == "DiabetesPedigreeFunction"){
      diabetes[,7]
    }
    else if (input$Univ == "Age"){
      diabetes[,8]
    }
    else if (input$Univ == "Outcome"){
      diabetes[,9]
    }
  })
}
# Run the application 
shinyApp(ui = ui, server = server)

