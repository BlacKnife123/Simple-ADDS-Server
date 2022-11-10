$NICNAME = "LAN"
$IFINDEX = (Get-NetAdapter | Where-Object Name -EQ "$NICNAME" | Select-Object -ExpandProperty "IfIndex")
$IPADDRESS = "10.40.40.1"
$PREFIX = "24"
$MASK = "255.255.255.0"
$LOOPBACK = "127.0.0.1"
$SERVICES = "AD-Domain-Services"
$DOMAINNAME = "Name.local"
$BIOSNAME = "NAME"
$PASSWORD = (ConvertTo-SecureString -String "PASSWORD" -AsPlainText -Force)

New-NetIPAddress -InterfaceIndex "$IFINDEX" -IPAddress "$IPADDRESS" -PrefixLength "$PREFIX"
Set-DnsClientServerAddress -InterfaceIndex "$IFINDEX" -ServerAddresses "$LOOPBACK"

Install-WindowsFeature -Name "$SERVICES" -IncludeManagementTools

Install-ADDSForest -DomainName "$DOMAINNAME" -DomainNetBiosName "$BIOSNAME" -InstallDns -SafeModeAdministratorPassword $PASSWORD

