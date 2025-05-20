Write-Host "Führ Windows -Update durch..."
Install-Module -Name PSWindowsUpdate -Force
# Hinzufügen von Microsoft Updates 
Add-WUServiceManager -ServiceID "7971f918-a847-4430-9279-4a52d1efe18d" -AddServiceFlag 7
# Microsoft Updates auflisten
Get-WUList -MicrosoftUpdate
Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot
Write-Host "Versuche OneDrive zu entfernen, falls vorhanden..."
winget uninstall Microsoft.OneDrive
Write-Host "Versuche CoPilot zu entfernen, falls vorhanden..."
Get-AppxPackage -AllUsers | Where-Object { $_.Name -like "*Copilot*" } | ForEach-Object {Remove-AppxPackage -Package $_.PackageFullName -AllUsers -ErrorAction SilentlyContinue} 
Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -eq 'Microsoft.Copilot' } | ForEach-Object {Remove-AppxProvisionedPackage -Online -PackageName $_.PackageName -ErrorAction SilentlyContinue}
