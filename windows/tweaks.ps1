# disable cortana
$windows_policies = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows'
if (-not (Test-Path -Path "$windows_policies\Windows Search")) {
  New-Item -Path $windows_policies -Name 'Windows Search'
}
Set-ItemProperty -Path "$windows_policies\Windows Search" -Name 'AllowCortana' -Value 0
Stop-Process -name 'explorer'

# disable web results in start menu
$windows_current = 'HKCU:\Software\Microsoft\Windows\CurrentVersion'
if (-not (Test-Path -Path "$windows_current\Search")) {
  New-Item -Path $windows_current -Name 'Search'
}
Set-ItemProperty -Path "$windows_current\Search" -Name 'BingSearchEnabled'-Value 0
Set-ItemProperty -Path "$windows_current\Search" -Name 'AllowSearchToUseLocation' -Value 0
# restart required, unfortunately
