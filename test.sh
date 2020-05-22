#!/bin/bash
LICENSE_PATTERN=[*license*]
while read -r line
do
	package_name=$(echo $line | cut -d " " -f1)
	package_version=$(echo $line | awk '{print $2}')
	if ! apt-get source "$package_name=$package_version" 2&>> log_error_get_name_version.txt
       	then
		echo "fail get source with package $package_name_$package_version" >> log_error_packages_are_not_got.txt
		if ! apt-get source $package_name 2&>> log_error_get_only_name.txt
		then
			echo "fail get source only name: package $package_name" >> log_error_packages_only_name_are_not_got.txt
		else
			echo "In progress getting source with package only name: $package_name" >> log_packages_only_name_are_got.txt
			if [ -f debian/changelog]
			then	
				if [$package_version != $(echo $package_version | grep $(grep version in debian/changelog) )]
				then
				echo "package $package_name have $package_version not match $(grep version in debian/changelog)" >> log_get_only_name_not_match_version.txt
				else
				implement funtion check debian/copyright and tar file
				fi
			fi
		fi
	else
		echo "In progress getting source of package $package_name_$package_version" >> log_packages_are_got.txt
		implement funtion check $package_version with version of debian/changelog 
		if [ -f $package_name*/debian/copyright]
	       	then
			tar -zcvf $package_name_$package_version.tgz $package_name*/debian/copyright

		else
			tar -zcvf $package_name_$package_version.tgz $package_name*/$LICENSE_PATTERN
		fi
		mv *.tgz output
	fi
done < test.txt
