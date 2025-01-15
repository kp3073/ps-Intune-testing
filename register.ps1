# Variables


# Install the Get-WindowsAutopilotInfo script
Install-Script -Name Get-WindowsAutopilotInfo -Force

# Set execution policy to allow running the script
Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned

# Authenticate to Microsoft Graph
$body = @{
    grant_type    = "client_credentials"
    scope         = "https://graph.microsoft.com/.default"
    client_id     = $AppID
    client_secret = $AppSecret
}
$response = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token" -Method Post -ContentType "application/x-www-form-urlencoded" -Body $body
$accessToken = $response.access_token

# Register the device to Intune using Get-WindowsAutopilotInfo
Get-WindowsAutopilotInfo -GroupTag $groupTag -Online -TenantId $tenantId -ClientId $clientId -ClientSecret $clientSecret

# Output the result
Write-Output "Device has been registered to Intune with group tag $groupTag."
