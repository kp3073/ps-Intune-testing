# Variables
$AppID = "abdcc16f-2ff2-49b4-beb2-b7bdb521bcfb"
$tenantId = "a221016b-cc73-49c9-a858-7fca1f010971"
$AppSecret = "Z7j8Q~66-.lp7LkQcCuMNMuE0vn0n3TEIh0mZbUC"
$groupTag = "SJC"

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
