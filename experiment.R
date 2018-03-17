source ('import_data.R')

colnames(activity_data)
nrow(activity_data)
ncol(activity_data)
summary(activity_data)
activity_data

table(activity_data ~ date)
table(activity_data$steps ~ date)
TotalStepsByDate = aggregate(steps ~ date,data = activity_data, FUN=sum)
hist(TotalStepsByDate$steps, main ='Histogram of steps per day', xlab = 'Steps per day')

mean(TotalStepsByDate$steps)
median(TotalStepsByDate$steps)

AverageStepsByInterval = aggregate(steps ~ interval, data = activity_data, FUN = mean)
AverageStepsByInterval
plot(AverageStepsByInterval$interval, AverageStepsByInterval$steps, type="l", xlab = '24hour time', ylab = 'steps taken', main = 'Average steps taken during the day')
max(AverageStepsByInterval$steps)

AverageStepsByInterval[which.max(AverageStepsByInterval$steps),'interval',]
range(activity_data$interval)
AverageStepsByInterval
sum(is.na(activity_data))

missing_steps = function (x)
{
  print (class(x))
}
sapply(activity_data, missing_steps)
activity_data$date

activity_data
activity_data_noNAs = activity_data
for (i in 1:nrow(activity_data_noNAs)){
  if (is.na( activity_data[i,1] ) ){
    activity_data[i, 1] = activityStepsByIntervals[where]
  }
    
}
is.na(activity_data$steps)

activity_data_noNAs = activity_data

activity_data_noNAs[is.na(activity_data$steps),1]=AverageStepsByInterval[which(AverageStepsByInterval$'interval' == activity_data[is.na(activity_data$steps),3]),2]

noNA_TotalStepsPerDay = aggregate(steps ~ date, activity_data_noNAs, FUN = sum)
hist(noNA_TotalStepsPerDay$steps,main ='Histogram #2 of steps per day', xlab = 'Steps per day')
mean (noNA_TotalStepsPerDay$steps)
median (noNA_TotalStepsPerDay$steps)


AverageStepsByInterval[which(AverageStepsByInterval$'interval' == 0),]
activity_data_noNAs[1:5,]

library(chron)
activity_data_noNAs$dayType = 'weekday'
activity_data_noNAs[is.weekend(activity_data_noNAs$date),4] = 'weekend'
activity_data_noNAs[which(activity_data_noNAs$dayType == 'weekend'),]
meanStepsDailyByDayType = aggregate(steps ~ interval + dayType, data = activity_data_noNAs,FUN=mean)
meanStepsDailyByDayType
library (ggplot2)
ggplot(meanStepsDailyByDayType, aes(x=interval, y=steps, color = dayType)) + geom_line()+labs(color = "", title = "Steps throughout the day - weekday vs end")

colnames(activity_data_noNAs)
table(activity_data_noNAs$dayType)
levels(factor(activity_data_noNAs$dayType))
weekdays(as.character.date(activity_data$date) )
weekdays(.leap.seconds)
weekdays('2017-01-01')

sum(is.weekend(activity_data$date))
nrow(activity_data)
AverageStepsByInterval[1:5,]
weekdays