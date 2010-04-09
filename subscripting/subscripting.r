#============================================
# Quick Subscripting and Layering with R and GGPlot2
# by Clint Newsom
# hcnewsom@gmail.com
#============================================


# Begin by reading in our file as usual. This time we're using some new data! So we'll start by snipping off our original header
# to include more readable labels. 
elec = read.delim("http://hcnewsom.org/expldata/QryCandidates_AC.txt", sep="\t",header=FALSE, col.names=c("state_name","ac_number", "ac_name","schedule", "cand_sl_no", "candidate_name", "candidate_sex", "party_abbreviation", "party_name", "symbol_number", "symbol_description", "candidate_age", "candidate_category"))

# make sure our data is correct. 
head(elec)

# check out a summary of our data. 
summary(elec)

# create a data frame. 
attach(elec)

# another way to see what's up witn your data is to
# list out your columns with the names() function. 
names(elec)

# Now, suppose we want to see the symbol_description column. Each party is required to include
# a party smybol on election ballots. This was a law put into place by parliament in order
# those who spoke/read dialects other than Hindi, or were otherwise illiterate, capable of voting.
# If you output this data to the screen you are going to get a very long list of symbols. 
elec$symbol_description

# Lets try a shortcut. let's pull out the column by its position. 
elec[11]

# one more way of doing this...
elec["symbol_description"]

# Using two brackets will return he number of levels in our column.
elec[[11]]

# try getting a summary of the levels.
str(elec[[11]])

# retrive the mode of our summary.
mode(elec[[11]])

# now lets grab some specific rows. Ask for row 10.
elec[10,]

# This returns the areoplane symbol for an Independant party running in Andrah Pradesh.
elec[505,1:11]

#now lets ask for a specific sequence of columns.
names(elec)
#return state_name, candidate_name, candidate_sex, symbol_description, candidate_age
elec[c(1,6,7,11,12)]

# Now lets asks for a squence of columns and rows. Here we're asking for rows 1 through 20 and
# columns 1 through 11.
test <- elec[1:320, 1:7]

head(test)

qplot(candidate_sex, data=test, fill=stat)
ggsave("test.png")

# Now let's try pulling making a filter.
# The most prominent parties in India are the Indian National Congress (INC) and the Bharatiya Janata Party (BJP).
# Lets try filtering for these parties by symbol number get a sense of the most prominent party smybols for all other parties.
# By looking at the data we see the code for the INC's hand symbol is 79. The code for the BJP's Lotus symbol is 99.
minusINCandBJP <- elec[elec$symbol_number!=79 & elec$symbol_number !=99,]
head(minusINCandBJP[1:11])


# now we may just want to see what's going on with the independent parties.
onlyInd <- elec[elec$party_abbreviation == "IND",]
qplot(candidate_sex, data=onlyInd, fill = state_name, binwidth=20)
ggsave("independent_parties_sex.png");


# how about candidates below 40 years of age?
below40 <- elec[elec$candidate_age < 40,]
head(below40)

qplot(candidate_age, data=below40, fill = candidate_sex)
ggsave("age_hist.png");
                 

qplot(state_name, data = sub, geom = "histogram", fill = candidate_sex, binwidth=1)
ggsave("hist2.png")
# the histogram visualization doesn't work that well for us. There are too many symbols, therefore
# our colors blend too closely together.  


# now lets try subscripting for particular state. Let's try Karnataka.
karnataka <- elec[elec$state_name == "KARNATAKA",]
head(karnataka)

# now lets just look at candidates for the INC, the Indian Natinal Congress.  
INC <- karnataka[karnataka$party_abbreviation == "INC",]

names(INC)

# now that we have this data, lets just grab the data we want to use, making a subset. There is bound to be a lot of
# repititious data here

# how do our results by age differ if looking only at Kanataka?
pie = ggplot(ac_name, data=INC, aes(x=factor(1), y=ac_name, fill=candidate_age)) + geom_bar(width=1)

qplot(candidate_age, data = INC, geom = "histogram", fill=schedule, binwidth=1)
ggsave("kanataka_age_hist3.png");
