Durations=read.table('Tactile_15Subs_3Reps_Cond0p5_1_2_4_6.csv',sep=',',header=T)
####################################################################
SIM=subset(Durations,Percept=='SIM')
AM=subset(Durations,Percept=='AM ')

par( mfrow = c(2,2) )
#Fig2a
plot(Mean~dB,data=SIM,col="blue",ylim = c(0, 180))
plot(Mean~dB,data=AM,col="red",ylim = c(0, 180))

####################################################################
Durations_discarded=subset(Durations, 4<Mean & Mean<150)
SIM=subset(Durations_discarded,Percept=='SIM')
AM=subset(Durations_discarded,Percept=='AM ')

plot(Mean~dB,data=SIM,col="blue",ylim = c(0, 180))
plot(Mean~dB,data=AM,col="red",ylim = c(0, 180))