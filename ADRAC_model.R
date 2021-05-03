Sys.setenv(LANGUAGE="en")#显示英文报错信息
options(stringsAsFactors=F)#禁止将chr转换成factor，针对列表
options(scipen=100)#数字在100位以内不使用科学计数法表示
options(prompt="R>")#执行符号由“>”变成“R>”
options(warning=-1)#不提示提示信息

library(nlstools)
# 无该包时，install.packages("nlstools")
library(nlsMicrobio)
library(investr)

data <- read.csv("ADRAC_scaler.csv")
names(data) <- c("Altitude","time_pre","exercise_level","time_exposure","risk")

# a b c d 分别为βt中各参数，其中b对应Altitude 不是pressure
# Altitude归一化方法： Altitude_new = Altitude / 40000
# time_pre,time_exposure归一化 t_new = t / 240
# exercise_level  heavy = 3 / 3; mild = 2 / 3; rest = 1 / 3;
gamma1 = 5/3

#模型初始化
a0 = 1
b0 = 0
c0 = 0
d0 = 0
test_formula <- nls(risk ~ (exp(a + b * Altitude + c * time_pre / time_exposure + d * exercise_level)) * gamma1 * ((exp(a + b * Altitude + c * time_pre / time_exposure + d * exercise_level)) * time_exposure)**(gamma1 - 1) / (1 + ((exp(a + b * Altitude + c * time_pre / time_exposure + d * exercise_level)) * time_exposure)**gamma1), start=list(a = a0,b = b0, c = c0, d = d0),data = data)

# 输出了模型参数 显著性水平等
summary(test_formula)
c<-coef(test_formula)

# 将参数代入模型 
a = -2.907692
b = 2.660404 
c = -0.234712 
d = 0.713871

#测试
gamma1 = 5 / 3
Altitude = 30000 / 40000
time_pre = 240 / 240
time_exposure = 240 / 240
exercise_level = 2/3
result = exp(a + b * Altitude + c * time_pre / time_exposure + d * exercise_level) * gamma1 * ((exp(a + b * Altitude + c * time_pre / time_exposure + d * exercise_level)) * time_exposure)**(gamma1 - 1) / (1 + ((exp(a + b * Altitude + c * time_pre / time_exposure + d * exercise_level)) * time_exposure)**gamma1)



