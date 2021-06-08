#! /usr/bin/bash
date=$(date +"%Y-%m-%d")
# set the working directory for repo storage
oracle_dir='/mnt/hgfs/labsync/data/oracle_7'
# PackageKit holds on to the YUM process; turn it off to avoid PID conflict
systemctl stop packagekit
yum clean all
# make baseline
reposync --repoid=ol7_latest --norepopath --download-metadata --newest-only --downloadcomps -p ${oracle_dir}/baseline/OracleLinux/OL7/latest/x86_64/
reposync --repoid=ol7_UEKR6 --norepopath --download-metadata --newest-only --downloadcomps -p ${oracle_dir}/baseline/OracleLinux/OL7/UEKR6/x86_64/
reposync --repoid=ol7_kvm_utils --norepopath --download-metadata --newest-only --downloadcomps -p ${oracle_dir}/baseline/OracleLinux/OL7/kvm/utils/x86_64/
# compare the baseline to the compare directory and export the difference to a new increment directory
rsync -rcC --ignore-existing --compare-dest=${oracle_dir}/compare/ ${oracle_dir}/baseline/ ${oracle_dir}/increments/${date}-increment/
# copy the contents of the current baseline to the compare directory.
rsync -hvrtP ${oracle_dir}/baseline/ ${oracle_dir}/compare/
# turn PackageKit back on
systemctl start packagekit
