library(dplyr)
library(ggplot2)
# devtools::install_github("BlakeRMills/MoMAColors")
library(MoMAColors)

tetris <- function(maxy=40, maxx=100, yrow=15, background_color=TRUE, color="OKeeffe") {
  
  start_xmin <- 0
  start_xmax <- 2
  start_ymin <- 0
  start_ymax <- 1
  
  
  x1 <- c()
  x2 <- c()
  y1 <- c()
  y2 <- c()
  
  d <- data.frame(x1=numeric(), x2=numeric(), y1=numeric(), y2=integer(), r=integer())
  
  x1 <- c(x1, start_xmin)
  x2 <- c(x2, start_xmax)
  y1 <- c(y1, start_ymin)
  y2 <- c(y2, start_ymax)
  
  while (yrow < maxy) {
    
    for (x in seq(1, maxx)) {
      
      next_xmin <- max(x2)
      next_xmax <- runif(1, min=max(x2)+1, max=max(x2)+8)
      
      x1 <- c(x1, next_xmin)
      x2 <- c(x2, next_xmax)
      
      if ((max(x2)+8) > maxx) { #or use max(x2) to create more
        # save vectors as one row in df and clear out
        row <- data.frame(x1, x2, y1=rep(yrow-1, length(x1)), y2=rep(yrow, length(x1)), r=rep(yrow, length(x1)))
        
        d <- rbind(d, rbind(row, c(max(x2), maxx, yrow-1, yrow, yrow)))
        yrow <- yrow + 1
        x1 <- c(0)
        x2 <- c(runif(1, min=2, max=10))
        next
      }
      
    }
  }
  
  d$color <- purrr::map_int(seq(1, nrow(d)), ~sample(2:10, 1))
  
  plot <-
    ggplot() +
    geom_rect(data=d, mapping=aes(xmin=x1, xmax=x2, ymin=y1, ymax=y2, fill=as.factor(color)), 
              color="black") +
    scale_fill_manual(values=moma.colors(color, 10)[2:10]) +
    theme_void() +
    theme(#plot.margin = unit(c(bottom=.5, left=.5, top=.5, right=.5),"cm"),
          plot.margin = margin(0, 0, 0, 0, "pt"),
          legend.position = "none",
          plot.background = element_rect(fill=ifelse(background_color, moma.colors(color, 10)[1], NA), color=NA)
    )
  
  return(plot)
  
}

