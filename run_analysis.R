

# Realizando a primeira etapa:
# 1 - Merges the training and the test sets to create one data set.


# Criando vetor com o nome das colunas
columns <- read.table("UCI HAR Dataset/features.txt",
                      colClasses = c("NULL", "character"),
                      col.names = c("NULL", "features"))

training_set <- read.table("UCI HAR Dataset/train/X_train.txt",
                           col.names = columns$features)

test_set <- read.table("UCI HAR Dataset/test/X_test.txt",
                       col.names = columns$features)

dataset_1 <- rbind(training_set, test_set)


# 2 - Extracts only the measurements on the mean and standard deviation 
#     for each measurement. 

# Selecionando apenas as colunas que contém as palavras "mean" ou "std"
dataset_2 <- dataset_1[, grepl("mean", names(dataset_1)) |
                                 grepl("std", names(dataset_1))   
]


# 3 - Uses descriptive activity names to name the activities in the data set

# Criando a tabela com o id e a descrição da atividade
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt",
                       col.names = c("id_activity", "activity_labels"))

# Tabela de labels do set "train"
train_labels <- read.table("UCI HAR Dataset/train/y_train.txt", 
                              col.names = "id_activity")

# Tabela de labels do set "test"
test_labels <- read.table("UCI HAR Dataset/test/y_test.txt",
                          col.names = "id_activity")

# Tabela de subjects do set "train"
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt",
                            col.names = "subject")

# Tabela de subjects do set "test"
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt",
                           col.names = "subject")

#Criando vetor com todos os labels, em ordem
dataset_labels <- rbind(train_labels, test_labels)

#Criando vetor com todos os subjects, em ordem
dataset_subject <- rbind(train_subject, test_subject)

# Criando o dataset3, que cruza com a tabela de id da atividade
# e adiciona as colunas de label e subject no dataset final
dataset_3 <- merge(activity_labels, cbind(dataset_labels, 
                                          dataset_subject,
                                          dataset_2))

# 4 - Appropriately labels the data set with descriptive variable names

# Already done


# 5 - From the data set in step 4, creates a second, independent tidy data 
#     set with the average of each variable for each activity and each subject.

library(dplyr)

# Calculando a média, agrupando por label e subject
dataset_4 <- dataset_3 %>%
        group_by(activity_labels, subject) %>%
        summarise_all("mean")

write.table(dataset_4, file = "dataset_final.txt", row.name = FALSE)


