# Search TFS files (*.vssscc y *.vspscc)
$archivos = Get-ChildItem -Path . -Recurse -Include *.vssscc, *.vspscc -File

if ($archivos.Count -eq 0) {
    Write-Host "No .vssscc or .vspscc files were found." -ForegroundColor Yellow
    return
}

Write-Host "`nThe following TFS files were found:" -ForegroundColor Cyan
$archivos | ForEach-Object { Write-Host $_.FullName }

# User confirmation
$confirmacion = Read-Host "`nYou want to delete these files? (y/n)"
if ($confirmacion -match '^(y|Y)$') {
    $archivos | Remove-Item -Force -Verbose
    Write-Host "`nFiles successfully deleted." -ForegroundColor Green
} else {
    Write-Host "`nOperation canceled. No files were deleted." -ForegroundColor Yellow
}
