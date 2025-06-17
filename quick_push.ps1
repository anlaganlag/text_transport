param(
    [Parameter(Mandatory=$false, Position=0)]
    [string]$Message
)

if ([string]::IsNullOrEmpty($Message)) {
    $Message = "quick push: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
}

Write-Host "Adding all files..."
git add .
if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to add files."
    exit 1
}

Write-Host "Committing with message: '$Message'..."
git commit -m "$Message"
if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to commit."
    # Attempt to reset if commit fails (e.g., nothing to commit)
    # This part can be improved based on specific needs.
    Write-Host "Nothing to commit or commit failed."
}

Write-Host "Pushing to remote..."
git push
if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to push."
    exit 1
}

Write-Host "Push successful!" 