# Deploys Active Directory Domain Services on the Windows Server VM
# Run after OS install, with static IP 10.10.30.10/24 already configured

Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
Import-Module ADDSDeployment

Install-ADDSForest `
  -DomainName "soclab.local" `
  -DomainNetbiosName "SOCLAB" `
  -InstallDns:$true `
  -SafeModeAdministratorPassword (ConvertTo-SecureString "ChangeMe!2026" -AsPlainText -Force) `
  -Force:$true

# After reboot, create baseline OUs and test users (customize as needed):
# New-ADOrganizationalUnit -Name "SOC-Lab-Users"
# New-ADUser -Name "test.user" -SamAccountName "test.user" -Enabled $true `
#   -AccountPassword (ConvertTo-SecureString "TestPass!2026" -AsPlainText -Force)
#
# Set DNS forwarder to pfSense so soclab.local machines still resolve external names:
#   DNS Manager -> Properties -> Forwarders -> add 10.10.30.1
