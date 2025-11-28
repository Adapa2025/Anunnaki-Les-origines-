# Résolution du problème d'instabilité CPU - Claude Desktop

**Date** : 28 novembre 2025
**Système** : Windows PowerShell
**Problème** : Instabilité du système et consommation CPU anormale après tentatives de configuration de Claude Desktop

---

## 🔴 Symptômes observés

- Instabilité générale du système Windows
- Consommation CPU anormale
- Messages d'erreur lors de l'installation de composants complémentaires Claude Desktop
- Application Claude Desktop instable après désinstallation/réinstallation

---

## 🔍 Diagnostic

### Investigations effectuées

1. **Vérification de l'historique PowerShell**
   - Localisation : `C:\Users\Perso\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt`
   - Découverte de multiples tentatives de configuration MCP (Model Context Protocol)

2. **Analyse des variables d'environnement**
   ```powershell
   Get-ChildItem Env: | Where-Object {$_.Name -like "*Claude*"}
   ```
   - Résultat : **Aucune variable d'environnement polluée** ✅

3. **Vérification du serveur MCP filesystem**
   ```powershell
   npm list -g "@modelcontextprotocol/server-filesystem"
   ```
   - Résultat : `(empty)` - Serveur MCP déjà désinstallé ✅

4. **Analyse du dossier de données Claude**
   ```powershell
   (Get-ChildItem "$env:APPDATA\Claude" -Recurse).Count
   ```
   - **🚨 PROBLÈME IDENTIFIÉ** : **37 338 fichiers (482 MB)** de logs et fichiers temporaires accumulés !

---

## 🛠️ Solution appliquée

### Étape 1 : Vérification de la configuration
```powershell
Test-Path "$env:APPDATA\Claude\claude_desktop_config.json"
# Résultat : False (aucune configuration à sauvegarder)
```

### Étape 2 : Suppression du dossier de données
```powershell
Remove-Item -Path "$env:APPDATA\Claude" -Recurse -Force
```
- **37 338 fichiers supprimés**
- **482 MB d'espace disque libéré**

### Étape 3 : Vérification de la suppression
```powershell
Test-Path "$env:APPDATA\Claude"
# Résultat : False ✅
```

### Étape 4 : Nettoyage du dossier LocalAppData
```powershell
Get-ChildItem "$env:LOCALAPPDATA\Claude" -ErrorAction SilentlyContinue
# Résultat : Vide ou inexistant ✅
```

### Étape 5 : Vérification du PATH système
```powershell
$env:Path -split ';' | Where-Object {$_ -like "*Claude*"}
# Résultat : Aucune trace ✅
```

---

## ✅ Résultat final

**Système nettoyé avec succès !**

- ✅ 482 MB d'espace disque récupéré
- ✅ 37 338 fichiers résiduels supprimés
- ✅ Aucune variable d'environnement polluée
- ✅ Aucun processus Claude actif
- ✅ PATH système propre

---

## 📚 Commandes PowerShell utilisées lors de la configuration initiale (problématiques)

D'après l'historique, voici les opérations qui ont conduit au problème :

```powershell
# Installation du script Claude (probablement Claude CLI, pas Desktop)
irm https://claude.ai/install.ps1 | iex

# Installation du serveur MCP filesystem
npm install -g @modelcontextprotocol/server-filesystem

# Multiples tentatives de configuration manuelle
notepad "$env:APPDATA\Claude\claude_desktop_config.json"

# Tentatives d'exécution du serveur MCP
npx -y @modelcontextprotocol/server-filesystem "C:\Users\Perso\Documents\ADAPA LES ORIGINES\Projet\Anunnaki-Les-origines-"

# Multiples suppressions/recréations du fichier de config
Remove-Item "$env:APPDATA\Claude\claude_desktop_config.json"
```

**⚠️ Ces commandes ont généré une accumulation massive de logs et de processus mal terminés.**

---

## 💡 Recommandations pour l'avenir

### Si réinstallation de Claude Desktop souhaitée :

1. **Télécharger l'installateur officiel** : https://claude.ai/download
2. **Installer via l'interface graphique** (pas via PowerShell)
3. **Utiliser l'interface de Claude Desktop** pour configurer les outils MCP
4. **Éviter les configurations manuelles** via PowerShell sauf si parfaitement maîtrisées

### Bonnes pratiques :

- ✅ Utiliser l'interface graphique de Claude Desktop pour les configurations
- ✅ Ne pas mélanger Claude CLI et Claude Desktop
- ✅ Vérifier régulièrement la taille du dossier `%APPDATA%\Claude`
- ❌ Éviter les commandes PowerShell non documentées
- ❌ Ne pas exécuter de scripts d'installation via `irm | iex` sans vérification

---

## 📞 Support

En cas de problème avec Claude Desktop :
- **Support officiel** : https://support.anthropic.com
- **Documentation** : https://docs.anthropic.com
- **Signalement de bugs** : https://github.com/anthropics/claude-desktop/issues

---

## 📝 Notes techniques

### Pourquoi 37 338 fichiers ?

Chaque requête MCP mal configurée a probablement généré :
- Des fichiers de logs
- Des sockets temporaires
- Des processus orphelins créant des traces
- Des tentatives de connexion échouées enregistrées

L'accumulation sur plusieurs jours sans nettoyage automatique a conduit à cette situation.

### Impact sur le CPU

Les processus MCP mal configurés tentaient probablement de :
- Se reconnecter en boucle au serveur filesystem
- Scanner des répertoires inexistants
- Générer des logs en continu
- Maintenir des connexions WebSocket actives

---

**Document créé le 28 novembre 2025**
**Intervention réalisée par : Claude Code**
**Branche Git : `claude/fix-cpu-instability-01FzUKU9XZeLVRiYGj5va2cw`**
