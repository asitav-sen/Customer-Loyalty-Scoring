library(shiny)
library(argonR)
library(argonDash)
library(plotly)
library(fst)
library(leaflet)
library(waiter)
library(lubridate)
library(tidyverse)



source("data.R")
source("UIcomponents.R")
source("mod_scatterplot.R")
source("mod_infocards.R")
source("mod_lineplot.R")
source("mod_map.R")
source("mod_barplot.R")

gif <-
    paste0("https://media.giphy.com/media/RLsct1jsRVsVFupW7a/giphy.gif")
loading_screen <- tagList(
    h2("Loading", style = "color:black;"),
    img(src = gif, height = "200px"),
    h2("Insights", style = "color:black;")
)

UI <- argonDashPage(
    title = "Funmiles",
    description = "Description",
    author = "Zewdu & Asitav",
    navbar = NULL,
    sidebar = Sidebar,
    header = Header,
    body = argonDashBody(
        use_waiter(),
        waiter_show_on_load(loading_screen, color = "white"),
        waiter_on_busy(loading_screen, color = transparent(.5)),
        argonTabItems(
            # Repeat Purchase Index Tab
            argonTabItem(
                tabName = "lreppurind",
                argonRow(
                    argonTabSet(
                        id = "scattertabs",
                        card_wrapper = TRUE,
                        horizontal = TRUE,
                        circle = FALSE,
                        size = "sm",
                        width = 12,
                        iconList = list(
                            icon("user-friends"),
                            icon("exchange-alt"),
                            icon("money-bill-wave")
                        ),
                        argonTab(
                            tabName = "Customers",
                            active = TRUE,
                            argonLead("Number of customers by LaNubia Repeat Purchase Index"),
                            argonRow(
                                argonTooltip(
                                    position = "left",
                                    title = "Click and drag to zoom. Read manual for details.",
                                    argonColumn(width = 8,
                                                scatterplotUI("customersscatter"))
                                ),
                                argonColumn(
                                    width = 4,
                                    argonTooltip(
                                        position = "left",
                                        title = "Shows the number of grey customers last month and the change since previous month. Read manual for details.",
                                        infocardUI("customerlow")
                                    ),
                                    argonTooltip(
                                        position = "left",
                                        title = "Shows the number of blue customers last month and the change since previous month. Read manual for details.",
                                        infocardUI("customermedium")
                                    ),
                                    argonTooltip(
                                        position = "left",
                                        title = "Shows the number of green customers last month and the change since previous month. Read manual for details.",
                                        infocardUI("customerhigh")
                                    )
                                )
                            )
                            
                        ),
                        argonTab(
                            tabName = "Transactions",
                            active = FALSE,
                            argonLead("Number of transactions by LaNubia Repeat Purchase Index"),
                            argonRow(
                                argonTooltip(
                                    position = "left",
                                    title = "Click and drag to zoom. Read manual for details.",
                                    argonColumn(width = 8,
                                                scatterplotUI("transactionscatter"))
                                ),
                                argonColumn(
                                    width = 4,
                                    argonTooltip(
                                        position = "left",
                                        title = "Shows the number of transactions by grey customers last month and the change since previous month. Read manual for details.",
                                        infocardUI("transactionlow")
                                    ),
                                    argonTooltip(
                                        position = "left",
                                        title = "Shows the number of transactions by blue customers last month and the change since previous month. Read manual for details.",
                                        infocardUI("transactionmedium")
                                    ),
                                    argonTooltip(
                                        position = "left",
                                        title = "Shows the number of transactions by green customers last month and the change since previous month. Read manual for details.",
                                        infocardUI("transactionhigh")
                                    )
                                )
                            )
                        ),
                        argonTab(
                            tabName = "Revenue",
                            active = FALSE,
                            argonLead("Sales revenue by LaNubia Repeat Purchase Index"),
                            argonRow(
                                argonTooltip(
                                    position = "left",
                                    title = "Click and drag to zoom. Read manual for details.",
                                    argonColumn(width = 8,
                                                scatterplotUI("revenuescatter"))
                                ),
                                argonColumn(
                                    width = 4,
                                    argonTooltip(
                                        position = "left",
                                        title = "Shows the revenue generated from grey customers last month and the change since previous month. Read manual for details.",
                                        infocardUI("revenuelow")
                                    ),
                                    argonTooltip(
                                        position = "left",
                                        title = "Shows the revenue generated from blue customers last month and the change since previous month. Read manual for details.",
                                        infocardUI("revenuemedium")
                                    ),
                                    argonTooltip(
                                        position = "left",
                                        title = "Shows the revenue generated from green customers last month and the change since previous month. Read manual for details.",
                                        infocardUI("revenuehigh")
                                    )
                                )
                            )
                        )
                    )
                    ,
                    center = FALSE
                ),
                argonRow(
                    argonTabSet(
                        id = "monthlytabs",
                        card_wrapper = TRUE,
                        horizontal = TRUE,
                        circle = FALSE,
                        size = "sm",
                        width = 12,
                        iconList = list(
                            icon("user-friends"),
                            icon("exchange-alt"),
                            icon("money-bill-wave")
                        ),
                        argonTab(
                            tabName = "Customers",
                            active = TRUE,
                            argonLead("Number of customers per month by LaNubia Repeat Purchase Index"),
                            argonRow(
                                argonTooltip(
                                    position = "left",
                                    title = "Click and drag to zoom. Read manual for details.",
                                    argonColumn(width = 12,
                                                lineplotUI("customersmonthly"))
                                )
                            )
                            
                        ),
                        argonTab(
                            tabName = "Transactions",
                            active = FALSE,
                            argonLead("Number of transactions per month by LaNubia Repeat Purchase Index"),
                            argonRow(
                                argonTooltip(
                                    position = "left",
                                    title = "Click and drag to zoom. Read manual for details.",
                                    argonColumn(width = 12,
                                                lineplotUI("transactionmonthly"))
                                )
                            )
                        ),
                        argonTab(
                            tabName = "Revenue",
                            active = FALSE,
                            argonLead("Sales revenue per month by LaNubia Repeat Purchase Index"),
                            argonRow(
                                argonTooltip(
                                    position = "left",
                                    title = "Click and drag to zoom. Read manual for details.",
                                    argonColumn(width = 12,
                                                lineplotUI("revenuemonthly"))
                                )
                            )
                        )
                    )
                ),
                argonRow(
                    argonTooltip(
                        position = "left",
                        title = "Click and drag to zoom. Read manual for details.",
                        argonCard(
                            argonLead("Share of Wallet by LaNubia Repeat Purchase Index"),
                            lineplotUI("sowbyrepcat"),
                            title = NULL,
                            src = NULL,
                            hover_lift = FALSE,
                            shadow = FALSE,
                            shadow_size = NULL,
                            hover_shadow = FALSE,
                            border_level = 0,
                            icon = NULL,
                            btn_text = NULL,
                            status = "primary",
                            background_color = NULL,
                            gradient = FALSE,
                            floating = FALSE,
                            width = 12
                        )
                    )
                )
                
                
            ),
            
            # Customer Value Tab
            
            argonTabItem(
                tabName = "lcusvalind",
                argonRow(
                    argonTabSet(
                        id = "scattertab",
                        card_wrapper = TRUE,
                        horizontal = TRUE,
                        circle = FALSE,
                        size = "sm",
                        width = 12,
                        iconList = list(
                            icon("user-friends"),
                            icon("exchange-alt"),
                            icon("money-bill-wave")
                        ),
                        argonTab(
                            tabName = "Customers",
                            active = TRUE,
                            argonLead("Number of customers by LaNubia Customer Value Index"),
                            argonRow(
                                argonTooltip(
                                    position = "left",
                                    title = "Click and drag to zoom. Read manual for details.",
                                    argonColumn(width = 8,
                                                scatterplotUI("cvicustomersscatter"))
                                ),
                                argonColumn(
                                    width = 4,
                                    argonTooltip(
                                        position = "left",
                                        title = "Shows number of grey customers last month and the change since previous month. Read manual for details.",
                                        infocardUI("cvicustomerlow")
                                    ),
                                    argonTooltip(
                                        position = "left",
                                        title = "Shows number of blue customers last month and the change since previous month. Read manual for details.",
                                        infocardUI("cvicustomermedium")
                                    ),
                                    argonTooltip(
                                        position = "left",
                                        title = "Shows number of green customers last month and the change since previous month. Read manual for details.",
                                        infocardUI("cvicustomerhigh")
                                    )
                                )
                            )
                            
                        ),
                        argonTab(
                            tabName = "Transactions",
                            active = FALSE,
                            argonLead("Number of transactions by LaNubia Customer Value Index"),
                            argonRow(
                                argonTooltip(
                                    position = "left",
                                    title = "Click and drag to zoom. Read manual for details.",
                                    argonColumn(width = 8,
                                                scatterplotUI("cvitransactionscatter"))
                                ),
                                argonColumn(
                                    width = 4,
                                    argonTooltip(
                                        position = "left",
                                        title = "Shows number of transactions by grey customers last month and the change since previous month. Read manual for details.",
                                        infocardUI("cvitransactionlow")
                                    ),
                                    argonTooltip(
                                        position = "left",
                                        title = "Shows number of transactions by blue customers last month and the change since previous month. Read manual for details.",
                                        infocardUI("cvitransactionmedium")
                                    ),
                                    argonTooltip(
                                        position = "left",
                                        title = "Shows number of transactions by green customers last month and the change since previous month. Read manual for details.",
                                        infocardUI("cvitransactionhigh")
                                    )
                                )
                            )
                        ),
                        argonTab(
                            tabName = "Revenue",
                            active = FALSE,
                            argonLead("Sales revenue by LaNubia Customer Value Index"),
                            argonRow(
                                argonTooltip(
                                    position = "left",
                                    title = "Click and drag to zoom. Read manual for details.",
                                    argonColumn(width = 8,
                                                scatterplotUI("cvirevenuescatter"))
                                ),
                                argonColumn(
                                    width = 4,
                                    argonTooltip(
                                        position = "left",
                                        title = "Shows the revenue generated from grey customers last month and the change since previous month. Read manual for details.",
                                        infocardUI("cvirevenuelow")
                                    ),
                                    argonTooltip(
                                        position = "left",
                                        title = "Shows the revenue generated from blue customers last month and the change since previous month. Read manual for details.",
                                        infocardUI("cvirevenuemedium")
                                    ),
                                    argonTooltip(
                                        position = "left",
                                        title = "Shows the revenue generated from black customers last month and the change since previous month. Read manual for details.",
                                        infocardUI("cvirevenuehigh")
                                    )
                                )
                            )
                        )
                    )
                    ,
                    center = FALSE
                ),
                argonRow(
                    argonTabSet(
                        id = "monthlytabss",
                        card_wrapper = TRUE,
                        horizontal = TRUE,
                        circle = FALSE,
                        size = "sm",
                        width = 12,
                        iconList = list(
                            icon("user-friends"),
                            icon("exchange-alt"),
                            icon("money-bill-wave")
                        ),
                        argonTab(
                            tabName = "Customers",
                            active = TRUE,
                            argonLead("Number of customers per month by LaNubia Customer Value Index"),
                            argonRow(argonColumn(
                                width = 12,
                                lineplotUI("cvicustomersmonthly")
                            ))
                            
                        ),
                        argonTab(
                            tabName = "Transactions",
                            active = FALSE,
                            argonLead("Number of transactions per month by LaNubia Customer Value Index"),
                            argonRow(argonColumn(
                                width = 12,
                                lineplotUI("cvitransactionmonthly")
                            ))
                        ),
                        argonTab(
                            tabName = "Revenue",
                            active = FALSE,
                            argonLead("Sales revenue per month by LaNubia Customer Value Index"),
                            argonRow(argonColumn(width = 12,
                                                 lineplotUI(
                                                     "cvirevenuemonthly"
                                                 )))
                        )
                    )
                ),
                argonRow(
                    argonTooltip(
                        position = "left",
                        title = "Click and drag to zoom. Read manual for details.",
                        argonCard(
                            argonLead("Share of Wallet per month by Lanubia Repeat Purchase Index"),
                            lineplotUI("cvisowbyrepcat"),
                            title = NULL,
                            src = NULL,
                            hover_lift = FALSE,
                            shadow = FALSE,
                            shadow_size = NULL,
                            hover_shadow = FALSE,
                            border_level = 0,
                            icon = NULL,
                            btn_text = NULL,
                            status = "primary",
                            background_color = NULL,
                            gradient = FALSE,
                            floating = FALSE,
                            width = 12
                        )
                    )
                )
                
                
            ),
            
            # Premium Tab
            argonTabItem(tabName = "premium_tab",
                         argonRow(
                             argonTabSet(
                                 id = "location",
                                 card_wrapper = TRUE,
                                 horizontal = TRUE,
                                 circle = FALSE,
                                 size = "sm",
                                 width = 12,
                                 iconList = list(icon("align-left"),
                                                 icon("align-right")),
                                 argonTab(
                                     tabName = "Customers",
                                     active = TRUE,
                                     argonLead("Where are our customers shopping from?"),
                                     argonRow(mapplotUI("customerloc"))
                                     
                                 ),
                                 argonTab(
                                     tabName = "Prospects",
                                     active = FALSE,
                                     argonLead("Where are our prospects shopping from?"),
                                     argonRow(mapplotUI("prospectloc"))
                                 )
                             )
                         ),
                         argonRow(
                             argonTabSet(
                                 id = "revenuebysegment",
                                 card_wrapper = TRUE,
                                 horizontal = T,
                                 circle = F,
                                 size = "sm",
                                 width = 12,
                                 iconList = list(icon("align-left"),
                                                 icon("align-right")),
                                 argonTab(
                                     tabName = "Customers",
                                     active = TRUE,
                                     argonLead("Which segments are our customers spending in?"),
                                     hbarplotUI("customerpurseg", monthfilters)
                                     
                                 ),
                                 argonTab(
                                     tabName = "Prospects",
                                     active = FALSE,
                                     argonLead("Which segments are our prospects spending in?"),
                                     hbarplotUI("prospectpurseg", monthfilters)
                                 )
                             )
                         ))
        )
    ),
    footer = Footer
    
    
)



