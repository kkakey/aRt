librarylibrary(patchwork)
source("tetris.R")

### line color
### make some tranparent
### what about hatching design"
### gif: same design -- but go between hatcing and non hatching

library(patchwork)
p1 <- tetris(background_color = F)
p2 <- tetris(background_color = F)
p3 <- tetris(background_color = F)
p4 <- tetris(background_color = F)
p5 <- tetris(background_color = F)
design <- c(
  area(1, 1, 2),
  area(1, 2, 1, 3),
  area(2, 3, 3),
  area(3, 1, 3, 2),
  area(2, 2)
)
ok <- p1 + p2 + p3 + p4 + p5 + 
  plot_layout(design = design) + 
  plot_annotation(theme = theme(plot.margin = margin(-1, 0, -1, 0, "pt"),
    plot.background = element_rect(fill=moma.colors("OKeeffe", 10)[1], color=moma.colors("OKeeffe", 10)[1])))

ggsave(plot=ok, "okeeffe_patch.png", dpi=300, height=10, width=10)



p1 <- tetris(background_color = F, color="Koons")
p2 <- tetris(background_color = F, color="Koons")
p3 <- tetris(background_color = F, color="Koons")
p4 <- tetris(background_color = F, color="Koons")
p5 <- tetris(background_color = F, color="Koons")

koons <- p1 + p2 + p3 + p4 + p5 +
  plot_layout(design = design, ncol = 6, nrow=6) + 
  plot_annotation(theme = theme(plot.margin = margin(-1, 0, -1, 0, "pt"),
    plot.background = element_rect(fill=moma.colors("Koons", 10)[1], color=moma.colors("Koons", 10)[1])))
ggsave(plot=koons, "koons_patch.png", dpi=300, height=10, width=10)



p1 <- tetris(background_color = F, color="Sidhu")
p2 <- tetris(background_color = F, color="Sidhu")
p3 <- tetris(background_color = F, color="Sidhu")
p4 <- tetris(background_color = F, color="Sidhu")
p5 <- tetris(background_color = F, color="Sidhu")

si <- p1 + p2 + p3 + p4 + p5 +
  plot_layout(design = design, ncol = 6, nrow=6) + 
  plot_annotation(theme = theme(plot.margin = margin(-1, 0, -1, 0, "pt"),
    plot.background = element_rect(fill=moma.colors("Sidhu", 10)[1], color= moma.colors("Sidhu", 10)[1])))

ggsave(plot=si, "sidhu_patch.png", dpi=300, height=10, width=10)



p1 <- tetris(background_color = F, color="Warhol")
p2 <- tetris(background_color = F, color="Warhol")
p3 <- tetris(background_color = F, color="Warhol")
p4 <- tetris(background_color = F, color="Warhol")
p5 <- tetris(background_color = F, color="Warhol")

wa <- p1 + p2 + p3 + p4 + p5 +
  plot_layout(design = design, ncol = 6, nrow=6) + 
  plot_annotation(theme = theme(plot.margin = margin(-1, 0, -1, 0, "pt"),
    plot.background = element_rect(fill=moma.colors("Warhol", 10)[1], 
                                                               color = moma.colors("Warhol", 10)[1])))

ggsave(plot=wa, "warhol_patch.png", dpi=300, height=10, width=10)



all_patch <- cowplot::plot_grid(plotlist=rep(list(ok, koons, si), 3), greedy=T, ncol=3, nrow=3)
ggsave(plot=all_patch, "all_plot1.png", width=12, height = 12)


list(ok, koons, si, koons, ok, si, si, ok, koons)


all_patch <- cowplot::plot_grid(plotlist=list(ok, koons, si, koons, ok, koons, si, koons, ok), greedy=T, ncol=3, nrow=3)
ggsave(plot=all_patch, "all_plot2.png", width=12, height = 12)



#########

for(i in 1:30){
  gg <- tetris(maxy = 60, maxx = 120, yrow = 25, background_color = T, color="Warhol")
  ggsave(sprintf("gif/warhol%03d.png", i), gg)
}

png_files <- Sys.glob("gif/warhol*.png")

library(gifski)
gifski(
  png_files,
  "warhol2.gif",
  width = 400, height = 400,
  # delay = 1/5 # 5 images per second
  delay = 1/2 # 5 images per second
)

file.remove(png_files)
