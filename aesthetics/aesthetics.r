

#============================================
# Aesthetics
# Clint Newsom
# hcnewsom@gmail.com
#============================================

#####################################
#####################################

# Begin by reading in our file as usual. This time we're using some new data! So we'll start by snipping off our original header
# to include more readable labels. 
elec = read.delim("http://hcnewsom.org/expldata/QryCandidates_AC.txt", sep="\t",header=FALSE, col.names=c("state_name","ac_number", "ac_name","schedule", "cand_sl_no", "candidate_name", "candidate_sex", "party_abbreviation", "party_name", "symbol_number", "symbol_description", "candidate_age", "candidate_category"))

# make sure our data is correct. 
head(elec)

# create a data frame. 
attach(elec)
library(ggplot2)
# Original Boxplot
qplot(candidate_category, candidate_age, data = elec, geom = "boxplot", fill=candidate_sex, binwidth=1, main="Age Distrobution by Sex:\n Indian Assembly Elections 2004") + xlab("Candidate Category") + ylab("Candidate Age")
ggsave("desktop/si618/homework/wk4/images/age_by_sex_boxplot.png")

# making a better boxplot
p <- ggplot(elec, aes(factor(candidate_category), candidate_age))

print(p + geom_boxplot(aes(fill=candidate_sex, color = candidate_sex,
size = 1.9)) + geom_point(aes(color = elec$candidate_sex)) + stat_summary(fun.y = median, geom ="crossbar",
ymin = 0, ymax=0, color = "grey90"))  # here we see medians are problematic
ggsave("desktop/si618/indian_elections/aesthetics/images/age_by_sex_boxplot.png")

# a fix for the medians
p <- ggplot(elec, aes(factor(candidate_sex), candidate_age)) + geom_boxplot(aes(fill = candidate_sex, colour = candidate_sex), size = 1.9) + stat_summary(fun.y = median, fun.ymax = median, fun.ymin = median, geom = "crossbar", color = "grey90") + facet_grid(. ~ candidate_category)
print(p)
ggsave("desktop/si618/indian_elections/aesthetics/images/age_by_sex_boxplot2.png")

# with manual calculation of outliers.
p <- ggplot(elec, aes(factor(candidate_sex), candidate_age, fill = candidate_sex, colour = candidate_sex), xlim = c(-0.6, 0.5)) + geom_boxplot(size = 1.9, outlier.colour = NA) + stat_summary(fun.y = median, fun.ymax = median, fun.ymin = median, geom = "crossbar", color = "grey90") + geom_point(data = elec$cadidate_age, xlim = c(-0.6, 0.5)) + facet_grid(. ~ candidate_category) + opts(axis.text.x = theme_text(angle = 90, hjust = 1, size = 8, colour = "grey40")) + scale_fill_manual(val = c("grey70", "grey50","grey30")) + scale_colour_manual(val = c("grey70", "grey50", "grey30"))
print(p)
ggsave("desktop/si618/indian_elections/aesthetics/images/age_by_sex_boxplot3.png")


detach(elec)

#######################################################
#######################################################
# similar plot using General Election Data
ge = read.delim("desktop/si618/data/GE_2004.txt", sep="\t",header=T)

up <- ge[ge$ST_NAME == "UTTAR PRADESH",]
head(up)

attach(ge)

head(ge)
head(elec)
fact <- factor(CAND_SEX)
levels(fact)
g <- ggplot(ge, aes(factor(PARTYABBRE), CAND_SEX))
print(g + geom_boxplot(aes(fill=CAND_SEX, color = CAND_SEX,
size = 1.9)) + geom_point(aes(color = ge$CAND_SEX)) + stat_summary(fun.y = median, geom ="crossbar",
ymin = 0, ymax=0, color = "grey90"))  # here we see medians are problematic




g <- ggplot(ge, aes(factor(CAND_SEX), TOTVOTPOLL))
+ geom_boxplot(aes(fill = CAND_SEX, colour = candidate_sex), size = 1.9)
+ stat_summary(fun.y = median, fun.ymax = median, fun.ymin = median, geom = "crossbar", color = "grey90")
+ facet_grid(. ~ CAND_CATEGORY)
print(p)
