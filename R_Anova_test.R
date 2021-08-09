library(ggplot2)
library(ggpubr)
library(tidyverse)
library(broom)
library(AICcmodavg)

# 单向方差分析
one.way <- aov(yield ~ fertilizer, data = crop.data)

summary(one.way)


# 双向方差分析
two.way <- aov(yield ~ fertilizer + density, data = crop.data)

summary(two.way)

# 添加变量之间的交互
interaction <- aov(yield ~ fertilizer*density, data = crop.data)

summary(interaction)


# 第 3 步：找到最合适的模型
library(AICcmodavg)

model.set <- list(one.way, two.way, interaction, blocking)
model.names <- c("one.way", "two.way", "interaction", "blocking")

aictab(model.set, modnames = model.names)





# 第 5 步：进行事后测试

tukey.two.way<-TukeyHSD(two.way)

tukey.two.way