# test-get-source
get source

apt-get source package_name=package_version
if right -> check package_name*/debian/changelog
  if have -> grep version in first line in debian/changelog
    if version right (Question: Version binarypackage change to Version source package)
      check debian/copyright
      if have -> tar -zcvf pkg_version.tgz debian/copyright
      if have not -> tar -zcvf pkg_version.tgz (license, copying,...)
    if version wrong -> echo "..." >> log.txt
  if have not -> echo "..." >> log.txt
if wrong 
  if apt-get source only pkg name
    if right: check version of pkg name with version grep in debian/changelog
      if version right-> check continue debian/copyright 
        if have -> tar pkg_version.tgz deian/copyright
        if have not -> tar pkg_version.tgz License...
      if version wrong -> echo log
    if wrong -> echo log
