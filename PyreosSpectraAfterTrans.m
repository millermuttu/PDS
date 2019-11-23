%Copyright Pyreos Ltd 2016
%Created by: Jermey Murray
%NOT TO BE DISTRIBUTED
% Versions: 17/5/16 PyreosSpectraAfterTrans v1 (original)
function [TransferredSlave] = PyreosSpectraAfterTrans(TransferabilityMatrix,SlaveSpectra)

    slave=SlaveSpectra;
    
%%This applies the Transferability matrix to 'slave' spectra
    c1=1;cv=1;c0=0;
    cv = times(cv,c0); 
    cv = plus(cv,c1); 
    stdvect = TransferabilityMatrix.ba;
    stdvect = mtimes(cv,stdvect); 
    slave = mtimes(slave,TransferabilityMatrix.F);
    temp = repmat(stdvect,size(slave,1),1);
    slave = plus(slave,temp);
    TransferredSlave = slave;
end