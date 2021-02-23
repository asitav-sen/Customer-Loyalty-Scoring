mapplotUI<- function(id){
  ns<- NS(id)
  leafletOutput(ns("mapplot"))
}

mapplotServer<- function(id, df, mname="GAS CURACAO"){
  moduleServer(
    id,
    function(input, output, session){
      output$mapplot<- renderLeaflet({
        df%>%
        leaflet()%>%
          addTiles()%>%
          addCircleMarkers(
            lng = ~long,
            lat = ~lat,
            radius = 3,
            color = ~ifelse(merchant==mname,"green","red"),
            stroke = FALSE, fillOpacity = 0.5,
            label = ~ifelse(merchant==mname, mname, Segment)
          )
      })
    }
  )
}