fileURL = 'https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip'
if (!file.exists('./data/activity.csv')){
  download.file(fileURL, destfile = "./data/repdata data activity.zip", method="curl")
  unzip('./data/repdata data activity.zip', exdir="./data/")
}

activity_data = read.csv('./data/activity.csv')  
