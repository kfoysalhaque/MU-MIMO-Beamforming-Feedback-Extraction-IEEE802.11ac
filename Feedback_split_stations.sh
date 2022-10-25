#!/bin/bash

<<com

This script extract the MU-MIMO feedbacks of the available stations
from the raw pcap captures.

Copyright (C) 2022  Khandaker Foysal Hauqe
email: haque.k@northeastern.edu

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.

com



stations=("9C" "25" "89")




for FOLDERNAME in Data
do
	cd "$FOLDERNAME"
	cd "$1"

	if [ ! -d 'processed_dataset' ]
	then
		mkdir 'processed_dataset'
	fi



	if [ ! -d 'processed_dataset/9C' ]
	then
		mkdir 'processed_dataset/9C'
	fi

	if [ ! -d 'processed_dataset/25' ]
	then
		mkdir 'processed_dataset/25'
	fi

	if [ ! -d 'processed_dataset/89' ]
	then
		mkdir 'processed_dataset/89'
	fi



	for str in ${stations[@]};do

		
		if [ ! -d 'processed_dataset/'$str'/beamf_angles' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles'
		fi

		if [ ! -d 'processed_dataset/'$str'/exclusive_beamf_report' ]
		then
			mkdir 'processed_dataset/'$str'/exclusive_beamf_report'
		fi

		if [ ! -d 'processed_dataset/'$str'/time_vector' ]
		then
			mkdir 'processed_dataset/'$str'/time_vector'
		fi

		if [ ! -d 'processed_dataset/'$str'/vtilde_matrices' ]
		then
			mkdir 'processed_dataset/'$str'/vtilde_matrices'
		fi

		
		if [ ! -d 'processed_dataset/'$str'/FeedBack_Pcap' ]
		then
			mkdir 'processed_dataset/'$str'/FeedBack_Pcap'
		fi







		if [ ! -d 'processed_dataset/'$str'/beamf_angles/A' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/A'
		fi

		if [ ! -d 'processed_dataset/'$str'/beamf_angles/A_batch' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/A_batch'
		fi



		if [ ! -d 'processed_dataset/'$str'/beamf_angles/B' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/B'
		fi

		if [ ! -d 'processed_dataset/'$str'/beamf_angles/B_batch' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/B_batch'
		fi



		if [ ! -d 'processed_dataset/'$str'/beamf_angles/C' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/C'
		fi

		if [ ! -d 'processed_dataset/'$str'/beamf_angles/C_batch' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/C_batch'
		fi



		if [ ! -d 'processed_dataset/'$str'/beamf_angles/D' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/D'
		fi

		if [ ! -d 'processed_dataset/'$str'/beamf_angles/D_batch' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/D_batch'
		fi



		if [ ! -d 'processed_dataset/'$str'/beamf_angles/E' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/E'
		fi

		if [ ! -d 'processed_dataset/'$str'/beamf_angles/E_batch' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/E_batch'
		fi



		if [ ! -d 'processed_dataset/'$str'/beamf_angles/F' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/F'
		fi

		if [ ! -d 'processed_dataset/'$str'/beamf_angles/F_batch' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/F_batch'
		fi



		if [ ! -d 'processed_dataset/'$str'/beamf_angles/G' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/G'
		fi

		if [ ! -d 'processed_dataset/'$str'/beamf_angles/G_batch' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/G_batch'
		fi



		if [ ! -d 'processed_dataset/'$str'/beamf_angles/H' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/H'
		fi

		if [ ! -d 'processed_dataset/'$str'/beamf_angles/H_batch' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/H_batch'
		fi



		if [ ! -d 'processed_dataset/'$str'/beamf_angles/I' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/I'
		fi

		if [ ! -d 'processed_dataset/'$str'/beamf_angles/I_batch' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/I_batch'
		fi



		if [ ! -d 'processed_dataset/'$str'/beamf_angles/J' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/J'
		fi

		if [ ! -d 'processed_dataset/'$str'/beamf_angles/J_batch' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/J_batch'
		fi



		if [ ! -d 'processed_dataset/'$str'/beamf_angles/K' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/K'
		fi

		if [ ! -d 'processed_dataset/'$str'/beamf_angles/K_batch' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/K_batch'
		fi



		if [ ! -d 'processed_dataset/'$str'/beamf_angles/L' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/L'
		fi

		if [ ! -d 'processed_dataset/'$str'/beamf_angles/L_batch' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/L_batch'
		fi



		if [ ! -d 'processed_dataset/'$str'/beamf_angles/M' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/M'
		fi

		if [ ! -d 'processed_dataset/'$str'/beamf_angles/M_batch' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/M_batch'
		fi



		if [ ! -d 'processed_dataset/'$str'/beamf_angles/N' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/N'
		fi

		if [ ! -d 'processed_dataset/'$str'/beamf_angles/N_batch' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/N_batch'
		fi



		if [ ! -d 'processed_dataset/'$str'/beamf_angles/O' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/O'
		fi

		if [ ! -d 'processed_dataset/'$str'/beamf_angles/O_batch' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/O_batch'
		fi


		if [ ! -d 'processed_dataset/'$str'/beamf_angles/P' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/P'
		fi

		if [ ! -d 'processed_dataset/'$str'/beamf_angles/P_batch' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/P_batch'
		fi



		if [ ! -d 'processed_dataset/'$str'/beamf_angles/Q' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/Q'
		fi

		if [ ! -d 'processed_dataset/'$str'/beamf_angles/Q_batch' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/Q_batch'
		fi



		if [ ! -d 'processed_dataset/'$str'/beamf_angles/R' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/R'
		fi

		if [ ! -d 'processed_dataset/'$str'/beamf_angles/R_batch' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/R_batch'
		fi



		if [ ! -d 'processed_dataset/'$str'/beamf_angles/S' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/S'
		fi

		if [ ! -d 'processed_dataset/'$str'/beamf_angles/S_batch' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/S_batch'
		fi



		if [ ! -d 'processed_dataset/'$str'/beamf_angles/T' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/T'
		fi

		if [ ! -d 'processed_dataset/'$str'/beamf_angles/T_batch' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/T_batch'
		fi



		if [ ! -d 'processed_dataset/'$str'/beamf_angles/U' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/U'
		fi

		if [ ! -d 'processed_dataset/'$str'/beamf_angles/U_batch' ]
		then
			mkdir 'processed_dataset/'$str'/beamf_angles/U_batch'
		fi


	done




	for FILENAME in ./*
	do
		echo "$FILENAME"
		FILENAMEOUTBASE=${FILENAME:1:23}

		FILENAMEOUTEND="_89.pcapng"
		FILENAMEOUT='processed_dataset/89/FeedBack_Pcap'$FILENAMEOUTBASE$FILENAMEOUTEND
		echo "$FILENAMEOUT"
		if [ ! -f "$FILENAMEOUT" ]
		then
			tshark -r "$FILENAME" -Y 'wlan.vht.mimo_control.feedbacktype==MU && wlan.addr==CC:40:D0:57:EA:89' -w "$FILENAMEOUT"
		fi



		FILENAMEOUTEND="_9C.pcapng"
		FILENAMEOUT='processed_dataset/9C/FeedBack_Pcap'$FILENAMEOUTBASE$FILENAMEOUTEND
		echo "$FILENAMEOUT"
		if [ ! -f "$FILENAMEOUT" ]
		then
			tshark -r "$FILENAME" -Y 'wlan.vht.mimo_control.feedbacktype==MU && wlan.addr==B0:B9:8A:63:55:9C' -w "$FILENAMEOUT"
		fi


		FILENAMEOUTEND="_25.pcapng"
		FILENAMEOUT='processed_dataset/25/FeedBack_Pcap'$FILENAMEOUTBASE$FILENAMEOUTEND
		echo "$FILENAMEOUT"
		if [ ! -f "$FILENAMEOUT" ]
		then
			tshark -r "$FILENAME" -Y 'wlan.vht.mimo_control.feedbacktype==MU && wlan.addr==38:94:ED:12:3C:25' -w "$FILENAMEOUT"
		fi


	done
done

