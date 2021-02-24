scatterInfoUI<- function(id){
  ns<- NS(id)
 argonTabSet(
   id=ns("scatterinfo"),
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
     argonLead("Number of customers"),
     argonRow(
       argonTooltip(
         position = "left",
         title = "Click and drag to zoom. Read manual for details.",
         argonColumn(width = 8,
                     scatterplotUI(ns("customersscatter")))),
         argonColumn(
           width = 4,
           argonTooltip(
             position = "left",
             title = "Shows the number of grey customers last month and the change since previous month. Read manual for details.",
             infocardUI(ns("customerlow"))
           ),
           argonTooltip(
             position = "left",
             title = "Shows the number of blue customers last month and the change since previous month. Read manual for details.",
             infocardUI(ns("customermedium"))
           ),
           argonTooltip(
             position = "left",
             title = "Shows the number of green customers last month and the change since previous month. Read manual for details.",
             infocardUI(ns("customerhigh"))
           )
         )
       )
   ),
   argonTab(
     tabName = "Transactions",
     active = FALSE,
     argonLead("Number of transactions"),
     argonRow(
       argonTooltip(
         position = "left",
         title = "Click and drag to zoom. Read manual for details.",
         argonColumn(width = 8,
                     scatterplotUI(ns("transactionscatter")))
       ),
       argonColumn(
         width = 4,
         argonTooltip(
           position = "left",
           title = "Shows the number of transactions by grey customers last month and the change since previous month. Read manual for details.",
           infocardUI(ns("transactionlow"))
         ),
         argonTooltip(
           position = "left",
           title = "Shows the number of transactions by blue customers last month and the change since previous month. Read manual for details.",
           infocardUI(ns("transactionmedium"))
         ),
         argonTooltip(
           position = "left",
           title = "Shows the number of transactions by green customers last month and the change since previous month. Read manual for details.",
           infocardUI(ns("transactionhigh"))
         )
       )
     )
   ),
   argonTab(
     tabName = "Revenue",
     active = FALSE,
     argonLead("Sales revenue"),
     argonRow(
       argonTooltip(
         position = "left",
         title = "Click and drag to zoom. Read manual for details.",
         argonColumn(width = 8,
                     scatterplotUI(ns("revenuescatter")))
       ),
       argonColumn(
         width = 4,
         argonTooltip(
           position = "left",
           title = "Shows the revenue generated from grey customers last month and the change since previous month. Read manual for details.",
           infocardUI(ns("revenuelow"))
         ),
         argonTooltip(
           position = "left",
           title = "Shows the revenue generated from blue customers last month and the change since previous month. Read manual for details.",
           infocardUI(ns("revenuemedium"))
         ),
         argonTooltip(
           position = "left",
           title = "Shows the revenue generated from green customers last month and the change since previous month. Read manual for details.",
           infocardUI(ns("revenuehigh"))
         )
       )
     )
   )
 )
}


scatterInfoServer<- function(id, scoredf, deltamaxdata, Xtitle ="Repeat Purchase Index"){
  moduleServer(
    id,
    function(input, output, session){
       
      scatterplotServer("customersscatter",xval=scoredf$repscore, yval=scoredf$count, 
                        cval=scoredf$repcat, xtitle=Xtitle, ytitle="Customers")
      scatterplotServer("transactionscatter",xval=scoredf$repscore, yval=scoredf$trans, 
                        cval=scoredf$repcat, xtitle=Xtitle, ytitle="Customers")
      scatterplotServer("revenuescatter",xval=scoredf$repscore, yval=scoredf$sales, 
                        cval=scoredf$repcat, xtitle=Xtitle, ytitle="Customers")
      
      infocardServer("customerlow",Value= deltamaxdata[deltamaxdata$repcat=="grey",]$customers,
                     Title="Low Index", Stat=paste0(deltamaxdata[deltamaxdata$repcat=="grey",]$deltacustomer*100," %"), 
                     Description="MoM Change", Icon=icon("meh"), BGC="secondary",
                     Icon_bg="gray 900")
      
      infocardServer("customermedium",Value= deltamaxdata[deltamaxdata$repcat=="blue",]$customers,
                     Title="Medium Index", Stat=paste0(deltamaxdata[deltamaxdata$repcat=="blue",]$deltacustomer*100," %"), 
                     Description="MoM Change", Icon=icon("smile-beam"), BGC="secondary",
                     Icon_bg="info")
      
      
      infocardServer("customerhigh",Value= deltamaxdata[deltamaxdata$repcat=="green",]$customers,
                     Title="High Index", Stat=paste0(deltamaxdata[deltamaxdata$repcat=="green",]$deltacustomer*100," %"), 
                     Description="MoM Change", Icon=icon("grin-alt"), BGC="secondary",
                     Icon_bg="success")
      
      infocardServer("transactionlow",Value= deltamaxdata[deltamaxdata$repcat=="grey",]$transactions,
                     Title="Low Index", Stat=paste0(deltamaxdata[deltamaxdata$repcat=="grey",]$deltatransaction*100," %"), 
                     Description="MoM Change", Icon=icon("meh"), BGC="secondary",
                     Icon_bg="gray 900")
      
      infocardServer("transactionmedium",Value= deltamaxdata[deltamaxdata$repcat=="blue",]$transactions,
                     Title="Medium Index", Stat=paste0(deltamaxdata[deltamaxdata$repcat=="blue",]$deltatransaction*100," %"), 
                     Description="MoM Change", Icon=icon("smile-beam"), BGC="secondary",
                     Icon_bg="info")
      
      infocardServer("transactionhigh",Value= deltamaxdata[deltamaxdata$repcat=="green",]$transactions,
                     Title="High Index", Stat=paste0(deltamaxdata[deltamaxdata$repcat=="green",]$deltatransaction*100," %"), 
                     Description="MoM Change", Icon=icon("grin-alt"), BGC="secondary",
                     Icon_bg="success")
      
      infocardServer("revenuelow",Value= deltamaxdata[deltamaxdata$repcat=="grey",]$sales,
                     Title="Low Index", Stat=paste0(deltamaxdata[deltamaxdata$repcat=="grey",]$deltasales*100," %"), 
                     Description="MoM Change", Icon=icon("meh"), BGC="secondary",
                     Icon_bg="gray 900")
      
      infocardServer("revenuemedium",Value= deltamaxdata[deltamaxdata$repcat=="blue",]$sales,
                     Title="Medium Index", Stat=paste0(deltamaxdata[deltamaxdata$repcat=="blue",]$deltasales*100," %"), 
                     Description="MoM Change", Icon=icon("smile-beam"), BGC="secondary",
                     Icon_bg="info")
      
      infocardServer("revenuehigh",Value= deltamaxdata[deltamaxdata$repcat=="green",]$sales,
                     Title="High Index", Stat=paste0(deltamaxdata[deltamaxdata$repcat=="green",]$deltasales*100," %"), 
                     Description="MoM Change", Icon=icon("grin-alt"), BGC="secondary",
                     Icon_bg="success")
    }
  )
}