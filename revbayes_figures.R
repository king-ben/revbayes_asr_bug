setwd(dirname(rstudioapi::getSourceEditorContext()$path))

library(RevGadgets)
library(ggplot2)
library(gridExtra)

cols <- c("#e01a0f", "#f2a498", colorRampPalette(c("#94ebf7", "#0e1c84"))(7))

words <- c("bad", "bone", "branch", "dull_blunt", "fire", "kill", "lake", "smell", "squeeze", "swell", "tail")

pdf("figures/allfigs.pdf", height=27, width=24)
figs <- list()

for(i in words){
  anc <- processAncStates(paste0("annotated_trees/annotated_", i, ".log"),
                          state_labels = c("0" = "0 Trills present",
                                           "1" = "1 Trills absent",
                                           "2" = "2 Other cognate 1",
                                           "3" = "3 Other cognate 2",
                                           "4" = "4 Other cognate 3",
                                           "5" = "5 Other cognate 4",
                                           "6" = "6 Other cognate 5",
                                           "7" = "7 Other cognate 6",
                                           "8" = "8 Other cognate 7"))
  
  # pdf(file=paste0("figures/", i, ".pdf"), height=8, width=6)
  p <- plotAncStatesPie(t = anc, 
                   pie_color=cols,
                   node_pie_size=2,
                   tip_pie_size=1,
                   tip_labels_offset = 100,
                   tip_labels_size = 5
                   )
  p <- p+theme(legend.position="none") + ggtitle(i) +
    theme(plot.title = element_text(hjust = 0.5, size = 35))
  figs[[i]] <- p
  
}

do.call("grid.arrange", c(figs, ncol=4))

dev.off()
