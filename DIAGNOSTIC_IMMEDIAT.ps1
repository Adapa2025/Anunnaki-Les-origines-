# Script de diagnostic immediat - A executer maintenant
# Date: 29 novembre 2025
# Objectif: Verifier processus MCP residuels et etat systeme apres incident

Write-Host "===============================================" -ForegroundColor Cyan
Write-Host "DIAGNOSTIC IMMEDIAT - Verification Systeme" -ForegroundColor Cyan
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host ""

# Verifier processus Node/NPM actifs
Write-Host "1. Verification des processus Node/NPM/NPX..." -ForegroundColor Yellow
$nodeProcesses = Get-Process | Where-Object {$_.ProcessName -match "node|npm|npx"} -ErrorAction SilentlyContinue

if ($nodeProcesses) {
    Write-Host "PROCESSUS NODE DETECTES:" -ForegroundColor Red
    $nodeProcesses | Select-Object ProcessName, Id, CPU, WorkingSet | Format-Table

    Write-Host "Voulez-vous terminer ces processus? (O/N)" -ForegroundColor Yellow
    $response = Read-Host
    if ($response -eq "O" -or $response -eq "o") {
        Stop-Process -Name "node" -Force -ErrorAction SilentlyContinue
        Stop-Process -Name "npm" -Force -ErrorAction SilentlyContinue
        Stop-Process -Name "npx" -Force -ErrorAction SilentlyContinue
        Write-Host "Processus Node termines" -ForegroundColor Green
    }
} else {
    Write-Host "Aucun processus Node actif" -ForegroundColor Green
}

Write-Host ""

# Verifier processus Claude actifs
Write-Host "2. Verification des processus Claude..." -ForegroundColor Yellow
$claudeProcesses = Get-Process | Where-Object {$_.ProcessName -match "claude"} -ErrorAction SilentlyContinue

if ($claudeProcesses) {
    Write-Host "PROCESSUS CLAUDE DETECTES:" -ForegroundColor Red
    $claudeProcesses | Select-Object ProcessName, Id, CPU, WorkingSet | Format-Table
} else {
    Write-Host "Aucun processus Claude actif (normal si Desktop ferme)" -ForegroundColor Green
}

Write-Host ""

# Verifier dossier APPDATA recreated
Write-Host "3. Verification dossier APPDATA\Claude..." -ForegroundColor Yellow

