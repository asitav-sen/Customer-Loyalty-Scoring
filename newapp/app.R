library(shiny)
library(argonR)
library(argonDash)
library(plotly)
library(fst)
library(leaflet)
library(waiter)
library(lubridate)
library(tidyverse)
library(shinymanager)

gif <-
    paste0("https://media.giphy.com/media/RLsct1jsRVsVFupW7a/giphy.gif")
loading_screen <- tagList(
    h2("Loading", style = "color:black;"),
    img(src = gif, height = "200px"),
    h2("Insights", style = "color:black;")
)

source("data.R")
source("UIcomponents.R")
source("mod_scatterplot.R")
source("mod_infocards.R")
source("mod_lineplot.R")
source("mod_map.R")
source("mod_barplot.R")
source("mod_scatterinfotab.R")
source("mod_monthlyvaltab.R")
source("mod_sow.R")
source("mod_maptab.R")
source("mod_segrev.R")


# Define UI for application that draws a histogram
UI <- argonDashPage(
    title = "Funmiles",
    description = "Description",
    author = "Zewdu & Asitav",
    navbar = NULL,
    sidebar = Sidebar,
    header = Header,
    body = argonDashBody(
        use_waiter(),
        waiter_preloader(loading_screen, color = "white"),
        #waiter_on_busy(loading_screen, color = transparent(.5)),
        argonTabItems(
            argonTabItem(
                tabName = "lreppurind",
                argonRow(
                    scatterInfoUI("repeatpurchaseindex")  
                ),
                argonRow(
                    monthlyvalUI("repeatpurchasemonthly")
                ),
                argonRow(
                    sowtabUI("repeatpurchasesow")
                )
                
            ),
            argonTabItem(
                tabName = "lcusvalind",
                argonRow(
                    scatterInfoUI("customervalueindex")
                ),
                argonRow(
                    monthlyvalUI("customervaluemonthly")
                ),
                argonRow(
                    sowtabUI("customervalsow")
                )
                
            ),
            argonTabItem(
                tabName = "premium_tab",
                argonRow(
                    maptabUI("premiummap")  
                ),
                argonRow(
                    segrevUI("premiumsegrev",monthfilters)
                )
                
            ),
            argonTabItem(
                tabName = "lloyind",
                llicard
            )
            
        )
    ),
    footer = Footer
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
    
    res_auth <- secure_server(
        check_credentials = check_credentials(
            "~/Funmiles/newapp/db/cred.sqlite",
            passphrase = "dreamcatcher"
            # passphrase = "passphrase_wihtout_keyring"
        )
    )
    
    output$auth_output <- renderPrint({
        reactiveValuesToList(res_auth)
    })
    
    # Extract company name from login
    company<- reactive({
        req(input$shinymanager_where)
        isolate(res_auth$company)
    })
    
    # Data for Repeat Purchase Index Tab
    scatterdata<-reactive({
        req(company())
        repscoresbymonth%>%
        filter(merchant==company())
    })
    
    deltadata<-reactive({
        req(company())
        repscoresdeltamonth%>%
        filter(merchant==company())
    })
    
    maxdata<- reactive({
        req(company())
        maxrepdeltamonth%>%
            filter(merchant==company())
    })
    
    # Data for Sow
    
    selfmilesrep<- reactive({
        req(company())
        scores%>%
            select(c("CustomerId","monthid","Totmiles", "repcat", "merchant"))%>%
            filter(merchant==company())
    })
        
    othermilserep<- reactive({
        req(company())
        scores%>%
            select(c("CustomerId","monthid","Totmiles", "repcat", "merchant"))%>%
            filter(merchant!=company())
    })
        
    
    sowrep <- reactive({
        req(selfmilesrep(),othermilserep())
        selfmilesrep()%>%
            inner_join(othermilserep(), by=c("CustomerId","monthid"))%>%
            group_by(repcat.x, monthid)%>%
            summarise(selfmiles=sum(Totmiles.x), othermiles=sum(Totmiles.y))%>%
            ungroup()%>%
            mutate(SoW=round(selfmiles/(selfmiles+othermiles),2))
    })
        
    
    # Data for Customer Val Tab
    valscatterdata<- reactive({
        req(company())
        valscoresbymonth%>%
            filter(merchant==company())%>%
            filter(monthid==max(valscoresbymonth$monthid))%>%
            rename(repscore=valscore, repcat=valcat)
    })
    
    valdeltamaxdata<- reactive({
        req(company())
        maxvaldeltamonth%>%
            filter(merchant==company())%>%
            rename(repcat=valcat)
    })
    
    valdeltadata<- reactive({
        req(company())
        valscoresdeltamonth%>%
            filter(merchant==company())%>%
            rename(repcat=valcat)
    })
    
    # Data for Sow
    
    selfmilesval<- reactive({
        req(company())
        scores%>%
            select(c("CustomerId","monthid","Totmiles", "valcat", "merchant"))%>%
            filter(merchant==company())
    })
    
    othermilseval<- reactive({
        req(company())
        scores%>%
            select(c("CustomerId","monthid","Totmiles", "valcat", "merchant"))%>%
            filter(merchant!=company())
    })
    
    
    sowval <- reactive({
        req(selfmilesval(),othermilseval())
        selfmilesval()%>%
            inner_join(othermilseval(), by=c("CustomerId","monthid"))%>%
            group_by(valcat.x, monthid)%>%
            summarise(selfmiles=sum(Totmiles.x), othermiles=sum(Totmiles.y))%>%
            ungroup()%>%
            mutate(SoW=round(selfmiles/(selfmiles+othermiles),2))%>%
            rename(repcat.x=valcat.x)
    })
    
    # data for premium tab
    
    mycustomers<- reactive({
        req(company())
        unique(scores[scores$merchant==company(),"CustomerId"])
    })
        
    customerlocdata<- reactive({
        req(mycustomers())
        scores%>%
            filter(CustomerId %in% mycustomers())%>%
            select(c(3,6,7,8,9))%>%
            unique()
    })
        
    prospectlocdata<- reactive({
        req(mycustomers())
        scores%>%
            filter(!CustomerId %in% mycustomers())%>%
            select(c(3,6,7,8,9))%>%
            unique()
    })
        
    customerpurdata <- reactive({
        req(mycustomers())
        scores%>%
            filter(CustomerId %in% mycustomers())%>%
            mutate(Segment=ifelse(Segment=="","SURPRISE",Segment))
    })
        
    prospectpurdata <- reactive({
        req(mycustomers())
        scores%>%
            filter(!CustomerId %in% mycustomers())%>%
            mutate(Segment=ifelse(Segment=="","SURPRISE",Segment))
    })
        
    
# Tab repeat index
    scatterInfoServer("repeatpurchaseindex",scatterdata(), maxdata())
    monthlyvalServer("repeatpurchasemonthly", deltadata())
    sowtabServer("repeatpurchasesow", sowrep())
 
# Tab customer value  
    
    scatterInfoServer("customervalueindex",valscatterdata(), valdeltamaxdata())
    monthlyvalServer("customervaluemonthly", valdeltadata())
    sowtabServer("customervalsow", sowval())
    
# Tab Premium
    maptabServer("premiummap", customerlocdata(), prospectpurdata(), company())
    segrevServer("premiumsegrev", customerpurdata(),prospectpurdata())
    
waiter_hide()
}
ui<-secure_app(UI, tags_top = 
                   tags$div(
                       tags$h4("Brought to you by", style = "align:center"),
                       tags$img(
                           src = "https://lanubia.nl/wp-content/uploads/2018/04/Logo-LaNubia.com-340-x-156.png", width = 100
                       )
                   ),
               tags_bottom = tags$div(
                   tags$p(
                       "For any question, please  contact ",
                       tags$a(
                           href = "mailto:hangela@funmiles.net?Subject=Shiny%20aManager",
                           target="_top", "Henrich Angela"
                       )
                   )
               ),
               background  = "linear-gradient(rgba(0, 0, 255, 0.5),
                       rgba(255, 255, 0, 0.5)),
                       url('https://media4.giphy.com/media/ft4Wp2pZI7ltwkXa0Z/giphy.gif');",
               enable_admin = TRUE)
# Run the application 
shinyApp(ui = ui, server = server)
