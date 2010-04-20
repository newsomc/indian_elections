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

# check our data
head(elec)

states <- factor(elec$state_name)
levels(states)
nlevels(states)
# without having to inspect the data set itself, levels() tells us all the states we need to deal with.
# nlevels() tells us how many states we need. 

#lets deal with data from Uttar Pradesh alone.
uttarPradesh <- elec[elec$state_name == "UTTAR PRADESH",]
head(uttarPradesh)

nrow(uttarPradesh)

percMale <- round(uttarPradesh$male / uttarPradesh$total * 100 )
totalPercMale <- sum(signif(percMale / nrow(uttarPradesh), digits = 2))
table(totalPercMale)

percFemale <- round(uttarPradesh$female / uttarPradesh$total * 100)
table(percFemale)

totalPercFemale <- sum(signif(percFemale / nrow(uttarPradesh), digits = 2))
table(totalPercFemale)

sex <- c(totalPercFemale, totalPercMale)
sex_labels <- paste(sex, "%", sep="")
pie(sex, main="Sex", col=rainbow(length(sex)),labels=c(sex_labels))




males <- c(uttarPradesh$male)
females <- c(uttarPradesh$female)

sort(males)
sort(females)

(pie <- ggplot(uttarPradesh, aes(x = factor(1), fill = factor(females))) + geom_bar(width = 1))
pie + coord_polar(theta="y")
ggsave("images/uttar_female_candidates.png")

pie = ggplot(uttarPradesh, aes(x=factor(1), fill=factor(males))) + geom_bar(width=1)
pie + coord_polar(theta="y")
ggsave("images/uttar_male_candidates.png")



