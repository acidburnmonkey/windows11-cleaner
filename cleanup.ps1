# Set the execution policy to allow script execution
Set-ExecutionPolicy RemoteSigned -Scope Process -Force


try {
Write-Host "Deleting files in temp folder..."
Remove-Item -Recurse -Force $env:TEMP\* -ErrorAction SilentlyContinue
if (-not (Test-Path $env:TEMP)) {
  New-Item -ItemType Directory -Path $env:TEMP
}
Write-Host "Deleting files in prefetch folder..."
Remove-Item -Force $env:windir\Prefetch\* -ErrorAction SilentlyContinue

$TempFolder = $env:TEMP
Write-Host "Deleting files in $TempFolder..."
Remove-Item -Recurse -Force $TempFolder\* -ErrorAction SilentlyContinue
if (-not (Test-Path $env:TEMP)) {
  New-Item -ItemType Directory -Path $TempFolder
}

} catch {
  Write-Host "Error: $_"
  Read-Host "Press Enter to exit"
}

Write-Host "Cleanup complete."
# Set the execution policy back to its previous state
Set-ExecutionPolicy Restricted -Scope Process -Force
pause
