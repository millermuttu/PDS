%Copyright Pyreos Ltd 2016
%Created by: Jermey Murray
%NOT TO BE DISTRIBUTED
% Versions: 17/5/16 PyreosCreateTransMatrix v1 (original)

%%The following function creates a transferability matrix for Standerdising
%%Pyreos IR spectrometers
%Change window size 'w' (line 20) to optimise the performace of the algorithm
%(use odd number between 3 and 128)
function [TransferabilityMatrix] = PyreosCreateTransMatrix(TrainingSpectraMaster,TrainingSpectraSlave)

if nargin < 2
   error(message('Too Few Inputs (at least 2 sets of spectra required)'));
end

Xtrainm = TrainingSpectraMaster;
Xtrains = TrainingSpectraSlave;
%master = TestMaster;
%slave = TestSlave;
ncomp = 1;
[n,P]=size(Xtrainm);
w=5; %windows size of pds (usually an odd number)
wd2=floor(w/2);

if size(Xtrainm,1)~=size(Xtrains,1) %checks if the same number of samples for training
    disp('Please make sure you use the samples are identical for both master and slave'); return;
end

%% This loop generates the Transferability Matrix
for i=1:P
    pdsindx=max(i-wd2,1):min(i+wd2,P);
    Ri=zeros(size(Xtrains,1),length(pdsindx));
    ri=Ri;
    Ri=Xtrains(:,pdsindx);
    ri=Xtrainm(:,i);
    meanX = mean(Ri,1);
    meanY = mean(ri,1);
    Rio = bsxfun(@minus, Ri, meanX);
    rio = bsxfun(@minus, ri, meanY);
    X0 = Rio;
    Y0=rio;
    [n,dx] = size(X0);
    dy = size(Y0,2);
    outClass = superiorfloat(X0,Y0);
    Xl = zeros(dx,ncomp,outClass);
    Yl = zeros(dy,ncomp,outClass);
    Wei = zeros(dx,ncomp,outClass);
    V = zeros(dx,ncomp);
    Cov = X0'*Y0;
    for pc = 1:ncomp
        [rip,si,ci] = svd(Cov,'econ'); rip = rip(:,1); ci = ci(:,1); si = si(1);
        ti = X0*rip;
        normti = norm(ti); ti = ti ./ normti; 
        Xl(:,pc) = X0'*ti;
        qi = si*ci/normti;
        Yl(:,pc) = qi;
        Wei(:,pc) = rip ./ normti;
        vi = Xl(:,pc);
        for repeat = 1:2
            for j = 1:pc-1
                vj = V(:,j);
                vi = vi - (vj'*vi)*vj;
            end
        end
        vi = vi ./ norm(vi);
        V(:,pc) = vi;
        Cov = Cov - vi*(vi'*Cov);
        Vi = V(:,1:pc);
        Cov = Cov - Vi*(Vi'*Cov);
    end

    beta = Wei*Yl';
    beta = [meanY - meanX*beta; beta];
    bi = beta; 
    re(i)=sqrt(sum_square([ones(size(Ri,1),1),Ri]*bi-ri)/size(Ri,1));
    F(pdsindx,i)=bi(2:end);
    ba(i)=bi(1);
end
    TransferabilityMatrix.ba=ba;
    TransferabilityMatrix.F=F;
end