ui <- UI

# Define server logic
server <- function(input, output) {
    # Server functions for repeat purchase index page
    # Common Data
    
    scatterdata <- repscoresbymonth %>%
        filter(merchant == "GAS CURACAO")
    deltamaxdata <- maxrepdeltamonth %>%
        filter(merchant == "GAS CURACAO")
    deltadata <- repscoresdeltamonth %>%
        filter(merchant == "GAS CURACAO")
    
    # Server functions for first row of data in repeat purchase index page
    # Server functions for tab-customers
    scatterplotServer(
        "customersscatter",
        xval = scatterdata$repscore,
        yval = scatterdata$count,
        cval = scatterdata$repcat,
        xtitle = "Repeat Purchase Index",
        ytitle = "Customers"
    )
    
    
    infocardServer(
        "customerlow",
        Value = deltamaxdata[deltamaxdata$repcat == "grey", ]$customers,
        Title = "Low Index",
        Stat = paste0(deltamaxdata[deltamaxdata$repcat == "grey", ]$deltacustomer *
                          100, " %"),
        Description = "MoM Change",
        Icon = icon("meh"),
        BGC = "secondary",
        Icon_bg = "gray 900"
    )
    
    infocardServer(
        "customermedium",
        Value = deltamaxdata[deltamaxdata$repcat == "blue", ]$customers,
        Title = "Medium Index",
        Stat = paste0(deltamaxdata[deltamaxdata$repcat == "blue", ]$deltacustomer *
                          100, " %"),
        Description = "MoM Change",
        Icon = icon("smile-beam"),
        BGC = "secondary",
        Icon_bg = "info"
    )
    
    
    infocardServer(
        "customerhigh",
        Value = deltamaxdata[deltamaxdata$repcat == "green", ]$customers,
        Title = "High Index",
        Stat = paste0(deltamaxdata[deltamaxdata$repcat == "green", ]$deltacustomer *
                          100, " %"),
        Description = "MoM Change",
        Icon = icon("grin-alt"),
        BGC = "secondary",
        Icon_bg = "success"
    )
    
    # Server functions for tab-transactions
    scatterplotServer(
        "transactionscatter",
        xval = scatterdata$repscore,
        yval = scatterdata$trans,
        cval = scatterdata$repcat,
        xtitle = "Repeat Purchase Index",
        ytitle = "Transactions"
    )
    
    
    infocardServer(
        "transactionlow",
        Value = deltamaxdata[deltamaxdata$repcat == "grey", ]$transactions,
        Title = "Low Index",
        Stat = paste0(deltamaxdata[deltamaxdata$repcat == "grey", ]$deltatransaction *
                          100, " %"),
        Description = "MoM Change",
        Icon = icon("meh"),
        BGC = "secondary",
        Icon_bg = "gray 900"
    )
    
    infocardServer(
        "transactionmedium",
        Value = deltamaxdata[deltamaxdata$repcat == "blue", ]$transactions,
        Title = "Medium Index",
        Stat = paste0(deltamaxdata[deltamaxdata$repcat == "blue", ]$deltatransaction *
                          100, " %"),
        Description = "MoM Change",
        Icon = icon("smile-beam"),
        BGC = "secondary",
        Icon_bg = "info"
    )
    
    
    infocardServer(
        "transactionhigh",
        Value = deltamaxdata[deltamaxdata$repcat == "green", ]$transactions,
        Title = "High Index",
        Stat = paste0(deltamaxdata[deltamaxdata$repcat == "green", ]$deltatransaction *
                          100, " %"),
        Description = "MoM Change",
        Icon = icon("grin-alt"),
        BGC = "secondary",
        Icon_bg = "success"
    )
    
    # Server functions for tab-revenue
    scatterplotServer(
        "revenuescatter",
        xval = scatterdata$repscore,
        yval = scatterdata$sales,
        cval = scatterdata$repcat,
        xtitle = "Repeat Purchase Index",
        ytitle = "Revenue"
    )
    
    
    infocardServer(
        "revenuelow",
        Value = deltamaxdata[deltamaxdata$repcat == "grey", ]$sales,
        Title = "Low Index",
        Stat = paste0(deltamaxdata[deltamaxdata$repcat == "grey", ]$deltasales *
                          100, " %"),
        Description = "MoM Change",
        Icon = icon("meh"),
        BGC = "secondary",
        Icon_bg = "gray 900"
    )
    
    infocardServer(
        "revenuemedium",
        Value = deltamaxdata[deltamaxdata$repcat == "blue", ]$sales,
        Title = "Medium Index",
        Stat = paste0(deltamaxdata[deltamaxdata$repcat == "blue", ]$deltasales *
                          100, " %"),
        Description = "MoM Change",
        Icon = icon("smile-beam"),
        BGC = "secondary",
        Icon_bg = "info"
    )
    
    
    infocardServer(
        "revenuehigh",
        Value = deltamaxdata[deltamaxdata$repcat == "green", ]$sales,
        Title = "High Index",
        Stat = paste0(deltamaxdata[deltamaxdata$repcat == "green", ]$deltasales *
                          100, " %"),
        Description = "MoM Change",
        Icon = icon("grin-alt"),
        BGC = "secondary",
        Icon_bg = "success"
    )
    # Server function for second row of data
    
    lineplotServer(
        "customersmonthly",
        xval = deltadata$monthid,
        yval = deltadata$customers,
        cval = deltadata$repcat,
        xtitle = "Months",
        ytitle = "Customers"
    )
    lineplotServer(
        "transactionmonthly",
        xval = deltadata$monthid,
        yval = deltadata$transactions,
        cval = deltadata$repcat,
        xtitle = "Months",
        ytitle = "Transactions"
    )
    lineplotServer(
        "revenuemonthly",
        xval = deltadata$monthid,
        yval = deltadata$sales,
        cval = deltadata$repcat,
        xtitle = "Months",
        ytitle = "Revenue"
    )
    
    # Server function for share of wallet
    selfmilesrep <-
        scores %>%
        select(c("CustomerId", "monthid", "Totmiles", "repcat", "merchant")) %>%
        filter(merchant == "GAS CURACAO")
    othermilserep <-
        scores %>%
        select(c("CustomerId", "monthid", "Totmiles", "repcat", "merchant")) %>%
        filter(merchant != "GAS CURACAO")
    
    sowrep <-
        selfmilesrep %>%
        inner_join(othermilserep, by = c("CustomerId", "monthid")) %>%
        group_by(repcat.x, monthid) %>%
        summarise(selfmiles = sum(Totmiles.x),
                  othermiles = sum(Totmiles.y)) %>%
        ungroup() %>%
        mutate(SoW = round(selfmiles / (selfmiles + othermiles), 2))
    
    lineplotServer(
        "sowbyrepcat",
        xval = sowrep$monthid,
        yval = sowrep$SoW,
        cval = sowrep$repcat.x,
        xtitle = "Months",
        ytitle = "Share of Wallet"
    )
    
    # Server functions for customer value index page
    
    # Common Data
    
    valscatterdata <- valscoresbymonth %>%
        filter(merchant == "GAS CURACAO") %>%
        filter(monthid == max(valscoresbymonth$monthid))
    valdeltamaxdata <- maxvaldeltamonth %>%
        filter(merchant == "GAS CURACAO")
    valdeltadata <- valscoresdeltamonth %>%
        filter(merchant == "GAS CURACAO")
    
    # Server functions for first row of data in Customer Value page
    # Server functions for tab-customers
    scatterplotServer(
        "cvicustomersscatter",
        xval = valscatterdata$valscore,
        yval = valscatterdata$count,
        cval = valscatterdata$valcat,
        xtitle = "Customer Value Index",
        ytitle = "Customers"
    )
    
    
    infocardServer(
        "cvicustomerlow",
        Value = valdeltamaxdata[valdeltamaxdata$valcat == "grey", ]$customers,
        Title = "Low Index",
        Stat = paste0(valdeltamaxdata[valdeltamaxdata$valcat == "grey", ]$deltacustomer *
                          100, " %"),
        Description = "MoM Change",
        Icon = icon("meh"),
        BGC = "secondary",
        Icon_bg = "gray 900"
    )
    
    infocardServer(
        "cvicustomermedium",
        Value = valdeltamaxdata[valdeltamaxdata$valcat == "blue", ]$customers,
        Title = "Medium Index",
        Stat = paste0(valdeltamaxdata[valdeltamaxdata$valcat == "blue", ]$deltacustomer *
                          100, " %"),
        Description = "MoM Change",
        Icon = icon("smile-beam"),
        BGC = "secondary",
        Icon_bg = "info"
    )
    
    
    infocardServer(
        "cvicustomerhigh",
        Value = valdeltamaxdata[valdeltamaxdata$valcat == "green", ]$customers,
        Title = "High Index",
        Stat = paste0(valdeltamaxdata[valdeltamaxdata$valcat == "green", ]$deltacustomer *
                          100, " %"),
        Description = "MoM Change",
        Icon = icon("grin-alt"),
        BGC = "secondary",
        Icon_bg = "success"
    )
    
    # Server functions for tab-transactions
    scatterplotServer(
        "cvitransactionscatter",
        xval = valscatterdata$valscore,
        yval = valscatterdata$trans,
        cval = valscatterdata$valcat,
        xtitle = "Customer Value",
        ytitle = "Transactions"
    )
    
    
    infocardServer(
        "cvitransactionlow",
        Value = valdeltamaxdata[valdeltamaxdata$valcat == "grey", ]$transactions,
        Title = "Low Index",
        Stat = paste0(valdeltamaxdata[valdeltamaxdata$valcat == "grey", ]$deltatransaction *
                          100, " %"),
        Description = "MoM Change",
        Icon = icon("meh"),
        BGC = "secondary",
        Icon_bg = "gray 900"
    )
    
    infocardServer(
        "cvitransactionmedium",
        Value = valdeltamaxdata[valdeltamaxdata$valcat == "blue", ]$transactions,
        Title = "Medium Index",
        Stat = paste0(valdeltamaxdata[valdeltamaxdata$valcat == "blue", ]$deltatransaction *
                          100, " %"),
        Description = "MoM Change",
        Icon = icon("smile-beam"),
        BGC = "secondary",
        Icon_bg = "info"
    )
    
    
    infocardServer(
        "cvitransactionhigh",
        Value = valdeltamaxdata[valdeltamaxdata$valcat == "green", ]$transactions,
        Title = "High Index",
        Stat = paste0(valdeltamaxdata[valdeltamaxdata$valcat == "green", ]$deltatransaction *
                          100, " %"),
        Description = "MoM Change",
        Icon = icon("grin-alt"),
        BGC = "secondary",
        Icon_bg = "success"
    )
    
    # Server functions for tab-revenue
    scatterplotServer(
        "cvirevenuescatter",
        xval = valscatterdata$valscore,
        yval = valscatterdata$sales,
        cval = valscatterdata$valcat,
        xtitle = "Customer Value Index",
        ytitle = "Revenue"
    )
    
    
    infocardServer(
        "cvirevenuelow",
        Value = valdeltamaxdata[valdeltamaxdata$valcat == "grey", ]$sales,
        Title = "Low Index",
        Stat = paste0(valdeltamaxdata[valdeltamaxdata$valcat == "grey", ]$deltasales *
                          100, " %"),
        Description = "MoM Change",
        Icon = icon("meh"),
        BGC = "secondary",
        Icon_bg = "gray 900"
    )
    
    infocardServer(
        "cvirevenuemedium",
        Value = valdeltamaxdata[valdeltamaxdata$valcat == "blue", ]$sales,
        Title = "Medium Index",
        Stat = paste0(valdeltamaxdata[valdeltamaxdata$valcat == "blue", ]$deltasales *
                          100, " %"),
        Description = "MoM Change",
        Icon = icon("smile-beam"),
        BGC = "secondary",
        Icon_bg = "info"
    )
    
    
    infocardServer(
        "cvirevenuehigh",
        Value = valdeltamaxdata[valdeltamaxdata$valcat == "green", ]$sales,
        Title = "High Index",
        Stat = paste0(valdeltamaxdata[valdeltamaxdata$valcat == "green", ]$deltasales *
                          100, " %"),
        Description = "MoM Change",
        Icon = icon("grin-alt"),
        BGC = "secondary",
        Icon_bg = "success"
    )
    # Server function for second row of data
    
    lineplotServer(
        "cvicustomersmonthly",
        xval = valdeltadata$monthid,
        yval = valdeltadata$customers,
        cval = valdeltadata$valcat,
        xtitle = "Months",
        ytitle = "Customers"
    )
    lineplotServer(
        "cvitransactionmonthly",
        xval = valdeltadata$monthid,
        yval = valdeltadata$transactions,
        cval = valdeltadata$valcat,
        xtitle = "Months",
        ytitle = "Transactions"
    )
    lineplotServer(
        "cvirevenuemonthly",
        xval = valdeltadata$monthid,
        yval = valdeltadata$sales,
        cval = valdeltadata$valcat,
        xtitle = "Months",
        ytitle = "Revenue"
    )
    
    # Server function for third row of data
    selfmilesval <-
        scores %>%
        select(c("CustomerId", "monthid", "Totmiles", "valcat", "merchant")) %>%
        filter(merchant == "GAS CURACAO")
    othermilseval <-
        scores %>%
        select(c("CustomerId", "monthid", "Totmiles", "valcat", "merchant")) %>%
        filter(merchant != "GAS CURACAO")
    
    sowval <-
        selfmilesval %>%
        inner_join(othermilseval, by = c("CustomerId", "monthid")) %>%
        group_by(valcat.x, monthid) %>%
        summarise(selfmiles = sum(Totmiles.x),
                  othermiles = sum(Totmiles.y)) %>%
        ungroup() %>%
        mutate(SoW = round(selfmiles / (selfmiles + othermiles), 2))
    
    lineplotServer(
        "cvisowbyrepcat",
        xval = sowval$monthid,
        yval = sowval$SoW,
        cval = sowval$valcat.x,
        xtitle = "Months",
        ytitle = "Share of Wallet"
    )
    
    # Server functions for Premium Tab
    # Common Data
    mycustomers <-
        unique(scores[scores$merchant == "GAS CURACAO", "CustomerId"])
    customerlocdata <-
        scores %>%
        filter(CustomerId %in% mycustomers) %>%
        select(c(3, 6, 7, 8, 9)) %>%
        unique()
    prospectlocdata <-
        scores %>%
        filter(!CustomerId %in% mycustomers) %>%
        select(c(3, 6, 7, 8, 9)) %>%
        unique()
    customerpurdata <- scores %>%
        filter(CustomerId %in% mycustomers) %>%
        mutate(Segment = ifelse(Segment == "", "SURPRISE", Segment))
    prospectpurdata <- scores %>%
        filter(!CustomerId %in% mycustomers) %>%
        mutate(Segment = ifelse(Segment == "", "SURPRISE", Segment))
    # Maps
    mapplotServer("customerloc", df = customerlocdata, mname = "GAS CURACAO")
    mapplotServer("prospectloc", df = prospectlocdata, mname = "GAS CURACAO")
    
    # Bar Charts
    hbarplotServer("customerpurseg", df = customerpurdata)
    hbarplotServer("prospectpurseg", df = prospectpurdata)
    
    waiter_hide()
    
}

# Run the application
shinyApp(ui = ui, server = server)
