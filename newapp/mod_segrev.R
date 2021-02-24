segrevUI<- function(id, monthfilters){
  ns<- NS(id)
  argonTabSet(
    id = ns("revenuebysegment"),
    card_wrapper = TRUE,
    horizontal = T,
    circle = F,
    size = "sm",
    width = 12,
    iconList = list(
      icon("align-left"),
      icon("align-right")
    ),
    argonTab(
      tabName = "Customers",
      active = TRUE,
      argonLead("Which segments are our customers spending in?"),
      hbarplotUI(ns("customerpurseg"),monthfilters)
      
    ),
    argonTab(
      tabName = "Prospects",
      active = FALSE,
      argonLead("Which segments are our prospects spending in?"),
      hbarplotUI(ns("prospectpurseg"),monthfilters)
    )
  )
  
}

segrevServer<- function(id,dfcus, dfpros, mname){
  moduleServer(
    id,
    function(input, output, session){
      hbarplotServer("customerpurseg", df=dfcus)
      hbarplotServer("prospectpurseg", df=dfpros)
    }
  )
}