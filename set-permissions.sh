# Set the default permissions for this directory.
# This should ensure no issues accessing files created by Docker's root user.
# Source: https://unix.stackexchange.com/questions/1314/how-to-set-default-file-permissions-for-all-folders-files-in-a-directory

echo -e "Setting the \e[31msetgid\e[0m bit, so that files/folder under <$PWD> will be created with the same group."
chmod g+s $PWD

echo -e "Settting the default ACLs for the group."
setfacl -d -m g::rwx $PWD
setfacl -d -m o::rx $PWD

# Then verify.
getfacl $PWD

echo "OK!"


# sudo chown -R $USER:$USER results/edges2shoes