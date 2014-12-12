run_analysis <- function(){
    trainingx <- read.table("X_train.txt", sep = "", header = FALSE)
    #print(nrow(trainingx))

    testx <- read.table("X_test.txt", sep = "", header = FALSE)
    #print(nrow(testx))

    alldata <- rbind(trainingx,testx)
    #print(nrow(alldata))

    features <- read.table("features.txt", sep="",header = FALSE)

####################################################################################
## Extract the name column(V2) from the features data.
## The name data.frame will correspond with the columns in the alldata data.frame.
## For exmaple 1 correspond with V1, 2 correspond with V2, tec.

    name <- subset(features, select = c(V2))

## Now extract only the columns that are measurements for mean and standard deviation 
## for each measurement.  The name data frame record numbers corresponds with the columns 
## in the alldata data frame.

    measurments <- subset(alldata, select = c("V1","V2","V3","V4","V5","V6","V41","V42","V43","V44","V45","V46",
                                          "V81","V82","V83","V84","V85","V86","V121","V122","V123","V124","V125","V126",
                                          "V161","V162","V163","V164","V165","V166","V201","V202","V214","V215","V227","V228",
                                          "V240","V241","V253","V254","V266","V267","V268","V269","V270","V271","V345","V346",
                                          "V347","V348","V349","V350","V424","V425","V426","V427","V428","V429","V503","V504",
                                          "V516","V517","V529","V530","V542","V543","V556","V557","V558","V559","V560","V561"))

## Now create the new column headings for the selected columns

    colnames(measurments) <- c("tBodyAcc_mean_X",    "tBodyAcc_mean_Y",    "tBodyAcc_mean_Z",    "tBodyAcc_std_X",    "tBodyAcc_std_Y",    "tBodyAcc_std_Z",
                               "tGravityAcc_mean_X", "tGravityAcc_mean_Y", "tGravityAcc_mean_Z", "tGravityAcc_std_X", "tGravityAcc_std_Y", "tGravityAcc_std_Z",
                               "tBodyAccJerk_mean_X","tBodyAccJerk_mean_Y","tBodyAccJerk_mean_Z","tBodyAccJerk_std_X","tBodyAccJerk_std_Y","tBodyAccJerk_std_Z",
                               "tBodyGyro_mean_X",   "tBodyGyro_mean_Y",   "tBodyGyro_mean_Z",   "tBodyGyro_std_X",   "tBodyGyro_std_Y",   "tBodyGyro_std_Z",
                               "tBodyGyroJerk_mean_X","tBodyGyroJerk_mean_Y","tBodyGyroJerk_mean_Z","tBodyGyroJerk_std_X","tBodyGyroJerk_std_Y","tBodyGyroJerk_std_Z",
                               "tBodyAccMag_mean",    "tBodyAccMag_std",    "tGravityAccMag_mean", "tGravityAccMag_std","tBodyAccJerkMag_mean","tBodyAccJerkMag_std",
                               "tBodyGyroMag_mean",   "tBodyGyroMag_std",   "tBodyGyroJerkMag_mean","tBodyGyroJerkMag_std","fBodyAcc_mean_X","fBodyAcc_mean_Y",
                               "fBodyAcc_mean_Z",     "fBodyAcc_std_X",     "fBodyAcc_std_Y",       "fBodyAcc_std_Z",    "fBodyAccJerk_mean_X","fBodyAccJerk_mean_Y",
                               "fBodyAccJerk_mean_Z","fBodyAccJerk_std_X","fBodyAccJerk_std_Y","fBodyAccJerk_std_Z","fBodyGyro_mean_X","fBodyGyro_mean_Y",
                               "fBodyGyro_mean_Z",   "fBodyGyro_std_X",   "fBodyGyro_std_Y",   "fBodyGyro_std_Z",   "fBodyAccMag_mean","fBodyAccMag_std",
                               "fBodyBodyAccJerkMag_mean","fBodyBodyAccJerkMag_std","fBodyBodyGyroMag_mean","fBodyBodyGyroMag_std","fBodyBodyGyroJerkMag_mean","fBodyBodyGyroJerkMag_std",
                               "angletBodyAccJerkMeangravityMean","angletBodyGyroMeangravityMean","angletBodyGyroJerkMeangravityMean","angleXgravityMean","angleYgravityMean","angleZgravityMean")

## Now create a subset of the measurments data frame that
## only contain the average columns.
    
    get_means <- data.frame( x = c(colnames(measurments)))
    ans <- get_means[grep("[Mm]ean", get_means$x),]
    
## For better reading, made a data frame
## Then selected each row from the data frame as a list item in the subset 
    ans <- data.frame(ans)
    
    all_means <- subset(measurments, select = c("tBodyAcc_mean_X","tBodyAcc_mean_Y","tBodyAcc_mean_Z","tGravityAcc_mean_X","tGravityAcc_mean_Y","tGravityAcc_mean_Z",
                                                "tBodyAccJerk_mean_X","tBodyAccJerk_mean_Y","tBodyAccJerk_mean_Z","tBodyGyro_mean_X","tBodyGyro_mean_Y","tBodyGyro_mean_Z",
                                                "tBodyGyroJerk_mean_X","tBodyGyroJerk_mean_Y","tBodyGyroJerk_mean_Z","tBodyAccMag_mean","tGravityAccMag_mean","tBodyAccJerkMag_mean",
                                                "tBodyGyroMag_mean","tBodyGyroJerkMag_mean","fBodyAcc_mean_X","fBodyAcc_mean_Y","fBodyAcc_mean_Z","fBodyAccJerk_mean_X",
                                                "fBodyAccJerk_mean_Y","fBodyAccJerk_mean_Z","fBodyGyro_mean_X","fBodyGyro_mean_Y","fBodyGyro_mean_Z","fBodyAccMag_mean",
                                                "fBodyBodyAccJerkMag_mean","fBodyBodyGyroMag_mean","fBodyBodyGyroJerkMag_mean","angletBodyAccJerkMeangravityMean",
                                                "angletBodyGyroMeangravityMean","angletBodyGyroJerkMeangravityMean","angleXgravityMean","angleYgravityMean","angleZgravityMean"))
    
    write.table(all_means,file="C:/answersets/analysis_means.txt",row.names = FALSE)

                          
                      
}                  
                      



