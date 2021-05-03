# 首先对数据进行归一化
# Altitude归一化方法： Altitude_new = Altitude / 40000 （高度最大值为40000）
# time_pre,time_exposure归一化 t_new = t / 240 （时间最大值为240）
# exercise_level  heavy = 3 / 3; mild = 2 / 3; rest = 1 / 3;

#模型参数
a = -2.907692 
b = -2.660404
c = 0.234712
d =  0.713871

#测试 python版（以文章中第一组数据为例）
#gamma1为固定值 非参数
gamma1 = 5 / 3 

time_exposure = 180 / 240
Altitude = 35000 / 40000
time_pre = 75 / 240
exercise_level = 3 / 3
result = np.exp(a - b * Altitude - c * time_pre / time_exposure + d * exercise_level) * gamma1 * math.pow((np.exp(a - b * Altitude - c * time_pre / time_exposure + d * exercise_level)) * time_exposure,(gamma1 - 1)) / (1 + math.pow((np.exp(a - b * Altitude - c * time_pre / time_exposure + d * exercise_level)) * time_exposure,gamma1))

#测试 R版（以文章中第四组数据为例）
gamma1 = 5 / 3 
Altitude = 30000 / 40000
time_pre = 240 / 240
time_exposure = 240 / 240
exercise_level = 2/3
result = exp(a + b * Altitude + c * time_pre / time_exposure + d * exercise_level) * gamma1 * ((exp(a + b * Altitude + c * time_pre / time_exposure + d * exercise_level)) * time_exposure)**(gamma1 - 1) / (1 + ((exp(a + b * Altitude + c * time_pre / time_exposure + d * exercise_level)) * time_exposure)**gamma1)
