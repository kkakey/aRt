### VERSION 2
### play with color and sizing (maxy and maxx)

library(dplyr)
library(ggplot2)

maxy <- 10 #850
yrow <- 0
maxx <- 50#100

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
  print(paste0('yrow:',yrow))

  for (x in seq(1, maxx)) {
    
      print(paste0('x:',x))
    
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
        print(x1)
        x2 <- c(runif(1, min=2, max=10))
        print(x2)
        next
      }
    
  }
}


x1 <- 0
x2 <- 2
y1 <- 0
y2 <- 1

# Create a matrix of coordinates for the square
coords <- matrix(c(x1, y1,  # bottom-left corner
                   x2, y1,  # bottom-right corner
                   x2, y2,  # top-right corner
                   x1, y2,  # top-left corner
                   x1, y1), # closing the square (back to bottom-left)
                 ncol = 2, byrow = TRUE)

# Create an sf object (polygon)
square_sf <- sf::st_sfc(sf::st_polygon(list(coords)))
sf::st_crs(square_sf) <- 4326
plot(square_sf)

plot_sf <- sf::st_sf(coords, geometry = square_sf)

plot_sf$fillstyle <- "cross-hatch"
plot_sf$fillstyle <- NA
plot_sf$fillweight <- 0.8


roughsf::roughsf(
  plot_sf,
  width = 800,
  height = 800,
)



plot <-
  ggplot() +
  geom_rect(data=d, mapping=aes(xmin=x1, xmax=x2, ymin=y1, ymax=y2, fill=as.numeric(r)), 
            color="black") +
  # scale_fill_gradient(low="#F1C2FF", high="#3F0052") +
  theme_void() +
  theme(plot.margin = unit(c(bottom=.5, left=.5, top=.5, right=.5),"cm"),
    legend.position = "none",
    plot.background = element_rect(fill="#FFBC0A", color=NA)
  )




ggsave('/Users/kristenakey/Documents/GitHub/aRt/tetris/v1.png', height=6, width=6, dpi=300)

