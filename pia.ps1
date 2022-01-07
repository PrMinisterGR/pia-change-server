# Specify where PIA is installed, below it's the default.
$PIA_Install_Folder = "C:\Program Files\Private Internet Access\"

# How long to wait between checking if the IP has changed & actions involving regions.
$Sleep_Seconds = 1

# Global variables don't touch.
$Current_VPN_IP =""
$New_VPN_IP = ""

# Loop begins.
while ($Current_VPN_IP -eq $New_VPN_IP) {
    # GET CURRENT IP
    $Current_VPN_IP = &$PIA_Install_Folder"piactl.exe" --% get vpnip
    Write-Output "Current VPN IP: " $Current_VPN_IP
    Start-Sleep -Seconds $Sleep_Seconds
    # GET REGIONS AND EXCLUDE CURRENT & AUTO
    $Current_VPN_Region = &$PIA_Install_Folder"piactl.exe" --% get region
    Write-Output "Current VPN Region: " $Current_VPN_Region
    Start-Sleep -Seconds $Sleep_Seconds
    $VPN_Regions = &$PIA_Install_Folder"piactl.exe" --% get regions
    Start-Sleep -Seconds $Sleep_Seconds
    $New_VPN_Regions_Temp = $VPN_Regions | Where-Object { $_ –ne "auto" }
    $New_VPN_Regions = $New_VPN_Regions_Temp | Where-Object{ $_ -ne $Current_VPN_Region}
    Write-Output "VPN Regions Minus Current: " $New_VPN_Regions
    # SELECT RANDOM REGION
    $New_Region = Get-Random -InputObject $New_VPN_Regions
    Write-Output "Random Region to connect to: " $New_Region
    Start-Sleep -Seconds $Sleep_Seconds
    # CONNECT TO RANDOM REGION
    $Region_Argument = "set region"
    $Set_VPN_Region = Start-Process $PIA_Install_Folder"piactl.exe" -ArgumentList @($Region_Argument, $New_Region)
    Write-Output $Set_VPN_Region
    Start-Sleep -Seconds $Sleep_Seconds
    $New_VPN_IP = &$PIA_Install_Folder"piactl.exe" --% get vpnip
    # WAIT UNTI WE GET A REAL EXTERNAL IP
    while (($New_VPN_IP -eq "Unknown") -or ($New_VPN_IP -like $Current_VPN_IP)){
        Start-Sleep -Seconds $Sleep_Seconds
        $New_VPN_IP = &$PIA_Install_Folde"piactl.exe" --% get vpnip
    }
    Write-Output "New VPN IP:" $New_VPN_IP
}