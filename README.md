# labsync
Enterprise Linux Patch Repository Syncing

Run all scripts as sudo.

Run <os>_baseline.sh on a completely new system that does not have a labsync repository setup or downloaded.

Run <os>_increment.sh to download the latest RPM packages to the baseline directory. Once the packages are downloaded, 
rysnc will check the contents of the compare directory and any differences will be copied to a new directory under the
increments directory. This compare will identify the newly downloaded RPM files under the baseline directory and copy 
those new files to a separate directory structure that is reflective of the current one (i.e. the folder structure will 
be retained so you can simply copy the parent folder (OracleLinux) using WinSCP in the production environment).
