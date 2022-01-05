%
% NOTE:    (a)Calls the four wind asset, from a day and for that assets
%          calculates distribution of generation cost, load shedding and renewable curtailment
%          (b) Identify the extreme scenarios (those that yield the 5% highest cost)
%           (c) shows distribution of all scenrios at hours=6, 12, 18, 24
% HIST:  - 4 Jan, 2022: Created by Patra
%=========================================================================
tic
clc;close all; clear all;
%GenerationCost = readtable('ORFEUSRTS/type-pwrset-jan20-20211229T210546Z-001/type-pwrset-jan20/GenerationCostJanuary20.csv'); 
GenIdx=RTSDailySummary;
RTSSolarSimulation
Time=1:1:24;%Time steps
%Array = readtable('Scovilleriskpartners/LiveSimulation/SimRequest_Mahashweta_20211227_143545/wind/Aguayo_Wind.csv'); 
files = dir('ORFEUSRTS/type-pwrset-jan20-20211229T210546Z-001/type-pwrset-jan20/WindScenarios*.csv'); 
for i=1:4
    filename=files(i).name;
    Array = readtable(strcat('ORFEUSRTS/type-pwrset-jan20-20211229T210546Z-001/type-pwrset-jan20/',filename)); 
    SizeScenario=size(Array);
    b_array=zeros(1001,24);
    for k=2:SizeScenario(1)
        b=zeros(24,1);
        col = Array(k,:);
        hold on; 
        for i=1:24% put the asset in a array
            j=i+1;
            b(i)=col{1,j};
            b_array(k,i)=b(i);
        end
    end
    %% plots the scenarios
    figure();
    %subplot(2,4,i)
    plot(Time,b_array(GenIdx,:),'Color', [0.7 0.7 0.7],'markersize',5) %plot the mean of all scenarios
    set(gca, 'GridLineStyle', ':') %dotted grid lines
    set(gca,'FontSize',18,'LineWidth',1.5)

    figure()%%plots the histogram at some hour
    subplot(1,4,1)
    histogram(b_array(2:1001,6),10)
    set(gca, 'GridLineStyle', ':') %dotted grid lines
    set(gca,'FontSize',12,'LineWidth',1.0)
    subplot(1,4,2)
    histogram(b_array(2:1001,12),10)
    set(gca, 'GridLineStyle', ':') %dotted grid lines
    set(gca,'FontSize',12,'LineWidth',1.0)
    subplot(1,4,3)
    histogram(b_array(2:1001,18),10)
    set(gca, 'GridLineStyle', ':') %dotted grid lines
    set(gca,'FontSize',12,'LineWidth',1.0)
    subplot(1,4,4)
    histogram(b_array(2:1001,24),10)
    set(gca, 'GridLineStyle', ':') %dotted grid lines
    set(gca,'FontSize',12,'LineWidth',1.0)
end
toc