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

# Logs
Write-Host "Deleting windows loggs..."
gci $Env:windir\logs\CBS -rec | rm -rec -for

#component cleanup operation on the online Windows image
Write-Host "Performing Componet cleanup..."
dism /online /cleanup-image /StartComponentCleanup

# Windos temps
try {
    gci $Env:windir\temp -rec | rm -rec -for
} catch {
    Write-Host "Error: $_"
    Read-Host "Press Enter to continue"
}

Write-Host "Cleanup complete."
# Set the execution policy back to its previous state
Set-ExecutionPolicy Restricted -Scope Process -Force
pause
