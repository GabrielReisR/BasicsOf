sex <- c(rep(0,10),rep(1,10))
sex <- factor (sex, levels = c(0,1), labels = c("Male", "Female"))
sex
reinforcement <- c(rep(0,5), rep(1,5), rep(0,5), rep(1,5))
reinforcement
reinforcement <- factor(reinforcement, levels = c(0,1), labels = c("Shock", "Nice"))
scores <- c(15,14,20,13,13,10,9,8,8,7,6,7,5,4,8,12,10,7,8,13)
scores
?data.frame()
reinforcementData <- data.frame(sex = sex, reinforcement = reinforcement, scores = scores)
reinforcementData


gender<-c(rep(0,12), rep(1,12))
gender<-factor(gender, levels = (0:1), labels = c("Male", "Female"))
gender

ownFace <- c(33,26,10,51,34,28,27,9,33,11,14,46,97,80,88,100,100,58,95,83,97,89,69,82)
partnerFace <- c(69,76,70,76,72,65,82,71,71,75,52,34,70,74,64,43,51,93,48,51,74,73,41,84)
totalShots <- ownFace + partnerFace
infidelityData <- data.frame(gender, ownFace, partnerFace, totalShots)
infidelityData

