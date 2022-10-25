%% csi_read_beamforming_matrix.m
%
% read compressed beamforming matrix
%
% Copyright (C) 2022 Francesca Meneghello
% contact: meneghello@dei.unipd.it
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <https://www.gnu.org/licenses/>.
clc
clear all

%%Extraction Configuration 

Test = 'Kitchen_All';
station= '25';
n = 10000000;   %%max num of UDPs

activities =['A_01', 'A_02', 'A_03', 'A_04','A_05', 'A_06', 'A_07', 'A_08', 'A_09', 'A_10', 'A_11', 'A_12', 'A_13', 'A_14', 'A_15', 'A_16','A_17', 'A_18', 'A_19', 'A_20', 'A_21' ];


%% configuration
user_names = ['25', '9C', '89'];
mobility = false;
name_suffix_offset = 10;

if mobility
    Nc_users = [1, 1]; % number of spatial streams
    phi_numbers = [2, 3];
    psi_numbers = [2, 3];
    skip_start_users = [275, 273];
    skip_start_sample_users = [33, 35];
    folder_proc = 'processed_dataset_mobility';
    folders_name = ['../input_files/dataset_mobility/split/'];
else
    Nc_users = [1, 1, 1]; % number of spatial streams
    phi_numbers = [2, 2, 2];
    psi_numbers = [2, 2, 2];
    skip_start_users = [255, 255, 255];
    skip_start_sample_users = [33, 33, 33];
    folder_proc = 'processed_dataset';
    folders_name = strcat('../Data/',Test, '/processed_dataset/', station, '/', 'FeedBack_Pcap/');
end
    
Nr = 3;  % number of Tx antennas
psi_bit = 7;
phi_bit = psi_bit + 2;
order_angles = ['phi_11', 'phi_21', 'psi_21', 'psi_31', 'phi_22', 'psi_32'];
order_bits = [phi_bit, phi_bit, psi_bit, psi_bit, phi_bit, psi_bit];

tot_angles_users = phi_numbers + psi_numbers;
tot_bits_users = phi_numbers*phi_bit + psi_numbers*psi_bit;
tot_bytes_users = ceil(tot_bits_users/8); 

BW = 80;                 
NSUBC = 256;
subcarrier_idxs = linspace(1, NSUBC, NSUBC) - NSUBC/2 - 1;
pilot_subcarriers = [25, 53, 89, 117, 139, 167, 203, 231];
num_pilots = numel(pilot_subcarriers);
subcarrier_idxs(252:end) = [];
subcarrier_idxs(231) = [];
subcarrier_idxs(203) = [];
subcarrier_idxs(167) = [];
subcarrier_idxs(139) = [];
subcarrier_idxs(128:130) = [];
subcarrier_idxs(117) = [];
subcarrier_idxs(89) = [];
subcarrier_idxs(53) = [];
subcarrier_idxs(25) = [];
subcarrier_idxs(1:6) = [];
NSUBC_VALID = numel(subcarrier_idxs);
length_angles_users = NSUBC_VALID*tot_bytes_users;
length_report_users = ((NSUBC_VALID + num_pilots)/2 + 1)/2*Nc_users;

