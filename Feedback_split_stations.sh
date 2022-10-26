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

