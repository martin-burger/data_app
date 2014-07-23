


library(shiny)
library(ggplot2)
library(ggmap)


bikeData<-read.csv("bikeData.csv")
loc<-matrix(c(-74.01713*1.0001,40.68034,-73.95005,40.77051),2,2)
bikeMap<-ggmap(get_map(location=loc,source="stamen",maptype="toner",crop=T))
shinyServer(function(input, output) {
  
  output$bikeMapPlot<-renderPlot({
    bikeMap +
      geom_point(data=bikeData[bikeData$startstationname==input$startstation,],
                 aes(x=longitude,y=latitude,colour=Freq/31,size=tripduration/60),alpha=1)+
      scale_colour_gradient2(low="blue",mid="green",high="red",midpoint=max(bikeData$Freq[bikeData$startstationname==input$startstation]/31)/2,name="Average Num\nof Daily Trips")+
      scale_size(range=c(4,8),name="Average Trip\nDuration (min)")+
      xlab(" ")+
      ylab(" ")+
      theme(plot.title=element_text(size=rel(1.2),face="bold"),
            axis.text=element_blank())+
      geom_rect(inherit.aes=F,
                xmin=bikeData[bikeData$startstationname==input$startstation,]$Slongitude[1]-0.001,
                ymin=bikeData[bikeData$startstationname==input$startstation,]$Slatitude[1]-0.0007,
                xmax=bikeData[bikeData$startstationname==input$startstation,]$Slongitude[1]+0.001,
                ymax=bikeData[bikeData$startstationname==input$startstation,]$Slatitude[1]+0.0007,
                colour="red",size=.5,alpha=0.1)
  },height=800, width=600)
  
  
}
)

