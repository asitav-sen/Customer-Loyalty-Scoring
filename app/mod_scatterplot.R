
scatterplotUI<- function(id){
  ns<- NS(id)
  plotlyOutput(ns("scatter"))
}

scatterplotServer<- function(id, xval, yval, cval, xtitle="", ytitle=""){
  moduleServer(
    id,
    function(input, output, session){
      output$scatter<- renderPlotly({
        req(xval, yval, cval)
        plot_ly(
          x= xval,
          y= yval,
          type = 'scatter',
          size = 4,
          color = cval,
          colors = c("dodgerblue","aquamarine4","gray48"),
          showlegend=F
        )%>%
          layout(
            xaxis = list(title = xtitle),
            yaxis = list(title = ytitle),
            plot_bgcolor = 'transparent',
            paper_bgcolor = 'transparent'
          ) %>% config(displayModeBar = FALSE)
      })
    }
  )
}