for folder_idx = 1:size(folders_name, 1)

    folder_name = folders_name(folder_idx, :);
    files = dir(fullfile(folder_name, '*.pcapng'));

    for file_idx = 1:numel(files)
        FILE = strcat(folder_name, files(file_idx).name); % capture file
        user_name = files(file_idx).name(end-8:end-7);
        if user_name == user_names(1:2)
            index_user = 1;
        elseif user_name == user_names(3:4)
            index_user = 2;
        elseif user_name == user_names(5:6)
            index_user = 3;
        end
        
        
        
        activity_num = files(file_idx).name(end-26:end-23);
        if activity_num == activities(1:4)
            activity = 'A';
            
        elseif activity_num == activities(5:8)
            activity = 'B';
            
        elseif activity_num == activities(9:12)
            activity = 'C';
            
        elseif activity_num == activities(13:16)
            activity = 'D';
            
        elseif activity_num == activities(17:20)
            activity = 'E';
            
        elseif activity_num == activities(21:24)
            activity = 'F';

        elseif activity_num == activities(25:28)
            activity = 'G';
            
        elseif activity_num == activities(29:32)
            activity = 'H';
            
        elseif activity_num == activities(33:36)
            activity = 'I';
            
        elseif activity_num == activities(37:40)
            activity = 'J';
            
        elseif activity_num == activities(41:44)
            activity = 'K';

        elseif activity_num == activities(45:48)
            activity = 'L';
            
        elseif activity_num == activities(49:52)
            activity = 'M';
            
        elseif activity_num == activities(53:56)
            activity = 'N';
            
        elseif activity_num == activities(57:60)
            activity = 'O';
            
        elseif activity_num == activities(61:64)
            activity = 'P';

       elseif activity_num == activities(65:68)
            activity = 'Q';
            
        elseif activity_num == activities(69:72)
            activity = 'R';
            
        elseif activity_num == activities(73:76)
            activity = 'S';
            
        elseif activity_num == activities(77:80)
            activity = 'T';
            
        elseif activity_num == activities(81:84)
            activity = 'U';
            
        end
        
        
        
        
        
        
        
        Nc = Nc_users(index_user);
        tot_bytes = tot_bytes_users(index_user);
        tot_angles = tot_angles_users(index_user);
        length_angles = length_angles_users(index_user);
        length_report = length_report_users(index_user);
        skip_start  = skip_start_users(index_user);
        skip_start_sample = skip_start_sample_users(index_user);
        
        payload_length = Nc + length_angles + length_report;
        
        disp(FILE);
        file_name = files(file_idx).name(1:end-name_suffix_offset);
        folder_save = strcat('../Data/', Test,'/', folder_proc, '/', user_name, '/');
        name_beamf_angles = strcat(folder_save, 'beamf_angles/', activity, '/', file_name,'.mat');
        name_exclusive_beamf_report = strcat(folder_save, 'exclusive_beamf_report/', file_name, '.mat');
        name_vtilde_matrices = strcat(folder_save, 'vtilde_matrices/', file_name, '.mat');
        name_time_vector = strcat(folder_save, 'time_vector/', file_name, '.mat');

        if isfile(name_time_vector)
            continue
        end

        %% read angles
        p = readpcap_beamf();
        p.open(FILE, skip_start);
        k_start = 1;
        k = k_start;
        beamf_angles = {};
        excl_beamf_reports = {};
        vtilde_matrices = {};
        time_vector = {};
        while (k <= n)
            f = p.next(payload_length, skip_start_sample);
            if isempty(f.payload)
                disp('no more frames');
                break;
            end
            if size(f.payload, 1) < payload_length
                disp('error payload_length');
                break;
            end
            if f.header.source_mac(6, 1:2) ~= user_name
                disp('error user_name');
                break;
            end
                
            timestamp_dec = flip(f.header.radiotap_header(9:16));
            timestamp_bin = de2bi(timestamp_dec, 'left-msb', 8);
            timestamp_bin = reshape(timestamp_bin.', 1, []);
            timestamp = bi2de(timestamp_bin, 'left-msb');
            time_vector{k-k_start+1} = timestamp;

            snr = flip(f.payload(1:Nc));

            start_angles = Nc+1;
            end_angles = start_angles+length_angles-1;
            angle_values = f.payload(start_angles:end_angles);
            beamforming_angles = zeros(NSUBC_VALID, tot_angles);
            for s_i = 1:NSUBC_VALID
                start_idx = (s_i-1)*tot_bytes + 1;
                end_idx = s_i*tot_bytes;%index_user
                angles_subc_dec = (angle_values(start_idx:end_idx));
                angles_subc = de2bi(angles_subc_dec, 'right-msb', 8);
                angles_subc = reshape(angles_subc.', 1, []);
                i_curs = 1;
                for a_i = 1:tot_angles
                    num_b = order_bits(a_i);
                    angle_val = bi2de(angles_subc(i_curs:i_curs+num_b-1), 'right-msb');
                    beamforming_angles(s_i, a_i) = angle_val;
                    i_curs = i_curs + num_b;
                end
            end
            beamf_angles{k-k_start+1} = beamforming_angles;
            
%             num_p= size(beamf_angles,2)
%             window=300;
%             num_image = floor(num_p/window);
%             % process data window by window
%             for i = discard:num_image-discard
%                 bf_angles = [];
%                 bf_angles = [bf_angles; beamf_angles(:,(i-1)*window+1:i*window)];
%                 bf_matrix = [];
%                 
%                 % convert the cells to 3d matrix
%                 for j = 1:length(bf_angles)
%                     bf_matrix = cat(1,bf_matrix,reshape(cell2mat(bf_angles(j)),1,234,4));
%                 end
%                 % take the avg of the windowsize (PCA start here)
%                 bf_matrix_avg = mean(abs(bf_matrix), 2);
%                 B = bf_matrix - bf_matrix_avg.*ones(1,234,4);
%                 
%                 % create zero matrix for storing the matrix 234x234x4 (after PCA)
%                 cfm_amp = zeros(size(B,2),size(B,2),size(B,3));
%                 % convert to 2d matrix for PCA, keep the angles independent
%                 for k = 1:size(bf_matrix,3)
%                     cp_amp = abs(bf_matrix(:,:,k))'*pca(abs(B(:,:,k))'/sqrt(window));
%                     cfm_amp(:,:,k) = cp_amp*cp_amp';
%                     
%                 end
%                 mat_name = strcat(name_beamf_angles(1:length(name_beamf_angles)-4), '_',string(i),'.mat');
%                 save(mat_name, 'cfm_amp');
%             end
%             

            start_report = start_angles+length_angles;
            end_report = start_report+length_report-1;
            length_payload = numel(f.payload);
            if end_report > length_payload
                continue
            end
            exclusive_beamf_report = f.payload(start_report:end_report);
            excl_beamf_reports{k-k_start+1} = exclusive_beamf_report;

            %% compute vtilde_matrix
            if Nc == 2
                vtilde_matrix = Vtilde_NSS2(beamforming_angles, Nc, Nr, NSUBC_VALID, phi_bit, psi_bit);
            elseif Nc == 1
                vtilde_matrix = Vtilde_NSS1(beamforming_angles, Nc, Nr, NSUBC_VALID, phi_bit, psi_bit);
            end
            
            vtilde_matrices{k-k_start+1} = vtilde_matrix;

            k = k + 1;

        end

        save(name_time_vector, 'time_vector')
        save(name_beamf_angles, 'beamf_angles')
        save(name_exclusive_beamf_report, 'excl_beamf_reports')
        save(name_vtilde_matrices, 'vtilde_matrices')
      
    end
    
end
