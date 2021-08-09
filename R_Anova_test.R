library(ggplot2)
library(ggpubr)
library(tidyverse)
library(broom)
library(AICcmodavg)

# ���򷽲����
one.way <- aov(yield ~ fertilizer, data = crop.data)

summary(one.way)


# ˫�򷽲����
two.way <- aov(yield ~ fertilizer + density, data = crop.data)

summary(two.way)

# ���ӱ���֮��Ľ���
interaction <- aov(yield ~ fertilizer*density, data = crop.data)

summary(interaction)


# �� 3 �����ҵ�����ʵ�ģ��
library(AICcmodavg)

model.set <- list(one.way, two.way, interaction, blocking)
model.names <- c("one.way", "two.way", "interaction", "blocking")

aictab(model.set, modnames = model.names)





# �� 5 ���������º����

tukey.two.way<-TukeyHSD(two.way)

tukey.two.way