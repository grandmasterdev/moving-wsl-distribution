$NewDrive = Read-host -Promp "Input the name of the drive to move (eg. D) "

if ( $NewDrive ) {
    echo "Creating WSL in the new drive..."

    cd $NewDrive":"
    mkdir WSL
    cd WSL

    echo "Getting current distribution name..."
    
    $DefaultDistId = Get-ItemPropertyValue 'HKCU:HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Lxss' -Name DefaultDistribution
    
    echo "Id: $DefaultDistId"
    
    $DistName = Get-ItemPropertyValue "HKCU:HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Lxss\$DefaultDistId" -Name DistributionName
    
    echo "Distribution Name: $DistName"

    echo ""
    echo "Compressing distribution to tar file..."
    wsl --export $DistName ubuntu.tar
    wsl --unregister $DistName

    echo ""
    echo "Create a new distribution folder..."
    mkdir $DistName

    echo ""
    echo "Untar the distribution into the new distribution folder..."
    wsl --import $DistName $DistName ubuntu.tar

    echo ""
    echo "Reset WSL..."
    wsl set-version Ubuntu 2 # Set the default WSL to version 2 for the distribution
    wsl -d Ubuntu # Start the distribution

    echo "######"
    echo "Done!"
    echo "######"
}

Read-host -Promp "Press enter to exit"