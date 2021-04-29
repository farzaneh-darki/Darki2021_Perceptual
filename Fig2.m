clc;clear;
T=readtable('Tactile_15Subs_3Reps_Cond0p5_1_2_4_6.csv'); %Load data
T.Percept = categorical(T.Percept);
min=4;                %Trials with average percept durations larger than...
max=150;              %150 s or smaller than 4 s were excluded from data.
SIM_mean=[]; AM_mean=[];    % Mean dominance duration for each percept type
SIM_SEM=[]; AM_SEM=[];      % Standard error of the mean dominance duration
P_SIM_mean=[]; P_AM_mean=[];%Proportion of dominance for each percept type
P_SIM_SEM=[]; P_AM_SEM=[];  %Standard error of the mean for proportion 
F_mean=[]; F_SEM=[];        %Freq of alternations at different dB levels
dB=[0.5 1 2 4 6];           % Levels of intensity difference in dB scale
for i=1:length(dB)
%% Mean
    SIM = T.Mean(T.Percept=={'SIM'} & T.dB==dB(i));
    bad = max<SIM  | SIM<min ;
    SIM(bad) = NaN;
    SIM_mean=[SIM_mean;nanmean(SIM)];
    SIM_SEM=[SIM_SEM;nanstd(SIM)/sqrt(length(find(~isnan(SIM))))];
    %%%%%%
    AM = T.Mean(T.Percept=={'AM'} & T.dB==dB(i));
    bad = max<AM  | AM<min ;
    AM(bad) = NaN;
    AM_mean=[AM_mean;nanmean(AM)];
    AM_SEM=[AM_SEM;nanstd(AM)/sqrt(length(find(~isnan(AM))))];
%% Proportion
    P_SIM = SIM./(SIM+AM);
    P_SIM_mean=[P_SIM_mean;nanmean(P_SIM)];
    P_SIM_SEM =[P_SIM_SEM;nanstd(P_SIM)/sqrt(length(find(~isnan(P_SIM))))];
    %%%%%%
    P_AM  = AM ./(SIM+AM);
    P_AM_mean=[P_AM_mean;nanmean(P_AM)];
    P_AM_SEM =[P_AM_SEM ;nanstd(P_AM)/sqrt(length(find(~isnan(P_AM))))];
%% Frequency
    F = 2./(SIM+AM);
    F_mean=[F_mean;nanmean(F)];
    F_SEM =[F_SEM ;nanstd(F)/sqrt(length(find(~isnan(F))))];
end
%% Plot
% Mean
figure()
subplot(311)
errorbar(dB,SIM_mean,SIM_SEM); hold on
errorbar(dB,AM_mean,AM_SEM);
ylabel('Mean [sec]')
set(gca,'ylim',[0,75]);
set(gca,'ytick',[0 25 50 75]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Proportion
subplot(312)
errorbar(dB,P_SIM_mean,P_SIM_SEM); hold on
errorbar(dB,P_AM_mean ,P_AM_SEM );
ylabel('Proportion')
set(gca,'ylim',[0,1]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Frequency
subplot(313)
errorbar(dB, F_mean, F_SEM);
ylabel('Frequency [Hz]')
xlabel('Intensity difference [dB]')
set(gca,'ylim',[0,0.075]);
set(gca,'ytick',[0 0.025 0.05 0.075]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(findall(gcf,'-property','xtick'),'xtick',[0.5 1 2 4 6]);
set(findall(gcf,'-property','xlim'),'xlim',[0,dB(end)+0.5]);
set(findall(gcf,'-property','Fontname'),'Fontname','helvetica');
set(findall(gcf,'-property','FontSize'),'FontSize',10)
set(findall(gcf,'-property','LineWidth'),'LineWidth',1.0)
set(gcf,'units','centimeters','position',[0 0 20 15])