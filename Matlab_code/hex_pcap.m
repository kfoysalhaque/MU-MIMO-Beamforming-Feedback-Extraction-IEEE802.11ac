f = fopen('/home/foysal/Dropbox/Research/MU-MIMO/Activity_Recognition/Data/FeedBack/preli_test_1/split/preli_test_1_A_1_c1_n_1_AP_4x4_9C.pcapng');
pcap = fread(f,Inf,'uint8');
pcap_hex = string(dec2hex(pcap));

function pcap_hex = read_hex(file)
    pcap_file = fopen(file)
    pcap_read = fread(pcap_file, Inf, 'uint8')
    pcap_hex = string(dec2hex(pcap_read))