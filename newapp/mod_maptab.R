maptabUI<- function(id){
  ns<- NS(id)
  argonTabSet(
    id = ns("location"),
    card_wrapper = TRUE,
    horizontal = TRUE,
    circle = FALSE,
    size = "sm",
    width = 12,
    iconList = list(
      icon("align-left"),
      icon("align-right")
    ),
    argonTab(
      tabName = "Customers",
      active = TRUE,
      argonLead("Where are our customers shopping from?"),
      argonRow(
        mapplotUI(ns("customerloc"))
      )
      
    ),
    argonTab(
      tabName = "Prospects",
      active = FALSE,
      argonLead("Where are our prospects shopping from?"),
      argonRow(
        mapplotUI(ns("prospectloc"))
      )
    )
  )
  
}

maptabServer<- function(id,dfcus, dfpros, mname){
  moduleServer(
    id,
    function(input, output, session){
      mapplotServer("customerloc", dfcus, mname)
      mapplotServer("prospectloc", dfpros, mname)
    }
  )
}