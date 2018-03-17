source ('import_data.R')
library(chron)
library (ggplot2)

TotalStepsByDate = aggregate(steps ~ date,data = activity_data, FUN=sum)
hist(TotalStepsByDate$steps, main ='Histogram of steps per day', xlab = 'Steps per day')
dev.copy(png, file='./figure/plot1.png')
dev.off()

AverageStepsByInterval = aggregate(steps ~ interval, data = activity_data, FUN = mean)
plot(AverageStepsByInterval$interval, AverageStepsByInterval$steps, type="l", xlab = '24hour time', ylab = 'steps taken', main = 'Average steps taken during the day')
dev.copy(png, file='./figure/plot2.png')
dev.off()

activity_data_noNAs = activity_data
MedianStepsByInterval = aggregate(steps ~ interval, data = activity_data, FUN = median)
activity_data_noNAs[is.na(activity_data$steps),1]=MedianStepsByInterval[which(MedianStepsByInterval$'interval' == activity_data[is.na(activity_data$steps),3]),2]

noNA_TotalStepsPerDay = aggregate(steps ~ date, activity_data_noNAs, FUN = sum)
hist(noNA_TotalStepsPerDay$steps,main ='Histogram #2 of steps per day', xlab = 'Steps per day')
dev.copy(png, file='./figure/plot3.png')
dev.off()

Sys.setenv(TZ="Europe/Berlin")
activity_data_noNAs$dayType = 'weekday'
activity_data_noNAs[is.weekend(activity_data_noNAs$date),4] = 'weekend'
meanStepsDailyByDayType = aggregate(steps ~ interval + dayType, data = activity_data_noNAs,FUN=mean)

par(mfrow = c(2,1) )
#plot(meanStepsDailyByDayType[which(meanStepsDailyByDayType$dayType == 'weekday'),], )
plot(meanStepsDailyByDayType[which(meanStepsDailyByDayType$dayType == 'weekday'),]$interval, meanStepsDailyByDayType[which(meanStepsDailyByDayType$dayType == 'weekday'),]$steps, type="l", xlab = '24hour time', ylab = 'steps taken', main = 'Average steps taken during a weekday')
plot(meanStepsDailyByDayType[which(meanStepsDailyByDayType$dayType == 'weekend'),]$interval, meanStepsDailyByDayType[which(meanStepsDailyByDayType$dayType == 'weekend'),]$steps, type="l", xlab = '24hour time', ylab = 'steps taken', main = 'Average steps taken during a weekend')
dev.copy(png, file='./figure/plot4.png')
dev.off()

