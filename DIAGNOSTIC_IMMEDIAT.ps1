# ⚠️ SCRIPT DE DIAGNOSTIC IMMÉDIAT - À EXÉCUTER MAINTENANT
# Date: 29 novembre 2025
# Objectif: Vérifier processus MCP résiduels et état système après incident

Write-Host "═══════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "🔍 DIAGNOSTIC IMMÉDIAT - Vérification Système" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

# ========================================
# 1. Vérifier processus Node/NPM actifs
# ========================================
Write-Host "1️⃣  Vérification des processus Node/NPM/NPX..." -ForegroundColor Yellow
$nodeProcesses = Get-Process | Where-Object {$_.ProcessName -match "node|npm|npx"} -ErrorAction SilentlyContinue

if ($nodeProcesses) {
    Write-Host "⚠️  PROCESSUS NODE DÉTECTÉS:" -ForegroundColor Red
    $nodeProcesses | Select-Object ProcessName, Id, CPU, WorkingSet | Format-Table

    Write-Host "❓ Voulez-vous terminer ces processus? (O/N)" -ForegroundColor Yellow
    $response = Read-Host
    if ($response -eq "O" -or $response -eq "o") {
        Stop-Process -Name "node" -Force -ErrorAction SilentlyContinue
        Stop-Process -Name "npm" -Force -ErrorAction SilentlyContinue
        Stop-Process -Name "npx" -Force -ErrorAction SilentlyContinue
        Write-Host "✅ Processus Node terminés" -ForegroundColor Green
    }
} else {
    Write-Host "✅ Aucun processus Node actif" -ForegroundColor Green
}

Write-Host ""

# ========================================
# 2. Vérifier processus Claude actifs
# ========================================
Write-Host "2️⃣  Vérification des processus Claude..." -ForegroundColor Yellow
$claudeProcesses = Get-Process | Where-Object {$_.ProcessName -match "claude"} -ErrorAction SilentlyContinue

if ($claudeProcesses) {
    Write-Host "⚠️  PROCESSUS CLAUDE DÉTECTÉS:" -ForegroundColor Red
    $claudeProcesses | Select-Object ProcessName, Id, CPU, WorkingSet | Format-Table
} else {
    Write-Host "✅ Aucun processus Claude actif (normal si Desktop fermé)" -ForegroundColor Green
}

Write-Host ""

# ========================================
# 3. Vérifier dossier APPDATA recreated
# ========================================
Write-Host "3️⃣  Vérification dossier APPDATA\Claude..." -ForegroundColor Yellow

if (Test-Path "$env:APPDATA\Claude") {
    $fileCount = (Get-ChildItem "$env:APPDATA\Claude" -Recurse -ErrorAction SilentlyContinue).Count
    $folderSize = (Get-ChildItem "$env:APPDATA\Claude" -Recurse -ErrorAction SilentlyContinue |
                   Measure-Object -Property Length -Sum).Sum / 1MB

    Write-Host "⚠️  DOSSIER APPDATA\Claude EXISTE:" -ForegroundColor Red
    Write-Host "   📁 Nombre de fichiers: $fileCount" -ForegroundColor Yellow
    Write-Host "   💾 Taille: $([math]::Round($folderSize, 2)) MB" -ForegroundColor Yellow

    if ($fileCount -gt 100) {
        Write-Host "🚨 ALERTE: Plus de 100 fichiers! Possible récurrence du problème!" -ForegroundColor Red
        Write-Host "❓ Voulez-vous supprimer ce dossier? (O/N)" -ForegroundColor Yellow
        $response = Read-Host
        if ($response -eq "O" -or $response -eq "o") {
            Remove-Item -Path "$env:APPDATA\Claude" -Recurse -Force
            Write-Host "✅ Dossier supprimé" -ForegroundColor Green
        }
    }
} else {
    Write-Host "✅ Dossier APPDATA\Claude absent (normal après nettoyage)" -ForegroundColor Green
}

Write-Host ""

# ========================================
# 4. Vérifier dossier LOCALAPPDATA
# ========================================
Write-Host "4️⃣  Vérification dossier LOCALAPPDATA\Claude..." -ForegroundColor Yellow

if (Test-Path "$env:LOCALAPPDATA\Claude") {
    $fileCount = (Get-ChildItem "$env:LOCALAPPDATA\Claude" -Recurse -ErrorAction SilentlyContinue).Count
    Write-Host "⚠️  DOSSIER LOCALAPPDATA\Claude EXISTE: $fileCount fichiers" -ForegroundColor Yellow
} else {
    Write-Host "✅ Dossier LOCALAPPDATA\Claude absent" -ForegroundColor Green
}

Write-Host ""

# ========================================
# 5. Vérifier connexions réseau actives
# ========================================
Write-Host "5️⃣  Vérification des connexions réseau actives..." -ForegroundColor Yellow

$connections = Get-NetTCPConnection | Where-Object {
    $_.State -eq "Established" -and
    ($_.RemotePort -in (443, 8080, 3000, 5173) -or $_.LocalPort -in (3000, 5173, 8080))
} -ErrorAction SilentlyContinue

if ($connections) {
    Write-Host "⚠️  CONNEXIONS RÉSEAU ACTIVES DÉTECTÉES:" -ForegroundColor Yellow
    $connections | Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort, State |
                  Format-Table -AutoSize
} else {
    Write-Host "✅ Aucune connexion suspecte" -ForegroundColor Green
}

