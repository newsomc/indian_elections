#=============================
# Exploring Layers and Stat
#
# by Clint Newsom
# 5/15/10
#=============================
ge = read.delim("desktop/si618/data/GE_2004.txt", sep="\t",header=T)

# attach dataframe.
attach(ge)

# load ggplot2
library(ggplot2)

# examine our data.
head(ge)

# Here we deal with the winning candidates only.
# We pull out first place candidates.
#===========================================

myregex <- "^1$"
geFirst <- na.omit(ge[grep(myregex, ge$POSITION, perl=T),])

g <- ggplot(geFirst)
head(geFirst)

male <- geFirst[geFirst$CAND_SEX == "M",]
head(male)

female <- geFirst[geFirst$CAND_SEX == "F",]
nrow(female) # we get the number of rows containing females in order to create a new array below.

#============================================
# first lets try setting up a pie that tells us how the
# number of female winning contestants compares to the number of males.
# Thanks to Josh Steverman for help with this.

fvec <- c()
fvec[1:45] <- "female"

mvec <- c()
mvec[1:498] <- "male"

newdf <- data.frame(c(fvec, mvec))
names(newdf) <- c("sex")

df <- data.frame(variable = c("female", "male"), value=c(sum(female$TOTVOTPOLL), sum(male$TOTVOTPOLL)))
head(df)

# fig. 1
ggplot(df, aes(x = "", y = value, fill = variable)) + geom_bar(width =1) + coord_polar(theta="y") + opts(title="Proportion Winning Male Candidates to Female Winning Candidates:\n 2004 Lok Sabha Elections")
ggsave("desktop/si618/homework/wk5/images/male_v_female_1st_place.png")

# Could it be that female candidates are also the worst performing?
# create a pie for 10-35th place.
#============================

summary(ge$POSITION)

# we use summary to find out the highest value of
# ge$Position-the worst a candidate can perform.

myreg <- "^2[0-9]|3[0-5]$"
geLow <- na.omit(ge[grep(myreg, ge$POSITION, perl=T),])
head(geLow) # verify we got the lower ranks of candidates. 

g <- ggplot(geLow)
head(geLow)

male <- geLow[geLow$CAND_SEX == "M",]
nrow(male)

female <- geLow[geLow$CAND_SEX == "F",]
nrow(female)

# build a pie for the lower half of the spectrum
# create a new vector for females with occurances of
# the string equalling the number of rows found.
fvec <- c()
fvec[1:5] <- "female"

# we do the same for males.
mvec <- c()
mvec[1:1224] <- "male"

newdf <- data.frame(c(fvec, mvec))
names(newdf) <- c("sex")

df <- data.frame(variable = c("female", "male"), value=c(sum(female$TOTVOTPOLL), sum(male$TOTVOTPOLL)))
head(df)

# fig. 2
ggplot(df, aes(x = "", y = value, fill = variable)) + geom_bar(width =1) + coord_polar(theta="y") + opts(title="Proportion Male to Female Candidates in 20-35th place: 2004 Lok Sabha Elections")
ggsave("desktop/si618/homework/wk5/images/male_v_female_10-35_place.png")

#===========================================
# layers

head(ge)
names(ge)
# All candidates.
cands <- (ge[YEAR == 2004 & TOTVOTPOLL !="NA" & ST_NAME !="NA" & POSITION !="NA" & PC_NAME !="NA" & PC_NO !="NA" & MONTH !="NA" & YEAR !="NA" & CAND_NAME != "NA" & CAND_SEX != "NA" & CAND_CATEGORY !="NA" & PARTYABBRE !="NA" & TOTVOTPOLL !="NA" & POSITION !="NA" & ST_CODE !="NA",])
head(cands)
summary(cands$TOTVOTPOLL)
nrow(cands)



# Winning candidates.
firstPlCands <- (ge[YEAR == 2004 & TOTVOTPOLL != "NA" & POSITION==1,])
nrow(firstPlCands)  # check number of rows
head(firstPlCands)
# lets show this with first place candidates. fig. 3 
g <- ggplot(cands, aes(CAND_CATEGORY, TOTVOTPOLL))
g <- g + layer(geom = c("jitter", "boxplot"))
g %+% firstPlCands + xlab("Candidate Category") + ylab("Total Votes Polled") + opts(title="Total Number of Votes Per Candidate by Category (First Place Candidates): 2004 Lok Sabha Elections")
ggsave("desktop/si618/homework/wk5/images/first_place_candidates.png")



# Total Votes polled by party. fig. 4
g <- ggplot(cands, aes(PARTYABBRE, TOTVOTPOLL, color=CAND_SEX))
g <- g + xlab("Party") + ylab("Total Votes Polled") + opts(title="Total Number of Votes Per Candidate: 2004 Lok Sabha Elections")
g = g + geom_jitter(position=position_jitter(width=1/20)) + opts(axis.text.x=theme_text(size=7, angle=45, hjust=1)) 
g 
ggsave("desktop/si618/homework/wk5/images/total_votes_by_party.png")


# look at Communist party of India. 
#=========================================
CPM <- (ge[YEAR == 2004 & TOTVOTPOLL != "NA" & PARTYABBRE=="CPM",])


# jitter plot of cnadidates by category. fig. 5
g <- ggplot(cands, aes(factor(ST_NAME), TOTVOTPOLL, colour=CAND_SEX))
g <- g + geom_jitter() + opts(title="Total Votes Polled by Communist Party Candidates Per State by Sex:\n 2004 Indian General Elections")
g %+% CPM + opts(axis.text.x=theme_text(size=8, angle=45, hjust=1))
ggsave("desktop/si618/homework/wk5/images/communist_candidates_by_state_by_sex.png")

# fig. 6
g <- g + geom_boxplot() + opts(title="Total Votes Polled by Communist Party Candidates per State by Sex:\n 2004 Indian General Elections")
g %+% CPM + opts(axis.text.x=theme_text(size=8, angle=45, hjust=1))
ggsave("desktop/si618/homework/wk5/images/communist_candidates_by_state_by_sex_box.png")

# hist INC candidates.
INC <- (ge[YEAR == 2004 & TOTVOTPOLL != "NA" & PARTYABBRE=="INC",])

# fig. 6
g <- ggplot(cands, aes(factor(ST_NAME), TOTVOTPOLL, colour=CAND_SEX))
g <- g + geom_jitter() + opts(title="Total Votes Polled by Indian National Congress Candidates, shown by Sex:\n 2004 Indian General Elections")
g %+% INC + opts(axis.text.x=theme_text(size=8, angle=45, hjust=1))
ggsave("desktop/si618/homework/wk5/images/inc_candidates.png")

# fig. 7
g <- ggplot(cands, aes(factor(ST_NAME), TOTVOTPOLL, colour=CAND_SEX))
g <- g + geom_boxplot(width=2) + opts(title="Total Votes Polled by Indian National Congress Candidates, shown by Sex:\n 2004 Indian General Elections")
g %+% INC + opts(axis.text.x=theme_text(size=8, angle=45, hjust=1))
ggsave("desktop/si618/homework/wk5/images/inc_candidates_boxplot.png")


#================================
# Extra stuff
#================================

pc = read.delim("desktop/si618/data/QryContestantsPC.txt", sep="\t",header=T)
attach(pc)
detach(pc)
head(pc)

m <- melt(pc)
head(m)
attach(m)
mm <- m[m$variable == "Male",] 
head(mm)

mf <- m[m$variable == "Female",]
head(mf)
p <- ggplot(pc, aes(x = factor(ST_NAME), colour = Male