if (Test-Path "$env:APPDATA\Claude") {
    $fileCount = (Get-ChildItem "$env:APPDATA\Claude" -Recurse -ErrorAction SilentlyContinue).Count
    $folderSize = (Get-ChildItem "$env:APPDATA\Claude" -Recurse -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum / 1MB

    Write-Host "DOSSIER APPDATA\Claude EXISTE:" -ForegroundColor Red
    Write-Host "   Nombre de fichiers: $fileCount" -ForegroundColor Yellow
    Write-Host "   Taille: $([math]::Round($folderSize, 2)) MB" -ForegroundColor Yellow

    if ($fileCount -gt 100) {
        Write-Host "ALERTE: Plus de 100 fichiers! Possible recurrence du probleme!" -ForegroundColor Red
        Write-Host "Voulez-vous supprimer ce dossier? (O/N)" -ForegroundColor Yellow
        $response = Read-Host
        if ($response -eq "O" -or $response -eq "o") {
            Remove-Item -Path "$env:APPDATA\Claude" -Recurse -Force
            Write-Host "Dossier supprime" -ForegroundColor Green
        }
    }
} else {
    Write-Host "Dossier APPDATA\Claude absent (normal apres nettoyage)" -ForegroundColor Green
}

Write-Host ""

# Verifier dossier LOCALAPPDATA
Write-Host "4. Verification dossier LOCALAPPDATA\Claude..." -ForegroundColor Yellow

if (Test-Path "$env:LOCALAPPDATA\Claude") {
    $fileCount = (Get-ChildItem "$env:LOCALAPPDATA\Claude" -Recurse -ErrorAction SilentlyContinue).Count
    Write-Host "DOSSIER LOCALAPPDATA\Claude EXISTE: $fileCount fichiers" -ForegroundColor Yellow
} else {
    Write-Host "Dossier LOCALAPPDATA\Claude absent" -ForegroundColor Green
}

Write-Host ""

# Verifier connexions reseau actives
Write-Host "5. Verification des connexions reseau actives..." -ForegroundColor Yellow

$connections = Get-NetTCPConnection | Where-Object {
    $_.State -eq "Established" -and ($_.RemotePort -in (443, 8080, 3000, 5173) -or $_.LocalPort -in (3000, 5173, 8080))
} -ErrorAction SilentlyContinue

if ($connections) {
    Write-Host "CONNEXIONS RESEAU ACTIVES DETECTEES:" -ForegroundColor Yellow
    $connections | Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort, State | Format-Table -AutoSize
} else {
    Write-Host "Aucune connexion suspecte" -ForegroundColor Green
}

Write-Host ""

# Verifier taches planifiees
Write-Host "6. Verification des taches planifiees Claude/MCP..." -ForegroundColor Yellow

$tasks = Get-ScheduledTask | Where-Object {$_.TaskName -match "Claude|MCP|node"} -ErrorAction SilentlyContinue

if ($tasks) {
    Write-Host "TACHES PLANIFIEES DETECTEES:" -ForegroundColor Red
    $tasks | Select-Object TaskName, State | Format-Table
} else {
    Write-Host "Aucune tache planifiee suspecte" -ForegroundColor Green
}

Write-Host ""

# Verifier services Windows
Write-Host "7. Verification des services Claude..." -ForegroundColor Yellow

$services = Get-Service | Where-Object {$_.DisplayName -match "Claude"} -ErrorAction SilentlyContinue

if ($services) {
    Write-Host "SERVICES CLAUDE DETECTES:" -ForegroundColor Yellow
    $services | Select-Object Name, Status, StartType | Format-Table
} else {
    Write-Host "Aucun service Claude actif" -ForegroundColor Green
}

Write-Host ""

# Verifier variables d'environnement
Write-Host "8. Verification des variables d'environnement..." -ForegroundColor Yellow

$envVars = Get-ChildItem Env: | Where-Object {$_.Name -match "Claude|MCP"} -ErrorAction SilentlyContinue

if ($envVars) {
    Write-Host "VARIABLES D'ENVIRONNEMENT DETECTEES:" -ForegroundColor Yellow
    $envVars | Format-Table Name, Value
} else {
    Write-Host "Aucune variable d'environnement polluee" -ForegroundColor Green
}

Write-Host ""

# Verifier PATH systeme
Write-Host "9. Verification du PATH systeme..." -ForegroundColor Yellow

$claudePath = $env:Path -split ';' | Where-Object {$_ -match "Claude"}

if ($claudePath) {
    Write-Host "ENTREES CLAUDE DANS PATH:" -ForegroundColor Yellow
    $claudePath | ForEach-Object { Write-Host "   $_" -ForegroundColor Yellow }
} else {
    Write-Host "PATH systeme propre" -ForegroundColor Green
}

Write-Host ""

# RESUME FINAL
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host "RESUME DU DIAGNOSTIC" -ForegroundColor Cyan
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host ""

$issues = @()

if ($nodeProcesses) { $issues += "Processus Node actifs" }
if (Test-Path "$env:APPDATA\Claude") {
    $count = (Get-ChildItem "$env:APPDATA\Claude" -Recurse -ErrorAction SilentlyContinue).Count
    if ($count -gt 100) {
        $issues += "APPDATA\Claude recree avec $count fichiers (ALERTE!)"
    } else {
        $issues += "APPDATA\Claude existe ($count fichiers)"
    }
}
if ($connections) { $issues += "Connexions reseau actives" }
if ($tasks) { $issues += "Taches planifiees suspectes" }

if ($issues.Count -eq 0) {
    Write-Host "SYSTEME PROPRE - Aucun probleme detecte" -ForegroundColor Green
    Write-Host ""
    Write-Host "Conclusion: Le probleme est probablement cote serveur Anthropic" -ForegroundColor Yellow
    Write-Host "Action recommandee: Contacter le support Anthropic avec les rapports" -ForegroundColor Yellow
} else {
    Write-Host "PROBLEMES DETECTES:" -ForegroundColor Red
    $issues | ForEach-Object { Write-Host "   - $_" -ForegroundColor Yellow }
    Write-Host ""
    Write-Host "Action recommandee: Nettoyage supplementaire necessaire" -ForegroundColor Red
    Write-Host "   Puis contacter le support Anthropic" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host "PROCHAINES ETAPES:" -ForegroundColor Cyan
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Copier les resultats de ce diagnostic" -ForegroundColor White
Write-Host "2. Lire: CORRELATION_INCIDENTS_MCP_COMPRESSION.md" -ForegroundColor White
Write-Host "3. Contacter support Anthropic:" -ForegroundColor White
Write-Host "   - Joindre BUG_REPORT_CLAUDE_DESKTOP.md" -ForegroundColor White
Write-Host "   - Joindre RESOLUTION_INSTABILITE_CPU.md" -ForegroundColor White
Write-Host "   - Joindre CORRELATION_INCIDENTS_MCP_COMPRESSION.md" -ForegroundColor White
Write-Host "   - Joindre resultats de ce diagnostic" -ForegroundColor White
Write-Host "   - Demander: Reset profil utilisateur serveur" -ForegroundColor White
Write-Host ""
Write-Host "4. En attendant: Utiliser UNIQUEMENT Claude Code (CLI)" -ForegroundColor White
Write-Host "   Ne PAS utiliser Desktop ou Web" -ForegroundColor White
Write-Host ""

$dateStr = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
Write-Host "Diagnostic termine - $dateStr" -ForegroundColor Cyan
