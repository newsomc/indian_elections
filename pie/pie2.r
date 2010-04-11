#=====================================
# Quick and simple pie with R and ggplot2
# by Clint Newsom
#
# hcnewsom@gmail.com
#=====================================


elec = read.delim("http://hcnewsom.org/expldata/QryCandidates_AC.txt", sep="\t",header=FALSE, col.names=c("state_name","ac_number", "ac_name","schedule", "cand_sl_no", "candidate_name", "candidate_sex", "party_abbreviation", "party_name", "symbol_number", "symbol_description", "candidate_age", "candidate_category"))

# check our data
head(elec)

# lets see how many states where dealing with. Turns out we have 4 states that ran elections to state assemblies in 2004. 
summary(elec$state_name)

# load ggplot2
library(ggplot2)

# lets make a pie comparing male to female contestants.  
pie = ggplot(elec, aes(x=factor(1), elec$candidate_sex, fill=elec$candidate_sex)) + geom_bar(binwdith=1) + opts(title="Male vs. Female Contestants: 2004 State Assembly Elections")
pie + coord_polar(theta="y")

# save our output. 
ggsave("images/male_v_female_pie.png")

# lets make a pie comparing schedules competing in each election.
pie = ggplot(elec, aes(x=factor(1), elec$schedule, fill=elec$schedule)) + geom_bar(binwdith=1) + opts(title="Schedule Comparison: 2004 State Assembly Elections")
pie + coord_polar(theta="y")
ggsave("images/schedules_pie.png")

# now lets compare the difference in male/female candidates for the 2004 state elections,
# in Andrha Pradesh, Karnatakaka, Orissa, Sikkim to those of the 2004 general election.
# this requires loading in a new data set.

ST_CODE	ST_NAME	PC_NO	PC_NAME	PC_TYPE	MONTH	YEAR	CAND_NAME	CAND_SEX	CAND_CATEGORY	PARTYABBRE	TOTVOTPOLL	POSITION
gelec = read.delim("http://hcnewsom.org/expldata/GE_2004.txt", sep="\t",header=FALSE, col.names=c("st_code", "state_name","pc_no", "pc_name", "pc_type", "month", "year", "cand_name", "cand_sex", "cand_category", "party_abbre", "tvotl", "position"))

# this data set contains the position of each candidate in the polls. We could create a subscript to
# pull out the winning candidates. We see we are dealing with 36 states. 
summary(gelec)
table(gelec$cand_sex)

# the output of this code leads us to believe there is either an error in the data
# or a high number candidates where gender is unknown. 
pie = ggplot(gelec, aes(x=factor(gelec$cand_sex), fill=gelec$cand_sex)) + geom_bar(binwdith=1) + opts(title="Candidate Gender Comparison: 2004 State Assembly Elections")
pie + coord_polar(theta="y")

