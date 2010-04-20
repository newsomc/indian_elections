#=====================================
# Quick and simple pie with R and ggplot2
# Data from the 2004 State Assembly Elections
# by Clint Newsom
#
# hcnewsom@gmail.com
#=====================================

# read in the file. 
elec = read.delim("http://hcnewsom.org/expldata/QryCandidates_AC.txt", sep="\t",header=FALSE, col.names=c("state_name","ac_number", "ac_name","schedule", "cand_sl_no", "candidate_name", "candidate_sex", "party_abbreviation", "party_name", "symbol_number", "symbol_description", "candidate_age", "candidate_category"))
elec = read.delim("http://hcnewsom.org/expldata/QryCandidates_AC.txt", sep="\t",header=FALSE, col.names=c("state_name","ac_number", "ac_name","schedule", "cand_sl_no", "candidate_name", "candidate_sex", "party_abbreviation", "party_name", "symbol_number", "symbol_description", "candidate_age", "candidate_category"))


class(elec)

# attach our dataframe
attach(elec)

# check our data.
head(elec)

# lets see how many states where dealing with. Turns out we have 4 states that ran elections to state assemblies in 2004. 
summary(elec)

# load ggplot2
library(ggplot2)

# lets make a pie comparing male to female contestants. Generates fig. 1
pie = ggplot(elec, aes(x=factor(1), elec$candidate_sex, fill=elec$candidate_sex)) + geom_bar(binwdith=1) + opts(title="Male vs. Female Contestants: 2004 State Assembly Elections")
pie + coord_polar(theta="y")

# save our output. 
ggsave("images/male_v_female_pie.png")

# lets make a pie comparing schedules competing in each election. Generates fig. 2
pie = ggplot(elec, aes(x=factor(1), elec$candidate_category, fill=elec$candidate_category)) + geom_bar(binwdith=1) + opts(title="Schedule Comparison: 2004 State Assembly Elections")
pie + coord_polar(theta="y")
ggsave("desktop/si618/schedules_pie.png")

# lets try one more pie based on candidate age. We need to establish a few cutpoints and groups.
# first, lets see where to start. Summary will give us a good idea. 
summary(elec$candidate_age)

# we make establish groups that will appear as labels in our legend.  
groups=c("25-30","30-40", "40-50", "50-60", "60-70", "70-80", "80-87")

# create some cutpoints. Here I illustrate the use of min and max.  
cutpoints=c(min(candidate_age),30,40,50,60,70,80,max(candidate_age))

# now we use the cut function. To learn more about cut, type ?cut in the R console.
divs=cut(candidate_age, breaks=cutpoints,labels=groups)

# build a pie chart. Generates fig. 3
pie = ggplot(elec, aes(x = factor(1), fill = factor(divs))) 
pie = ggplot(elec, aes(x = factor(1), fill = factor(divs))) + geom_bar(width = 1) + opts(title="Candidate Age: 2004 India State Assembly Elections") 
pie + coord_polar(theta = "y")
ggsave("images/assembly_candidate_ages.png")

# this will output a bullseye chart.
pie + coord_polar(theta = "x")
ggsave("images/assembly_candidate_ages_bullseye.png")

# a race track plot of candidate ages.
pie = ggplot(elec, aes(x = (divs), fill = factor(candidate_category))) + geom_bar(width = 0.9) + opts(title="Candidate Age by Type: \n2004 India State Assembly Elections") 
pie
ggsave("desktop/si618/indian_elections/pie/images/barchart.png")

pie + coord_polar(theta = "y")
ggsave("images/assembly_candidate_ages_by_type_racetrack.png")


