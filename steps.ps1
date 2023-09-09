Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
(Get-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp\" -Name PortNumber).PortNumber
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp\" -Name PortNumber -Value 4490
New-NetFirewallRule -DisplayName "Custom RDP Port (TCP-In)" -Direction Inbound -LocalPort 4490 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Custom RDP Port (UDP-In)" -Direction Inbound -LocalPort 4490 -Protocol UDP -Action Allow
Restart-Service TermService -Force
Get-NetTCPConnection -LocalPort 4490; Get-NetUDPEndpoint -LocalPort 4490
