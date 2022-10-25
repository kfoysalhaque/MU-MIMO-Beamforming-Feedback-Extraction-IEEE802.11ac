
clc;
clear all;
close all;
% folder_name = '/home/foysal/Dropbox/Research/MU-MIMO/Activity_Recognition/Data/FeedBack/preli_test_1_test/processed_dataset/89/beamf_angles/standing/'
% folder_save ='/home/foysal/Dropbox/Research/MU-MIMO/Activity_Recognition/Data/FeedBack/preli_test_1_test/processed_dataset/89/beamf_angles/standing_batch/'

activity= ["A", "B", "C", "D","E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P","Q", "R", "S", "T", "U" ];

Test= 'Kitchen_All';
station= '89'; 
window_size=15;
interval = 0.1;
%
% to load mat file
for m = 1:length(activity)
     folder_name = sprintf('../Data/%s/processed_dataset/%s/beamf_angles/%s/',Test, station, activity(m));
     folder_save = sprintf('../Data/%s/processed_dataset/%s/beamf_angles/%s_batch/',Test, station, activity(m));
     
files = dir(fullfile(folder_name, '*.mat'));

    for file_idx = 1:numel(files)
        FILE = strcat(folder_name, files(file_idx).name); % capture file
        person_name = files(file_idx).name(end-25:end-21);
        disp(person_name)
        %disp(FILE)
        csv_name= strcat(folder_name,files(file_idx).name(end-25:end-4),'_', station, '.csv');
    
        load(FILE);
%
        % to read batch of packet according to csv
        dim = size(cell2mat(beamf_angles(1)),1);
        ch = size(cell2mat(beamf_angles(1)),2);
        zero_pkt = zeros(1,dim,ch); % use for padding
        
        sheet = readtable(csv_name);
        % sheet: num - time
        
        
        count = 1; % number of time interval
        %windowsize = 10;
        
        
 
        i = 1;
        while count*interval<=300
            
            bf_matrix = [];
            try
                while sheet.Time(i)-interval*(count-1) < interval
                    bf_matrix = [bf_matrix;reshape(cell2mat(beamf_angles(i)),1,dim,ch)];
                    disp(i)
                    i = i+1;
                end
            catch
                bf_matrix = [];
            end
            
            
            
            bf_size = size(bf_matrix);
            if bf_size(1) < window_size
                for j = 1:(window_size-bf_size(1))
                    bf_matrix = [bf_matrix;zero_pkt];
                end
            else
                bf_matrix = bf_matrix(1:window_size,:,:);
            end
            mat_name = strcat(folder_save, person_name, 'batch','_',string(count),'.mat');
            save(mat_name, 'bf_matrix');
            count = count+1;
            
        end
        %%
%         for i = 1:height(sheet)
%             if sheet.Time(i) > interval*count && sheet.Time(i) < interval*(count+1)
%                 idx_e = sheet.No_(i-1);
%                 % to do processing
%                 bf_matrix=[];
%                 for j = 1:window_size
%                     if j <= idx_e-idx_i+1
%                         bf_matrix = [bf_matrix;reshape(cell2mat(beamf_angles(idx_i+j-1)),1,dim,ch)];
%                     else
%                         bf_matrix = [bf_matrix; zero_pkt];
%                     end
%                 end
%                 mat_name = strcat(folder_save, person_name, 'batch','_',string(count),'.mat');
%                 save(mat_name, 'bf_matrix');
%                 % initialize a new time interval
%                 idx_i = sheet.No_(i);
%                 count = count + 1;
%                 i = i+1;
%             elseif sheet.Time(i) > interval*(count+1)
%                     %todo
%                 end
%             if count*interval>300
%                 break
%             end
%         end

    end
end
