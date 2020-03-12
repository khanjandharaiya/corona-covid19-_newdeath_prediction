library(dplyr)
corona_data= read.csv(choose.files(),header = T)
View(corona_data)

mean(is.na(corona_data))

corona_data= na.omit(corona_data)
View(corona_data)
mean(is.na(corona_data))

summary(corona_data)
corona_data= select(corona_data, -date)
View(corona_data)

library(FSelector)

#new Deaths prediction
gain_ratio<- gain.ratio(new_deaths~.,corona_data)
View(gain_ratio)

gain_ratio<- subset(gain_ratio,attr_importance>0.40)
View(gain_ratio)

r_name<- row.names(gain_ratio)
r_name

formula<- as.formula(paste('new_deaths~',paste(r_name,collapse = "+")))

l_model<- lm(formula,corona_data)
summary(l_model)

test_data<- read.csv(choose.files(),header = T)
View(test_data)
pre_result<- predict(l_model,test_data)
View(pre_result)

test_data$predicted<- predict(l_model,test_data)
View(test_data)
