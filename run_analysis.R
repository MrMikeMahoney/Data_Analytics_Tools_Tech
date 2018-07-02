###### This is HW1 from Data Analytics Tools and Techniques
### Where the real magic happens
X_test = read.table("C:/Users/Mike/Documents/Data Analytics Tools and Techniques/UCI_HAR_Dataset/UCI HAR Dataset/test/X_test.txt", sep="")
y_test = read.table("C:/Users/Mike/Documents/Data Analytics Tools and Techniques/UCI_HAR_Dataset/UCI HAR Dataset/test/y_test.txt")
X_train = read.table("C:/Users/Mike/Documents/Data Analytics Tools and Techniques/UCI_HAR_Dataset/UCI HAR Dataset/train/X_train.txt", sep="")
y_train = read.table("C:/Users/Mike/Documents/Data Analytics Tools and Techniques/UCI_HAR_Dataset/UCI HAR Dataset/train/y_train.txt")

### Reading our features table >> Need to turn it into a list or vector
features = read.table("C:/Users/Mike/Documents/Data Analytics Tools and Techniques/UCI_HAR_Dataset/UCI HAR Dataset/features.txt")
features$V1 <- NULL
### Removing the "()" from features
#features$V2 <- as.character(gsub("[\\()]", "", features$V2))
#features <- data.frame

#mc_test <- NULL
### Creating master_data >> Which is as of now just a merge of X_train and X_test
master_data <- rbind(X_train, X_test)
mc_test <- master_data
### Renaming Col Names with the features >> features$V2
#colnames(mc_test) <- features$V2
colnames(master_data) <- features$V2

### Creating Response >> Which is Y_test and Y_train merged
response <- rbind(y_train, y_test)
colnames(response) <- "response"

### Merging the master data with the response data
master_data <- cbind(master_data, response)

### A list of the subset of mean or std measurements >> Indexing the columns
feature_subset <- c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,
                    266:271,294:296,345:350,373:375,424:429,452:454,503:504,513,516:517,526,
                    529:530,539,542:543,552,555:561,562)

### Applying our index list to our dataset
master_data <- master_data[,feature_subset]


### Reading in activity_labels
activity_labels <- read.table("C:/Users/Mike/Documents/Data Analytics Tools and Techniques/UCI_HAR_Dataset/UCI HAR Dataset/activity_labels.txt")
activity_labels$V1 <- NULL

### Created Function to recode Response
recode_response <- function(response) {
  if (response == 1) return("WALKING") else
  if (response == 2) return("WALKING_UPSTAIRS") else
  if (response == 3) return("WALKING_DOWNSTAIRS") else
  if (response == 4) return("SITTING") else
  if (response == 5) return("STANDING") else
  if (response == 6) return("LAYING") else
                     return("ERROR")}

### Applying the label to the Response variable
mc_test <- master_data
#recode_responde(mc_test$response)
#mc_test$response <- sapply(mc_test$response, recode_response)
master_data$response <- sapply(master_data$response, recode_response)

######## Step 5 >> Average Variables
### Uploading the subject
subject_test <- read.table("C:/Users/Mike/Documents/Data Analytics Tools and Techniques/UCI_HAR_Dataset/UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("C:/Users/Mike/Documents/Data Analytics Tools and Techniques/UCI_HAR_Dataset/UCI HAR Dataset/train/subject_train.txt")
subject <- rbind(subject_train, subject_test)
colnames(subject) <- "subject"

### merging the master_data and subject
subject_data <- cbind(subject, master_data)
#subject_data <- NULL

#### A for loop to get a count of obs in each subject
subject_number <- 1:24
i=1
for(i in subject_number){
  info <- length(grep(i, subject_data$subject))
  print(paste("subject",i, "has", info, "# of observations"))
  i =+ 1
}

### Filtering our subject_data >> to get the mean
require(dplyr)
#sub_mc_test <- group_by(subject_data, subject, response)
subject_data_mean <- subject_data %>%
                group_by(subject, response) %>%
                summarize_all(funs(mean))
              
write.table(subject_data_mean, "C:/Users/Mike/Documents/Data Analytics Tools and Techniques/subject_data_mean.txt", row.names = FALSE)
