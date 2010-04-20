elec <- read.delim("desktop/si618/data/GE_2004.txt", sep="\t", header=TRUE)
attach(elec)
qplot(CAND_CATEGORY, CAND_SEX, geom="step", xlab="test", ylab="test", position="dodge", color=CAND_SEX) + opts(axis.text.x=theme_text(size=8, angle=40, hjust=1), title="TEST", plot.title=theme_text(size=12), panel.grid.major = theme_line(size=0))
