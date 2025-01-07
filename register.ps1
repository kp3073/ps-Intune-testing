# Define variables
$vaultName = "IntuneSecretsaz"
$secretName = "clientSecret"
$tenantIdName = "tenantId"
$clientIdName = "clientId"
$grouptag = "XYZ"

# Retrieve secrets from Azure Key Vault
$clientSecret = (Get-AzKeyVaultSecret -VaultName $vaultName -Name $secretName).SecretValueText
$tenantId = (Get-AzKeyVaultSecret -VaultName $vaultName -Name $tenantIdName).SecretValueText
$clientId = (Get-AzKeyVaultSecret -VaultName $vaultName -Name $clientIdName).SecretValueText

# Get an access token
$body = @{
	grant_type = "client_credentials"
	client_id = $clientId
	client_secret = $clientSecret
	scope = "https://graph.microsoft.com/.default"
}

$response = Invoke-RestMethod -Method Post -Uri "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token" -ContentType "application/x-www-form-urlencoded" -Body $body
$accessToken = $response.access_token

# Install the required module
Install-Script -Name Get-WindowsAutopilotInfo -Force

# Set execution policy
Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned

# Run the Autopilot script
Get-WindowsAutopilotInfo -GroupTag $grouptag -Online -AccessToken $accessToken