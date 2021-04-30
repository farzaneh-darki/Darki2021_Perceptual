library(car)
library(ez)
library(apaTables)
library(effectsize)
Durations=read.table('Tactile_6Subs_6Reps_Cond_2_4_6.csv',sep=',',header=T)
###########################################################################
SIM=subset(Durations,Percept=='SIM')
AM=subset(Durations,Percept=='AM ')

SIMdb2=subset(SIM,Cond=='db002')
SIMdb4=subset(SIM,Cond=='db004')
SIMdb6=subset(SIM,Cond=='db006')

AMdb2=subset(AM,Cond=='db002')
AMdb4=subset(AM,Cond=='db004')
AMdb6=subset(AM,Cond=='db006')

SIM=rbind(SIMdb2,SIMdb4,SIMdb6)
AM =rbind( AMdb2, AMdb4, AMdb6)
Durations=rbind(AM,SIM)
trialnum=numeric(nrow(Durations_discarded))
for (i in 1:6) {
  trialnum[(36*i-35):(36*i)]=seq(1,36,by=1)
}
Durations$trialnum=trialnum
######################
# Method 1
ezDesign(data=Durations, y=trialnum, x=Cond, col=Percept)
res=ezANOVA(data=Durations, dv=Mdur, wid=trialnum, within=.(Cond,Percept), type=3,detailed=TRUE)
table = apa.ezANOVA.table(res,correction="auto")
print(table)

# Method 2
C = factor(Durations$Cond)
P = factor(Durations$Percept)
model = aov(Mdur ~ C * P, data = Durations)
eta_squared(model)
cohens_f(model)
