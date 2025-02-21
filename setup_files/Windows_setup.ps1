# Загружаем конфигурацию
$config = Get-Content -Raw -Path ".\config.json" | ConvertFrom-Json
## Получим точный путь к домашней папке пользователя
$userProfile = [System.Environment]::GetFolderPath('UserProfile')

Write-Host "User Profile: $userProfile"

# Теперь создадим путь к папке dotfiles
$dotfilesPath = Join-Path -Path $userProfile -ChildPath "dotfiles"

Write-Host "Dotfiles path: $dotfilesPath"

# Проверим, существует ли эта директория
if (!(Test-Path -PathType Container $dotfilesPath)) {
    Write-Host "Dotfiles path does not exist!"
    exit 1
} else {
    Write-Host "Dotfiles path exists!"
}


# Проходим по каждому конфигу
foreach ($key in $config.configs.PSObject.Properties.Name) {
    $targetPath = $dotfilesPath + "\" + $key
    $linkPath = $config.configs.$key.windows -replace "%USERNAME%", $env:USERNAME

    # Создаем директорию, если ее нет
    if (!(Test-Path $linkPath)) {
        New-Item -ItemType Directory -Path $linkPath -Force
    }

    # Создаем симлинк
    New-Item -ItemType SymbolicLink -Path "$linkPath" -Target "$targetPath" -Force
    Write-Host "Linked $targetPath -> $linkPath"
}

Write-Host "All symbolic links created!"
