%%% Data collection for 3 monitors with 1 and 4 antennas: CSI collection starts at mo.1 first and goes to mo.3; then
%%% ends at mo.1 first and mo.3 last.
%%% This code has been written to generate data_frames for the ReWis project.
%%% The code gets raw CSI data in form of .pcap files as input and after preprocessing/
%%% cleaning generate PCA of the CSI data frames (with size of SxW packets) with constant size.
%%% The preprocessing includes: 1) Aligning data from diffrent monitors; 2) Detecting and discarding packets that are missed at different monitor/antennas and PCA.
%%% Note: This code is only valid for 3 monitors for 1 monitors use ReWiS_data_generator_1mo.m
%%% Niloofar Bahadori
%%% June 2021.


clc; clear; close all
%%% Data generator for multimple antennas
num_ant = 1;
num_mo = 3;
env = ['A1'; 'A2'];
CHIP = '4366c0';          % wifi chip (possible values 4339, 4358, 43455c0, 4366c0)
BW = 80;
window=300;  %size of CSI data_frame (number of CSI packets in time) 


if BW == 20 %%% Discard the pilot, null, guard subcarriers
    non_zero = [5:32,34:61]; %%% non-zero indices
else
    non_zero = [7:128,132:251];
end

act = ['W','S'];




conf = ['1x1'];

discard = 2;
save_in = 'ReWiSe Data/data_mat_3mon_w300/Empty_data_folder_3mon';
check = [];


for e = 1:length(env)
    for c = 1: size(conf,1)
        if c==1
            num_ant = 1;
        else
            num_ant = 4;
        end
%     for c = 2 %%% c = 1, 1 antenna; c = 2, 4 antennas

        for a = 1:length(act)
            seq_plane = cell(num_mo,1);
            core_plane = cell(num_mo,1);
            csi_im = cell(num_mo,str2double(conf(c,end)));
            bad_key = cell(num_mo,2);
            data_mon = cell(num_mo,1);
            data_raw = cell(num_mo,1);
            for m = 1:num_mo
                %%% generate the desired .pcap file name
                sub_file = sprintf('%s_noBF_%dMhz_%s_M%d_3Mo_%s.pcap',act(a),BW,conf(c,:),m,env(e,:));
                FILE = sprintf('ReWiSe Data/CSI_collection/%s/%dMHz/3mo/m%d/%s',env(e,:),BW,m,sub_file);
                fprintf(1, 'Now reading %s\n', FILE);

                NPKTS_MAX = 600000;       % max number of UDPs to process

                %%% read file
                HOFFSET = 16;           % header offset
                NFFT = BW*3.2;          % fft size
                p = readpcap();
                p.open(FILE);
                n = min(length(p.all()),NPKTS_MAX);
                p.from_start();
                csi_buff = complex(zeros(n,NFFT),0);
                k = 1;
                seq_num = [];
                core_num = [];
                %%%
                while (k <= n)
                    f = p.next();
                    if isempty(f)
                        disp('no more frames');
                        break;
                    end

                    if f.header.orig_len-(HOFFSET-1)*4 ~= NFFT*4
                        disp('skipped frame with incorrect size');
                        continue;
                    end
                    payload = f.payload;
                    P14 = dec2hex(payload(14),8);
                    seq_num = [seq_num; P14(5:end)];
                    core_num = [core_num; P14(1:2)];

                    H = payload(HOFFSET:HOFFSET+NFFT-1); %% header removed

                    if (strcmp(CHIP,'4339') || strcmp(CHIP,'43455c0'))
                        Hout = typecast(H, 'int16');
                    elseif (strcmp(CHIP,'4358'))
                        Hout = unpack_float(int32(0), int32(NFFT), H);
                    elseif (strcmp(CHIP,'4366c0'))
                        Hout = unpack_float(int32(1), int32(NFFT), H);
                    else
                        disp('invalid CHIP');
                        break;
                    end
                    Hout = reshape(Hout,2,[]).';

                    cmplx = double(Hout(1:NFFT,1))+1j*double(Hout(1:NFFT,2));
                    csi_buff(k,:) = cmplx.';               
                    k = k + 1;
                end
                seq_plane{m} = seq_num;
                core_plane{m} = core_num;
                data_raw{m} = csi_buff;
                % filter the data to remove incomplete cores data before
                % saving it as data_mon 
                if c == 2            
                    bad_index = [];
                    k = 1;
                    while k < length(seq_plane{m})-num_ant+1   
                        if ~(prod(seq_plane{m}(k,:) == seq_plane{m}(k+num_ant-1,:)))
                            bad_key{m,1} = [bad_key{m,1}; seq_plane{m}(k,:)]; 
                            bad_key{m,2} = [bad_key{m,2}, k];
                            if prod(seq_plane{m}(k,:) == seq_plane{m}(k+num_ant-2,:)) && prod(seq_plane{m}(k,:) == seq_plane{m}(k+num_ant-3,:))
                                %%% means 3 cores exist and must be deleted
                                seq_plane{m}(k:k+num_ant-2,:) = [];
                                bad_index = [bad_index, k:k+num_ant-2];
                            elseif ~(prod(seq_plane{m}(k,:) == seq_plane{m}(k+num_ant-2,:))) && (prod(seq_plane{m}(k,:) == seq_plane{m}(k+num_ant-3,:)))
                                %%% means 2 cores exist and must be deleted
                                seq_plane{m}(k:k+num_ant-3,:) = [];
                                bad_index = [bad_index, k:k+1];
                            else
                                %%% means 1 cores exist and must be deleted
                                seq_plane{m}(k,:) = [];
                                bad_index = [bad_index, k];
                            end
                        else
                           k = k + num_ant;
                        end
                         
                    end
                    %%%% Delete the bad cores data
                    csi_buff(bad_index,:) = [];
                    core_plane{m}(bad_index,:) = [];

                    data_raw{m} = csi_buff;
                else
                    data_raw{m} = csi_buff;
                end     
            end

            %%% type of activity
            if act(a) == 'W'
                activity = 'walking';
            elseif act(a) == 'S'
                activity = 'sitting';
            elseif act(a) == 'C'
                activity = 'crosslegtouch';
            elseif act(a) == 'R'
                activity = 'rotating';
            elseif act(a) == 'T'
                activity = 'standing';
            else
                activity = 'lying';
            end

            fprintf(1, 'you made it to saving%s\n', '!');

                 for m = 1:num_mo
                     
                     num_p=size(data_raw{m},1);
                     num_image = floor(num_p/window);
                     
                     for i = discard:num_image-discard
                     csi = [];
                     csi = [csi; data_raw{m}((i-1)*window+1:i*window,:)];

           
                    csi= csi(:,non_zero);
                    
                      csi_avg = mean(abs(csi), 2);
                      B = csi - csi_avg*ones(1,length(non_zero));
                      cp_amp = abs(csi)'*pca(abs(B)'/sqrt(window));
                      cfm_amp = cp_amp*cp_amp';

                      %%% PCA data
                      cfm_data = squeeze(cfm_amp); 
                    mat_name = sprintf('./%s/%s/%dant/m%d/%s/pca_mat_%d.mat',...
                        save_in, env(e,:), str2double(conf(c,end)), m, activity,i-discard);
                    save(mat_name,'cfm_data')
                     end
                     end
                end



            end

    end
        
   
