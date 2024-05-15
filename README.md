Describing how the code works:

The first step was to create a dataframe with the column names, which I applied to read.table for the "training set" and the "test set".

After that, I joined the two "sets" in the variable "dataset_1" using the "rbind" command, which maintains the order of the lines.

I selected only the mean and standard deviation columns, added the "labels" and "subjects" through "cbind" and "merge", and, after that, I summarized the data
