library("rvest")
library("xml2")
library("dplyr")
library("stringr")
i<-1:100
house_inf<-data.frame()

for (i in 1:100){
web<- read_html(str_c("http://sh.lianjia.com/ershoufang/pg",i),encoding="UTF-8")
house_name<-web%>%html_nodes(".houseInfo a")%>%html_text()
house_basic_inf<-web%>%html_nodes(".houseInfo")%>%html_text()
house_address<-web%>%html_nodes(".positionInfo a")%>%html_text()
house_totalprice<-web%>%html_nodes(".totalPrice")%>%html_text()
house_unitprice<-web%>%html_nodes(".unitPrice span")%>%html_text()
house<-data_frame(house_name,house_basic_inf,house_address,house_totalprice,house_unitprice)
house_inf<-rbind(house_inf,house)
}

write.csv(house_inf,file="E:/house_infsh.csv")

