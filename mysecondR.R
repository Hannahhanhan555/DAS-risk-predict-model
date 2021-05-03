setwd("E:/rpractice")
library(tidyverse)
bj<-read.csv("house_infbj.csv")
newbj <- bj[, c(2:6)]
head(newbj)
sh<-read.csv("house_infsh.csv")
newsh <- sh[, c(2:6)]
head(sh)
sz<-read.csv("house_infsz.csv")
newsz <- sz[, c(2:6)]

newbj$city<-"北京"
newsh$city<-"上海"
newsz$city<-"深圳"
house_all<-rbind(newsh,newbj,newsz)
head(house_all)
#house_all$house_basic_inf<-as.character(house_all$house_basic_inf)
#name<- strsplit((house_all$house_basic_inf), split="\\|")
#小区名称 <- sapply(name, "[", 1)
#户型<- sapply(name, "[", 2)
#面积 <- sapply(name, "[", 3)
#朝向<- sapply(name, "[", 4)
#是否精装 <- sapply(name, "[", 5)
#有无电梯<- sapply(name, "[", 6)
#house_all<- cbind(小区名称,户型,面积，朝向，是否精装，有无电梯， house_all[,-2])
#

house_all<-separate(data = house_all, col ="house_basic_inf", into = c("v1","v2","v3","v4","v5","v6","v7"), sep = "\\|") #分解”基础信息“列
head(house_all)

length(house_all$v1)
n<-length(house_all$v1)
c<-c("独栋别墅","联排别墅","双排别墅","叠拼别墅","双拼别墅")
for(i in 1:n) if(house_all$v2[i] %in% c) {house_all$v2[i]<-house_all$v3[i] 
house_all$v3[i]<-house_all$v4[i]
house_all$v4[i]<-house_all$v5[i]
house_all$v5[i]<-house_all$v6[i]
house_all$v6[i]<-house_all$v7[i]
house_all$v7[i]<-""
}
write.csv(house_all,file="house_all.csv"）

house_all<-subset()
house_all<-house_all[-8] #剔除无用列

head(house_all)

house_all$house_unitprice<-sub("元/平米","",sub("单价","",house_all$house_unitprice))

house_all$house_totalprice<-sub("万","",house_all$house_totalprice) #单价数值化
house_all<-house_all[-2] 
names(house_all)<-c("小区名称","户型","面积","朝向","是否精装","有无电梯","小区地址","房屋总价","房屋单价","所在地")#重命名列名
head(house_all)
write.csv(house_all,file = "house_all2.csv")

house_all<-read.csv("house_all2.csv",stringsAsFactors = FALSE)  
house_all<-house_all[-1]  
house_all$面积<-sub("平米","",house_all$面积) #将面积数值化
house_all$面积<-as.numeric(house_all$面积)
fz<-house_all[house_all$所在地=="上海",]
head(fz)
write.csv(fz,file = "house_all3.csv")

summary(fz$面积)
myprice<-c("面积","房屋总价","房屋单价")
summary(fz[myprice])

summary(fz$是否精装)

hist(fz$房屋总价,
     col = "grey",
     breaks = 100*seq(0,65),
     )
axis(side = 1,at=c(seq(0,6500,by=100)))

hist(fz$房屋单价/10000,
     col = "blue",
     breaks = seq(0,19),
     xlab = "单价/万元"
)
axis(side = 1,at=c(seq(0,19)))
#房屋单价直方图-------------------------------------------------------------作业2、直方图

boxplot(fz$房屋总价~fz$是否精装,data=fz) #箱线图，类别型变量分布关系--------作业3、箱线图
boxplot(fz$房屋单价~fz$是否精装,data=fz) #箱线图，类别型变量分布关系--------作业3、箱线图

house_all<-read.csv("house_all2.csv",stringsAsFactors = FALSE)  
house_all<-house_all[-1] f 
house_all$面积<-sub("平米","",house_all$面积) #将面积数值化
house_all$面积<-as.numeric(house_all$面积)
fz<-house_all[house_all$所在地=="深圳",]
head(fz)
summary(fz$面积)
myprice<-c("面积","房屋总价","房屋单价")
summary(fz[myprice])

hist(fz$房屋总价,
     col = "grey",
     breaks = 100*seq(0,53),
     )
axis(side = 1,at=c(seq(0,5300,by=100)))

hist(fz$房屋单价/10000,
     col = "blue",
     breaks = seq(0,15),
     xlab = "单价/万元"
)
axis(side = 1,at=c(seq(0,15)))
#房屋单价直方图-------------------------------------------------------------作业2、直方图

boxplot(fz$房屋总价~fz$是否精装,data=fz) #箱线图，类别型变量分布关系--------作业3、箱线图
boxplot(fz$房屋单价~fz$是否精装,data=fz) #箱线图，类别型变量分布关系--------作业3、箱线图
