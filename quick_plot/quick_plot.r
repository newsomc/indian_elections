#=========================================================================
# Quick and easy plots for exploratory data analysis with R
# by Clint Newsom
#
# date: 3/25/10
#=========================================================================
#import ggplot2
library(ggplot2)
#read in from website. 
elec = read.delim("http://hcnewsom.org/expldata/QryContestantsPC.txt", sep="\t", header=FALSE, col.names=c("state_code", "state_name", "pc_no", "pc_name", "schedule", "male", "female", "total", "schedule_no"))
#attach elec to dataframe
attach(elec)
#lets see what the first 6 rows of data are all about.
head(elec)
summary(elec)
#try a quick plot with a histogram for males.
qplot(male, data = elec, geom = "histogram", fill = schedule, binwidth=1)
ggsave("desktop/si618/homework/wk2/hist1.png")

#now with a density graph. 
qplot(male, data = elec, geom = "density", color = schedule, binwidth=1)
ggsave("desktop/si618/homework/wk2/density1.png")

#try a quick plot with a histogram for females.
qplot(female, data = elec, geom = "histogram", fill = schedule, binwidth=1)
ggsave("desktop/si618/homework/wk2/hist2.png")

#now with a density graph. 
qplot(female, data = elec, geom = "density", color = schedule, binwidth=1)
ggsave("desktop/si618/homework/wk2/density2.png")


#now lets make two new columns and calculate the percentage of males and females.
elec$percentfemale <- elec$female / elec$total * 100
elec$percentmale <- elec$male / elec$total * 100


#lets try plotting the percentage of males on a bar chart. Also, lets add proper labels.
qplot(percentmale, data = elec, geom="histogram") + ylab("total") + xlab("perent male")
ggsave("desktop/si618/homework/wk2/bar1.png")


#lets try plotting the percentage of females on a bar chart.
qplot(percentage, data = elec, geom="histogram") + ylab("total") + xlab("perent female")
ggsave("desktop/si618/homework/wk2/bar2.png")
