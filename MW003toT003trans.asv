close all;
% addpath('Z:\24_Measurements_data\Calibration_data\Pyreos_beta\Mimosa calibration\IPA Absorbance\PDS\Data')
load('masterUA.mat');
load('Trans_T003_MW001_UA.mat');
load('T003_AS_OLd.mat')
master=T003_AS_OLd;
slave = MW_ASnew;
[TransferredSlave] = PyreosSpectraAfterTrans(TransferabilityMatrix,slave);

 figure,plot(master','color','red'); 
 hold on;
 plot(slave','color','blue'); title('Before transferability')

figure,plot(master','color','red'); 
hold on;
plot(TransferredSlave','color','blue'); title('After transferability')
