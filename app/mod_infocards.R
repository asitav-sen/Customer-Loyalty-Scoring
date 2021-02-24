infocardUI<- function(id){
  ns<- NS(id)
  uiOutput(ns("infocard"))
  
}

infocardServer<- function(id, Value, Title="", Stat=NULL, Description="", Icon, Icon_bg="default", BGC){
  moduleServer(
    id,
    function(input, output, session){
      
      output$infocard<- renderUI({
        req(Value,Stat)
        argonInfoCard(
          value=Value,
          title = Title,
          stat = Stat,
          stat_icon = NULL,
          description = Description,
          icon=Icon,
          icon_background = Icon_bg,
          hover_lift = TRUE,
          shadow = FALSE,
          background_color = BGC,
          gradient = TRUE,
          width = 12
        )
      })
    }
  )
}