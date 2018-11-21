
[System.IO.File]::Exists()

[array]$defualtGW =  ((get-NetRoute | Where-Object {$_.DestinationPrefix -eq '0.0.0.0/0'}).NextHop).split('.')
[string]$test = $($defualtGW[0..2] -join '.') + '.*'  # used to find the 
[int]$subnetNask = (Get-NetIPAddress | Where-Object {$_.IPv4Address -like $test}).PrefixLength
[string]$inferfaceName = (Get-NetIPAddress | Where-Object {$_.IPv4Address -like $test }).InterfaceAlias
[array]$StaticIP = $defualtGW


switch ($($defualtGW[3])) {
    1   { $StaticIP[3] = 6  }
    65  { $StaticIP[3] = 70 }
    128 { $StaticIP[3] = 134}
    192 { $StaticIP[3] = 198} 
  Default { }
}

[string]$defualtGW = $defualtGW -join '.'
[string]$StaticIP = $StaticIP -join '.'

New-NetIPAddress –InterfaceAlias $inferfaceName –IPAddress $StaticIP  –PrefixLength $subnetNask -DefaultGateway $defualtGW -WhatIf
