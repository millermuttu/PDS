clear all; close all

source_dir = 'Z:\24_Measurements_data\01_DataCollection_NDRI\T004\UA\Packet\20180309';
source_files_1 = dir(fullfile(source_dir, '*.txt'));
dest_dir = source_dir;
for i = 1:length(source_files_1)
    
file = textread(fullfile(source_dir,source_files_1(i).name), '%s', 'delimiter', '\n', ...
                'whitespace', '');
ind=find(ismember(file,'#Active Pixels:'));     
count=1;
for index=ind+1:ind+129
    if count <=99
        pixel_num(count,i)=str2num(file{index}(1:2));
        data_intensity(count,i)=str2num(file{index}(3:end));
    else
        pixel_num(count,i)=str2num(file{index}(1:4));
        data_intensity(count,i)=str2num(file{index}(5:end));
    end
    count=count+1;
end
end
load('WL_Beta.mat')
name=char(source_files_1.name);
data_intensity=data_intensity';
save(strcat(dest_dir,'\Beta_BB_LOD.mat'),'data_intensity','name','WL_Beta');
