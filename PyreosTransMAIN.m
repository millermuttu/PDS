%Copyright Pyreos Ltd 2016
%Created by: Jermey Murray
%NOT TO BE DISTRIBUTED
% Versions: 17/5/16 PyreosTransMAIN v1 (original)

 clear all; close all; clc;

%%Here's a working example of 1) creating a transferability matrix and 2)
%%applying the matrix to generate spectra of slave device

 addpath('C:\Users\mes6kor\Desktop\PDS')
load('X_master.mat');
load('X_slave.mat');
master = X_master; %glucose_spectra_124; % master to test transferability
slave = X_slave; %glucose_spectra_56; % slave to test transferability
% SpectraMaster = glucose_spectra_124([2 15 20],:); %training (master)
% SpectraSlave = glucose_spectra_56([2 15 20],:); %training (slave)
SpectraMaster = master; %FPY_Glc([1 4 7 10],:); %training (master)
SpectraSlave = slave; %MPY_Gluc([1 4 7 10],:); %training (slave)
[TransferabilityMatrix] = PyreosCreateTransMatrix(SpectraMaster,SpectraSlave);

[TransferredSlave] = PyreosSpectraAfterTrans(TransferabilityMatrix,slave);

figure,plot(master','color','red'); 
hold on;
plot(slave','color','blue'); title('Before transferability')

figure,plot(master','color','red'); 
hold on;
plot(TransferredSlave','color','blue'); title('After transferability')