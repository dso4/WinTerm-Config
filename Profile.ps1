#What PS is opening? "Core" is pwsh.exe (PS7+), "Desktop" is powershell.exe (PS5). Nobody cares about 6.
$IsPowerShellCore = $PSVersionTable.PSEdition -eq "Core"

$OHMP_CONFIG = Join-Path $env:GITPATH "WinTerm-Config\json\catppuccin_latte.omp.json"

# Set PSReadLine colors to match Catppuccin Latte (works on both versions)
Set-PSReadLineOption -Colors @{
    Command                = '#1e66f5'  # blue
    Number                 = '#fe640b'  # peach
    Member                 = '#1e66f5'  # blue
    Operator               = '#179299'  # cyan
    Type                   = '#df8e1d'  # yellow
    Variable               = '#ea76cb'  # pink
    Parameter              = '#ea76cb'  # pink
    ContinuationPrompt     = '#6c6f85'  # overlay1
    Default                = '#4c4f69'  # text
    Emphasis               = '#8839ef'  # mauve
    Error                  = '#d20f39'  # red
    Selection              = '#bcc0cc'  # surface0
    Comment                = '#6c6f85'  # overlay1
    Keyword                = '#8839ef'  # mauve
    String                 = '#40a02b'  # green
}

# Configure features based on PowerShell edition
if ($IsPowerShellCore) {
    # PowerShell 7+ features (pwsh.exe) - full modern experience
    Set-PSReadLineOption -PredictionSource History
    Set-PSReadLineOption -PredictionViewStyle ListView
    Set-PSReadLineOption -Colors @{
        InlinePrediction = '#9ca0b0'  # overlay0
        ListPrediction   = '#9ca0b0'  # overlay0
    }
    
    Import-Module Terminal-Icons
    # Initialize Oh My Posh for PowerShell Core
    oh-my-posh init pwsh --config $OHMP_CONFIG | Invoke-Expression
}
else {
    # PowerShell 5 compatibility mode (powershell.exe) - skip modern features
    Write-Host "PowerShell 5 compatibility mode - prediction features disabled" -ForegroundColor Yellow
    
    Import-Module Terminal-Icons
    # Initialize Oh My Posh for Windows PowerShell
    oh-my-posh init powershell --config $OHMP_CONFIG | Invoke-Expression
}