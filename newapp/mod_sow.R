sowtabUI<- function(id){
  ns<- NS(id)
  argonTooltip(
    position = "left",
    title = "Click and drag to zoom. Read manual for details.",
    argonCard(
      argonLead("Share of Wallet"),
      lineplotUI(ns("sowplot")),
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
  
}

sowtabServer<- function(id,sowdf, xtitle="", ytitle=""){
  moduleServer(
    id,
    function(input, output, session){
      lineplotServer("sowplot",xval=sowdf$monthid, yval=sowdf$SoW, cval=sowdf$repcat.x, xtitle="Months", ytitle="Share of Wallet")
    }
  )
}