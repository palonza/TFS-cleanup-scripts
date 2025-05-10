# Buscar todos los archivos recursivamente
$archivos = Get-ChildItem -Path . -Recurse -File

if ($archivos.Count -eq 0) {
    Write-Host "No files found to unlock." -ForegroundColor Yellow
    return
}

Write-Host "`n $($archivos.Count) files were found. Proceeding to unlock those who need it..." -ForegroundColor Cyan

foreach ($archivo in $archivos) {
    if (Get-Item -Path $archivo.FullName -Stream "Zone.Identifier" -ErrorAction SilentlyContinue) {
        try {
            Unblock-File -Path $archivo.FullName
            Write-Host "Unlock: $($archivo.FullName)" -ForegroundColor Green
        } catch {
            Write-Host "Error unlocking: $($archivo.FullName)" -ForegroundColor Red
        }
    }
}

Write-Host "`nProcess completed." -ForegroundColor Cyan
