
lineplotUI<- function(id){
  ns<- NS(id)
  plotlyOutput(ns("lineplot"), width = "auto")
}

lineplotServer<- function(id, xval, yval, cval, xtitle="", ytitle=""){
  moduleServer(
    id,
    function(input, output, session){
      output$lineplot<- renderPlotly({
        plot_ly(
          x= xval,
          y= yval,
          type = 'scatter',
          mode = 'lines+markers',
          #size = 4,
          color = cval,
          colors = c("dodgerblue","aquamarine4","gray48")
        )%>%
          layout(
            xaxis = list(title = xtitle),
            yaxis = list(title = ytitle),
            plot_bgcolor = 'transparent',
            paper_bgcolor = 'transparent',
            legend = list(orientation = 'h')
          ) %>% config(displayModeBar = FALSE)
      })
    }
  )
}