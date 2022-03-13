#!/bin/bash

path=$(pwd)
while read emails
do
	echo "clone project fom: {$emails}"
	git clone $emails

	url_array=(`echo $emails| tr '/' ' ' `)
	project_path=$path/${url_array[3]}

	cd $project_path
	git log > ../${url_array[3]}_log.txt

	cd $path

	while read line
	do
		if [[ "$line" = "Author"* ]];then
			echo $line >> ${url_array[3]}-Developers-Emails.txt
		fi
	done <${url_array[3]}_log.txt

	rm -rf ${url_array[3]}
	rm ${url_array[3]}_log.txt

done <Developer_Emails.txt