Write-Host ""

# ========================================
# 6. Vérifier tâches planifiées
# ========================================
Write-Host "6️⃣  Vérification des tâches planifiées Claude/MCP..." -ForegroundColor Yellow

$tasks = Get-ScheduledTask | Where-Object {
    $_.TaskName -match "Claude|MCP|node"
} -ErrorAction SilentlyContinue

if ($tasks) {
    Write-Host "⚠️  TÂCHES PLANIFIÉES DÉTECTÉES:" -ForegroundColor Red
    $tasks | Select-Object TaskName, State | Format-Table
} else {
    Write-Host "✅ Aucune tâche planifiée suspecte" -ForegroundColor Green
}

Write-Host ""

# ========================================
# 7. Vérifier services Windows
# ========================================
Write-Host "7️⃣  Vérification des services Claude..." -ForegroundColor Yellow

$services = Get-Service | Where-Object {
    $_.DisplayName -match "Claude"
} -ErrorAction SilentlyContinue

if ($services) {
    Write-Host "⚠️  SERVICES CLAUDE DÉTECTÉS:" -ForegroundColor Yellow
    $services | Select-Object Name, Status, StartType | Format-Table
} else {
    Write-Host "✅ Aucun service Claude actif" -ForegroundColor Green
}

Write-Host ""

# ========================================
# 8. Vérifier variables d'environnement
# ========================================
Write-Host "8️⃣  Vérification des variables d'environnement..." -ForegroundColor Yellow

$envVars = Get-ChildItem Env: | Where-Object {
    $_.Name -match "Claude|MCP"
} -ErrorAction SilentlyContinue

if ($envVars) {
    Write-Host "⚠️  VARIABLES D'ENVIRONNEMENT DÉTECTÉES:" -ForegroundColor Yellow
    $envVars | Format-Table Name, Value
} else {
    Write-Host "✅ Aucune variable d'environnement polluée" -ForegroundColor Green
}

Write-Host ""

# ========================================
# 9. Vérifier PATH système
# ========================================
Write-Host "9️⃣  Vérification du PATH système..." -ForegroundColor Yellow

$claudePath = $env:Path -split ';' | Where-Object {$_ -match "Claude"}

if ($claudePath) {
    Write-Host "⚠️  ENTRÉES CLAUDE DANS PATH:" -ForegroundColor Yellow
    $claudePath | ForEach-Object { Write-Host "   $_" -ForegroundColor Yellow }
} else {
    Write-Host "✅ PATH système propre" -ForegroundColor Green
}

Write-Host ""

# ========================================
# RÉSUMÉ FINAL
# ========================================
Write-Host "═══════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "📊 RÉSUMÉ DU DIAGNOSTIC" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

$issues = @()

if ($nodeProcesses) { $issues += "Processus Node actifs" }
if (Test-Path "$env:APPDATA\Claude") {
    $count = (Get-ChildItem "$env:APPDATA\Claude" -Recurse -ErrorAction SilentlyContinue).Count
    if ($count -gt 100) {
        $issues += "APPDATA\Claude recréé avec $count fichiers (ALERTE!)"
    } else {
        $issues += "APPDATA\Claude existe ($count fichiers)"
    }
}
if ($connections) { $issues += "Connexions réseau actives" }
if ($tasks) { $issues += "Tâches planifiées suspectes" }

if ($issues.Count -eq 0) {
    Write-Host "✅ SYSTÈME PROPRE - Aucun problème détecté" -ForegroundColor Green
    Write-Host ""
    Write-Host "Conclusion: Le problème est probablement côté serveur Anthropic" -ForegroundColor Yellow
    Write-Host "Action recommandée: Contacter le support Anthropic avec les rapports" -ForegroundColor Yellow
} else {
    Write-Host "⚠️  PROBLÈMES DÉTECTÉS:" -ForegroundColor Red
    $issues | ForEach-Object { Write-Host "   • $_" -ForegroundColor Yellow }
    Write-Host ""
    Write-Host "🚨 Action recommandée: Nettoyage supplémentaire nécessaire" -ForegroundColor Red
    Write-Host "   Puis contacter le support Anthropic" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "═══════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "📝 PROCHAINES ÉTAPES:" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Copier les résultats de ce diagnostic" -ForegroundColor White
Write-Host "2. Lire: CORRELATION_INCIDENTS_MCP_COMPRESSION.md" -ForegroundColor White
Write-Host "3. Contacter support Anthropic:" -ForegroundColor White
Write-Host "   - Joindre BUG_REPORT_CLAUDE_DESKTOP.md" -ForegroundColor White
Write-Host "   - Joindre RESOLUTION_INSTABILITE_CPU.md" -ForegroundColor White
Write-Host "   - Joindre CORRELATION_INCIDENTS_MCP_COMPRESSION.md" -ForegroundColor White
Write-Host "   - Joindre résultats de ce diagnostic" -ForegroundColor White
Write-Host "   - Demander: Reset profil utilisateur serveur" -ForegroundColor White
Write-Host ""
Write-Host "4. En attendant: Utiliser UNIQUEMENT Claude Code (CLI)" -ForegroundColor White
Write-Host "   Ne PAS utiliser Desktop ou Web" -ForegroundColor White
Write-Host ""

Write-Host "Diagnostic terminé - $(Get-Date -Format 'dd/MM/yyyy HH:mm:ss')" -ForegroundColor Cyan
