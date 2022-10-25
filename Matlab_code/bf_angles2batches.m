
clc;
clear all;
close all;
folder_name = '/home/foysal/Dropbox/Research/MU-MIMO/Activity_Recognition/Data/FeedBack/preli_test_1_test/processed_dataset/89/beamf_angles/standing/'
folder_save ='/home/foysal/Dropbox/Research/MU-MIMO/Activity_Recognition/Data/FeedBack/preli_test_1_test/processed_dataset/89/beamf_angles/standing_batch/'
% activity=['W' ; 'S' ; 'C' ; 'L' ; 'R' ; 'T'];


% for m = 1:length(activity)
%      folder_name = sprintf('/home/foysal/Dropbox/Research/MU-MIMO/Activity_Recognition/Data/FeedBack/preli_test_1/processed_dataset/89/beamf_angles/%s/',activity(m));
%      folder_save = sprintf('/home/foysal/Dropbox/Research/MU-MIMO/Activity_Recognition/Data/FeedBack/preli_test_1/processed_dataset/89/beamf_angles/%s_batch/',activity(m));
     
files = dir(fullfile(folder_name, '*.mat'));

    for file_idx = 1:numel(files)
        FILE = strcat(folder_name, files(file_idx).name); % capture file
    end
load(FILE);

discard=1;

num_p= size(beamf_angles,2)
            window=100;
            num_image = floor(num_p/window);
            % process data window by window
            for i = discard:num_image-discard
                bf_angles = [];
                bf_angles = [bf_angles; beamf_angles(:,(i-1)*window+1:i*window)];
                bf_matrix = [];
                
                % convert the cells to 3d matrix
                for j = 1:length(bf_angles)
                    bf_matrix = cat(1,bf_matrix,reshape(cell2mat(bf_angles(j)),1,234,4));
                end
% 
%                 % take the avg of the windowsize (PCA start here)
%                 bf_matrix_avg = mean(abs(bf_matrix), 2);
%                 B = bf_matrix - pagemtimes(bf_matrix_avg,ones(1,234,4));
%                 
%                 % create zero matrix for storing the matrix 234x234x4 (after PCA)
%                 cfm_amp = zeros(size(B,2),size(B,2),size(B,3));
%                 % convert to 2d matrix for PCA, keep the angles independent
%                 for k = 1:size(bf_matrix,3)
%                     cp_amp = abs(bf_matrix(:,:,k))'*pca(abs(B(:,:,k))'/sqrt(window));
%                     cfm_amp(:,:,k) = cp_amp*cp_amp';
%                     cfm_data = squeeze(cfm_amp); 
%                     
%                 end
                mat_name = strcat(folder_save, 'batch','_',string(i),'.mat');
                save(mat_name, 'bf_matrix');
            end
            
            
% end