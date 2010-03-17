#=============================================================
# Analysis of Indian Election Commission data Using R
# by Clint Newsom 
# hcnewsom@gmail.com
#=============================================================

#load the ggplot2 graphical library into our R session.
library(ggplot2)

#get our data. http://eci.nic.in/archive/GE2004/index.htm
#I simply saved the data as a tab delimited text file and uploaded to my server. 

elec = read.delim("http://hcnewsom.org/expldata/QryContestantsPC.txt", sep="\t", header=FALSE, col.names=c("state_code", "state_name", "pc_no", "pc_name", "schedule", "male", "female", "total", "schedule_no"))

#lets work with two specific columns for each pie we want to create. We'll create one pie showing # of male candidates per state, and another showing the # of female candidates in Lok Sabha #elections.
male_set = subset(elec, select=c(2,6))
female_set = subset(elec, select=c(2,7))  

#now we attach each object to the dataframe.
attach(male_set)
attach(female_set)

#now lets try setting this up as a pie graph
pie_male = ggplot(male_set, aes(x=factor(1), y=male, fill=factor(male))) + geom_bar(width=1)

#display our bar chart as polar coordinates.
pie_male + coord_polar(theta="y")

pie_female = ggplot(female_set, aes(x=factor(1), y=female, fill=factor(female))) + geom_bar(width=1)
pie_female + coord_polar(theta="y")

#now lets try a coxcomb plot as detailed here: http://had.co.nz/ggplot2/coord_polar.html
pie_male = ggplot(male_set, aes(x=state_name, y=male, fill=factor(male))) + geom_bar(width=1)
pie_male + coord_polar(theta="x")

#another for the female set.
pie_female = ggplot(female_set, aes(x=state_name, y=female, fill=factor(female))) + geom_bar(width=1)
pie_female + coord_polar(theta="x")

