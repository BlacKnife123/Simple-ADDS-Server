#Add users frmo CSV file
$Path = "C:\Users\Administrator\Documents\Book1.csv"
$ADUsers = Import-Csv "$Path"

foreach ($User in $ADUsers)
{
    $Username   = $User.username
    $Password   = $User.password
    $Firstname  = $User.firstname
    $Lastname   = $User.lastname
    $Department = $User.department
    $OU         = $User.ou

    if (Get-ADUser -F {SamAccountName -eq $Username})
    {
    Write-Warning "User $Username has already exist"
    }
    else
    {
    New-ADUser `
    -SamAccountName $Username `
    -Name "$Firstname $Lastname" `
    -GivenName $Firstname `
    -Surname $Lastname `
    -Enabled $true `
    -ChangePasswordAtLogon $true `
    -Department $Department `
    -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force)
    }
}


#Add single user to domain
New-ADUser -Name "NAME" -ChangePasswordAtLogon $true -AccountPassword (Read-Host -AsSecureString "password") -Enabled $true