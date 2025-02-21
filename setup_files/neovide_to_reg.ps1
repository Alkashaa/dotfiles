# Ищем neovide.exe в типичных местах
$possiblePaths = @(
    "$env:ProgramFiles\Neovide\neovide.exe",
    "${env:ProgramFiles(x86)}\Neovide\neovide.exe",
    "$env:USERPROFILE\Neovide\neovide.exe",
    "$env:USERPROFILE\AppData\Local\Neovide\neovide.exe"
)

$neovidePath = $null
foreach ($path in $possiblePaths) {
    if (Test-Path $path) {
        $neovidePath = $path
        break
    }
}

if (-not $neovidePath) {
    $neovidePath = Get-ChildItem -Path "C:\" -Recurse -File -ErrorAction SilentlyContinue | 
                   Where-Object { $_.Name -eq "neovide.exe" } | 
                   Select-Object -First 1 -ExpandProperty FullName
}

if ($neovidePath) {
    $escapedPath = $neovidePath -replace '\\', '\\'
    $regContent = @"
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\*\shell\Open with Neovide]
@="Open with Neovide"
"Icon"="\"$escapedPath\""

[HKEY_CLASSES_ROOT\*\shell\Open with Neovide\command]
@="\"$escapedPath\" \"%1\""
"@

    $regContent | Out-File -FilePath "add_neovide.reg" -Encoding UTF8
    Write-Host "Generated add_neovide_with_icon.reg with path: $neovidePath"
} else {
    Write-Host "Could not find neovide.exe on this system."
}