$right = "ReadandExecute"
$principal = "IIS-IUSRS"
$startdir = "D:\sites\"

foreach($file in $(Get-ChildItem $startdir -Recurse)){
    $rule = New-Object System.Security.AccessControl.FileSystemAccessRule($principal,$right,"Allow")
    $acl = get-acl $file.fullname
    $acl.SetAccessRule($rule)
    Set-Acl $file.fullname }