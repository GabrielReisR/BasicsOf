name<-c("Ben", "Martin", "Andy", "Paul", "Graham", "Carina", "Karina", "Doug", "Mark", "Zoë")
name
birthDate<-as.Date(c("1977-07-03", "1969-05-24", "1973-06-21", "1970-07-16",                    "1949-10-10", "1983-11-05", "1987-10-08", "1989-09-16", "1973-05-20", "1984-11-12"))
birthDate
job<-c(1,1,1,1,1,2,2,2,2,2)
job
job<-factor(job, levels = c(1,2), labels = c("Lecturer", "Student"))
job
friends<-c(5,2,0,4,1,10,12,15,12,17)
friends
alcohol<-c(10,15,20,5,30,25,20,16,17,18)
alcohol
income<-c(20000,40000,35000,22000,50000,5000,100,3000,10000,10)
income
neurotic<-c(10,17,NA,13,21,7,13,9,14,NA)
neurotic
lecturerData<-data.frame(name, birthDate, job, friends, alcohol, income, neurotic)
lecturerData
names(lecturerData)<-c("Name", "Birth Date", "Job", "Friends", "Alcohol", "Income", "Neurotic")
lecturerData
install.packages("Rcmdr", dependencies = TRUE)
library("Rcmdr")
getwd()
setwd("C:\\Users\\Gabriel\\Documents\\Mestrado\\Estatística\\Estudo")
getwd()
