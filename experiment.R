####################################
# If not installed, install:       #
#                                  #
# install.packages("Hmisc")        #
# install.packages("corrplot")     #
#                                  #
####################################

# set working dir, done with Session\Set working dir\To source file location

#####################################
#             LOAD DATA             #
#####################################

# read the data from Statistik Austria
# STATcube - Statistische Datenbank von STATISTIK AUSTRIA
# https://www.statistik.at/web_de/statistiken/energie_umwelt_innovation_mobilitaet/energie_und_umwelt/energie/index.html

data_stat <- read.csv2("data/table_stataustria.csv")

# clean up the data
# delete rows
data_stat <- data_stat[-33:-40,]
data_stat <- data_stat[-1:-7,]

# delete 
data_stat <- data_stat[,-2]
data_stat <- data_stat[,-3]
data_stat <- data_stat[,-4]
data_stat <- data_stat[,-5]

# order the data by year
data_stat <- data_stat[order(data_stat$STATcube),]

# this year column is not needed anymore
data_stat <- data_stat[,-1]

#data_stat <- format(data_stat, decimal.mark=",")
data_stat$X.1 <- as.numeric(gsub(",", ".", data_stat$X.1))
data_stat$X.3 <- as.numeric(gsub(",", ".", data_stat$X.3))
data_stat$X.5 <- as.numeric(gsub(",", ".", data_stat$X.5))

# read the data from data.gv: klima data
# https://www.data.gv.at/katalog/dataset/e6d471ec-f983-4e9a-b435-957cfc1bb48c

data_klima <- read.csv2("data/klimadaten2016.csv")

# clean up the data
# delete columns
data_klima <- data_klima[,-1:-5]
data_klima <- data_klima[,-2:-4]
data_klima <- data_klima[,-4:-9]
data_klima <- data_klima[,-5]

data_c <- cbind(data_klima, data_stat)

colnames(data_c) <- c("YEAR","C_ICE_DAYS", "C_SUMMER_DAYS", "C_MEAN_TEMP", "E_RENEWABLES", "E_OIL", "E_GAS")



#####################################
#         Output raw data           #
#####################################

# Write to csv
write.csv(data_c, file = "data/output.csv", row.names=FALSE)

#####################################
#           CORRELATION             #
#####################################

# Correlation standard
correl <- cor(data_c)
round(correl, 2)

# Correlation with p-vals
library("Hmisc")

rcorrel <- rcorr(as.matrix(data_c))
rcorrel


#####################################
#               PLOTS               #
#####################################


#library
library(latticeExtra)

#years
x <- data_c$YEAR

# ice days
val1 <- data_c$ICE_DAYS
# summer days
val2 <- data_c$SUMMER_DAYS
# mean
val3 <- data_c$MEAN_TEMPERTURE

# renewables
val4 <- data_c$X.1/1000
# oil
val45 <- data_c$X.3/1000
# gas
val6 <- data_c$X.5/1000

my.settings1 <- list(
  superpose.line=list(col=c("#FF2C0E","#FF910E", "#FFE20E", "#450EFF", "#0E91FF", "#0EF8FF"), border="transparent"),
  strip.border=list(col="black")
)
my.settings2 <- list(
  superpose.line=list(col=c("#450EFF", "#0E91FF", "#0EF8FF"), border="transparent"),
  strip.border=list(col="black")
)

data=data.frame(x,val1,val2,val3,val4,val5,val6)

xyplot(val1 + val2 + val3 ~ x, data, type = "l")

obj1 <- xyplot(val1 + val2 + val3 ~ x, data, type = "l" , lwd=2, par.settings = my.settings1, ylab="Energy types (peta Joul))")
obj2 <- xyplot(val4 + val5 + val6 ~ x, data, type = "l", lwd=2, par.settings = my.settings2, ylab="Climate values (days and °C)")

doubleYScale(obj1, obj2, use.style = FALSE, add.ylab2 = TRUE,  par.settings = my.settings1, auto.key=list(space="bottom", columns=6, text = c("ice days", "summer days", "mean temp", "renewables", "oil", "gas"), 
                                                                            title="", cex.title=1, lines=TRUE, points=FALSE))

###### Correlation plot #######

library(corrplot)

# Plot correlation
corrplot(correl, type = "upper", order = "alphabet", 
         tl.col = "black", tl.srt = 45, sig.level = 0.01, insig = "blank")
