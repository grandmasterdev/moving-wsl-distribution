# Moving WSL Dist to another drive

By Default the WSL distribution will be installed to the default `C drive`. But it is possible to move the installation to be on another drive.

## Manual

1. Step 1

   ```powershell
   cd D:\
   mkdir WSL
   cd WSL
   wsl --export Ubuntu ubuntu.tar
   wsl --unregister Ubuntu
   mkdir Ubuntu
   wsl --import Ubuntu Ubuntu ubuntu.tar
   ```

   explanation:

   - `wsl --export Ubuntu ubuntu.tar` copy the content of the current Ubuntu image to a tar file that you will get in your D: drive.
   - `wsl --unregister Ubuntu` remove the current active distribution
   - `wsl --import Ubuntu Ubuntu unbuntu.tar` import the distribution from the tar file. The 1st Ubuntu is the name of the distribution (follow the name of the old distribution name). The 2nd Ubuntu is the directory of folder where instance should be. `ubuntu.tar` is the compressed distribution from the previous copy.

2. Step 2

   In Step 1, you have created a user for Ubuntu. After export and import, the new instance will use root by default. If you want to continue to use that user, please configure it via registry table.
   Find the directory in registry HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Lxss which DistributionName is “Ubuntu”. Set its DefaultUid to decimal 1000 (or hex 3e8).

3. Step 3

   Set the WSL to use the new distribtion via the following

   ```powershell
   wsl set-version Ubuntu 2 # Set the default WSL to version 2 for the distribution
   wsl -d Ubuntu # Start the distribution
   ```

## Automate

If you want to automate the process of `Step 1`, there's a script made that will allow you to do just that.

```powershell

.\scripts\moving-dist.ps1

```
