%% reading data
addpath('C:\Work_Directory\01_Priya\00_SVN_Source\Swilch\Development\Algorithm\Algo1-Adulteration-MIL\Data\MPY_D01_Train_data\UA')
load('MPY_M6_Unadulterated.mat');
slave=MPY_M6_Unadulterated(:,4:end);
%% Reading model
addpath('C:\Work_Directory\01_Priya\01_Work\01_Projects\01_Diary\01_Codes\02_Transferability\Transferability_Sucrose')
load('TransferabilityMatrix_Sucrose.mat');

%% Transfering
[Trans_Slave] = PyreosSpectraAfterTrans(TransferabilityMatrix,slave);
Trans_MPY_M6_Unadulterated=MPY_M6_Unadulterated;
Trans_MPY_M6_Unadulterated(:,4:end)=Trans_Slave;
dir='C:\Work_Directory\01_Priya\00_SVN_Source\Swilch\Development\Algorithm\Algo1-Adulteration-MIL\Data\MPY_D01_Train_data\Sucrose';
save('Trans_MPY_M6_Unadulterated');

%% Plotting response
addpath('C:\Work_Directory\01_Priya\00_SVN_Source\Swilch\Development\Algorithm\Algo1-Adulteration-MIL\Data\FPY_D54_Train_data\Sucrose')
load('FPY_M05_Adulterated.mat');
Master=FPY_M05_Adulterated(:,4:end);

figure,subplot (211),plot(Master','b');
hold on, plot(slave','r');
title('Sucrose M05P: D54-Blue, D01-Red: Before Transferability')

subplot(212),plot(Master','b');
hold on, plot(Trans_Slave','r');
title('Sucrose M05P: D54-Blue, D01-Red: After Transferability')
