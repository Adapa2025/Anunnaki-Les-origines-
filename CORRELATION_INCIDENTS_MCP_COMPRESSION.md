# 🔗 Rapport de Corrélation: Incident MCP → Crashs Compression

**Date d'analyse:** 29 novembre 2025
**Analysé par:** Claude Code
**Incidents corrélés:** 2 incidents critiques à 24h d'intervalle

---

## 📅 Timeline des Événements

### Incident #1: Saturation MCP (28 nov 2025)
**Branche:** `claude/fix-cpu-instability-01FzUKU9XZeLVRiYGj5va2cw`
**Rapport:** `RESOLUTION_INSTABILITE_CPU.md`

**Symptômes:**
- 🚨 **37 338 fichiers (482 MB)** accumulés dans `%APPDATA%\Claude`
- 🚨 Processus MCP filesystem mal configurés
- 🚨 Boucles de reconnexion infinies
- 🚨 Génération de logs en continu
- 🚨 WebSockets actifs maintenant des connexions

**Cause racine:**
- Tentatives multiples de configuration MCP filesystem via PowerShell
- Pointage vers: `C:\Users\Perso\Documents\ADAPA LES ORIGINES\Projet\Anunnaki-Les-origines-`
- Processus mal terminés créant des processus orphelins
- Accumulation sans nettoyage automatique

**Solution appliquée:**
- ✅ Suppression complète `%APPDATA%\Claude` (37 338 fichiers, 482 MB)
- ✅ Vérification variables d'environnement
- ✅ Nettoyage PATH système
- ✅ Désinstallation serveur MCP npm

**Date résolution:** 28 novembre 2025

---

### Incident #2: Crashs Compression (29 nov 2025, tôt le matin)
**Branche:** `claude/fix-conversation-compression-01GsnG7J4Wt1smm6BGwRRsQ2`
**Rapport:** `BUG_REPORT_CLAUDE_DESKTOP.md`

**Symptômes:**
- ❌ Conversations **courtes** jugées "trop longues"
- ❌ Compression **inappropriée** déclenchée
- ❌ Crash complet ("trou noir") Desktop + Web
- ❌ Icône Claude Code disparue (Desktop)
- ✅ Claude Code (CLI) fonctionne normalement

**Tests effectués:**
- ❌ Claude Desktop: CRASH
- ❌ Claude.ai (Web): CRASH IDENTIQUE
- ✅ Claude Code (CLI): OK

**Date occurrence:** 29 novembre 2025, ~24h après résolution incident #1

---

## 🎯 Corrélation Établie

### ⚠️ DÉLAI: 24 heures entre incidents
### ⚠️ CONTEXTE: Même utilisateur, même projet (Anunnaki)
### ⚠️ SYMPTÔMES: Compression/CPU dans les deux cas

---

## 🔬 Hypothèses de Causalité (Priorisées)

### Hypothèse #1: État Serveur Corrompu (Compte Utilisateur)
**Probabilité: TRÈS ÉLEVÉE ⭐⭐⭐⭐⭐**

**Mécanisme proposé:**

1. **Phase 1 (28 nov):**
   - 37 338 fichiers MCP générés localement
   - Potentiellement **synchronisés/indexés** côté serveur Anthropic
   - État du profil utilisateur **massivement gonflé** côté serveur
   - Métadonnées de contexte **corrompues/surchargées**

2. **Phase 2 (28-29 nov, nuit):**
   - Nettoyage **local** effectué (✅ PC propre)
   - Mais **serveur Anthropic conserve** l'état corrompu
   - **Désynchronisation** client-serveur

3. **Phase 3 (29 nov, matin):**
   - Nouvelle conversation démarrée Desktop/Web
   - Serveur tente de **charger le contexte utilisateur**
   - Voit un contexte **énorme/corrompu** (résidus incident MCP)
   - **Déclenchement compression** (conversations jugées "trop longues")
   - Tentative de compresser état corrompu → **CRASH**

**Pourquoi CLI fonctionne:**
- CLI utilise possiblement un contexte/session **différent**
- Ou **pas de synchronisation** avec le profil utilisateur serveur Desktop/Web
- Ou **isolation** des sessions CLI vs Desktop/Web

**Indicateurs supportant cette hypothèse:**
- ✅ Crash identique Desktop + Web (partagent profil serveur)
- ✅ CLI non affecté (contexte différent)
- ✅ Timing: 24h après incident MCP
- ✅ "Conversations courtes = trop longues" (serveur voit contexte résiduel)
- ✅ Marc: "De nouveau un problème de CPU?" (pattern récurrent)

---

### Hypothèse #2: Processus MCP Résiduel Actif
**Probabilité: MOYENNE-ÉLEVÉE ⭐⭐⭐⭐**

**Mécanisme proposé:**

- Processus MCP **mal terminés** continuent de tourner
- Envoient des **données en continu** aux serveurs Anthropic
- Conversations Desktop/Web **surchargées** par flux MCP résiduel
- Serveur tente compression → crash par surcharge

**À vérifier sur le PC de Marc:**
```powershell
# Vérifier processus Node/NPM actifs
Get-Process | Where-Object {$_.ProcessName -like "*node*" -or $_.ProcessName -like "*npm*"}

# Vérifier connexions WebSocket actives
Get-NetTCPConnection | Where-Object {$_.State -eq "Established" -and $_.RemotePort -in (443, 8080, 3000)}

# Vérifier tâches planifiées Claude
Get-ScheduledTask | Where-Object {$_.TaskName -like "*Claude*"}
```

---

### Hypothèse #3: Rate Limiting / Flag Serveur
**Probabilité: MOYENNE ⭐⭐⭐**

**Mécanisme proposé:**

- L'activité anormale (37k fichiers, boucles MCP) a **flaggé le compte**
- Serveurs Anthropic appliquent **restrictions agressives**
- **Compression préventive** pour limiter ressources utilisateur
- **Timeouts réduits** → crash plus facile

**Impact:**
- Seuil de compression **drastiquement abaissé** pour ce compte
- Processus de compression **plus strict/moins tolérant**
- **Quota CPU/mémoire réduit** pour l'utilisateur

---

### Hypothèse #4: Corruption Cache/Session
**Probabilité: MOYENNE ⭐⭐⭐**

**Mécanisme proposé:**

- Nettoyage local effectué mais **cache serveur intact**
- État **incohérent** entre client (propre) et serveur (corrompu)
- Tentative de **synchronisation** au démarrage conversation
- **Conflit** lors de la synchro → crash compression

---

### Hypothèse #5: Bug Latent Révélé
**Probabilité: FAIBLE-MOYENNE ⭐⭐**

**Mécanisme proposé:**

- L'incident MCP a **révélé** un bug latent dans la compression
- Bug existait déjà mais non déclenché
- État spécifique créé par MCP = **trigger du bug**
- Bug affecte maintenant toutes les conversations de ce compte

---

## 🔍 Tests de Validation Urgents

### Test #1: Vérification Processus Résiduel (PC Marc)
**À exécuter sur Windows:**

```powershell
# Processus Node/NPM
Get-Process | Where-Object {$_.ProcessName -match "node|npm|npx"}

# Connexions réseau suspectes
Get-NetTCPConnection | Where-Object {$_.State -eq "Established"} |
  Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort, OwningProcess |
  Format-Table

# Services Claude actifs
Get-Service | Where-Object {$_.DisplayName -like "*Claude*"}

# Tâches planifiées
Get-ScheduledTask | Where-Object {$_.TaskName -match "Claude|MCP"}

# Vérifier si dossier APPDATA recreated
Test-Path "$env:APPDATA\Claude"
Get-ChildItem "$env:APPDATA\Claude" -Recurse -ErrorAction SilentlyContinue | Measure-Object
```

### Test #2: Nouveau Compte Utilisateur (Test Isolation)
**Si possible:**

- Créer un **nouveau compte Anthropic temporaire**
- Tester Desktop/Web avec ce nouveau compte
- Si **fonctionne normalement** → confirme hypothèse #1 (état serveur spécifique au compte)

### Test #3: Désactivation Complète Claude Desktop
**Sur PC Marc:**

1. Désinstaller complètement Claude Desktop
2. Vérifier processus/services/tâches planifiées
3. Tester uniquement via **claude.ai (web)** avec navigateur **mode incognito**
4. Si crash persiste → confirme problème serveur lié au compte

### Test #4: Clearing Server-Side Cache (Via Support Anthropic)
**Demander à Anthropic:**

- Réinitialisation complète du profil utilisateur serveur
- Clearing des métadonnées de contexte
- Reset des quotas/limits potentiellement appliqués

---

## 🎯 Actions Correctives Recommandées

### Actions Immédiates (Marc)

#### 1. Vérifier Processus Résiduel
```powershell
# Copier-coller dans PowerShell (Admin)
Get-Process | Where-Object {$_.ProcessName -match "node|npm|npx|claude"}
```

**Si processus trouvés:**
```powershell
Stop-Process -Name "node" -Force -ErrorAction SilentlyContinue
Stop-Process -Name "Claude" -Force -ErrorAction SilentlyContinue
```

#### 2. Vérifier Recréation Dossier APPDATA
```powershell
if (Test-Path "$env:APPDATA\Claude") {
    $count = (Get-ChildItem "$env:APPDATA\Claude" -Recurse).Count
    Write-Host "⚠️ APPDATA\Claude recreated: $count fichiers"
    # Si > 100 fichiers → problème récurrent!
} else {
    Write-Host "✅ APPDATA\Claude absent (normal)"
}
```

#### 3. Désinstaller/Réinstaller Claude Desktop (Clean Install)
```powershell
# Désinstaller via Paramètres Windows
# Puis vérifier nettoyage complet
Remove-Item "$env:APPDATA\Claude" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$env:LOCALAPPDATA\Claude" -Recurse -Force -ErrorAction SilentlyContinue

# Réinstaller depuis: https://claude.ai/download
```

#### 4. Contacter Support Anthropic URGEMMENT
**Email/Ticket support avec:**

- Lien vers `BUG_REPORT_CLAUDE_DESKTOP.md`
- Lien vers `RESOLUTION_INSTABILITE_CPU.md`
- Lien vers ce rapport de corrélation
- **Demander:** Reset complet du profil utilisateur serveur
- **Demander:** Vérification logs serveur pour le compte (28-29 nov)

---

### Actions Anthropic (Requises)

#### Priorité P0 - Immédiat:
1. **Investiguer le compte utilisateur Marc (Adapa2025)**
   - Vérifier état du profil serveur
   - Vérifier métadonnées de contexte
   - Vérifier logs d'activité 28-29 nov
   - Identifier corruption potentielle

2. **Reset profil utilisateur si nécessaire**
   - Clearing cache serveur
   - Reset métadonnées contextuelles
   - Réinitialisation quotas/limits

3. **Investiguer interaction MCP ↔ Compression**
   - Le système de compression gère-t-il correctement les états MCP corrompus?
   - Y a-t-il un mécanisme de recovery/fallback?
   - Les processus MCP mal terminés créent-ils des états persistants serveur?

#### Priorité P1 - Court Terme:
4. **Améliorer gestion erreurs MCP**
   - Timeout sur processus MCP mal configurés
   - Auto-cleanup des états orphelins
   - Limite sur taille métadonnées contextuelles

5. **Ajouter monitoring états utilisateur anormaux**
   - Alerting si contexte > seuil (ex: 100 MB métadonnées)
   - Detection de patterns anormaux (37k fichiers!)
   - Auto-cleanup ou notification utilisateur

6. **Circuit breaker pour compression**
   - Si compression échoue 3x → fail gracefully
   - Message utilisateur explicite (pas "trou noir")
   - Option "reset conversation context"

---

## 📊 Métriques à Collecter (Anthropic)

### Pour le compte Marc (Adapa2025):

1. **Taille du contexte utilisateur serveur**
   - Métadonnées stockées
   - Historique conversations
   - État MCP/filesystem

2. **Logs d'activité 28-29 nov 2025**
   - Requêtes MCP effectuées
   - Tentatives de compression
   - Erreurs/exceptions

3. **État actuel du profil**
   - Flags/restrictions appliqués
   - Quotas CPU/mémoire
   - Rate limits actifs

4. **Comparaison avec profil "normal"**
   - Taille contexte moyenne vs Marc
   - Activité MCP moyenne vs Marc
   - Identifier anomalies

---

## 🎯 Diagnostic Final

### Conclusion Principale:

**Les deux incidents sont TRÈS PROBABLEMENT liés.**

**Scénario le plus probable:**

1. ✅ **28 nov:** Processus MCP mal configurés créent 37k fichiers + état serveur massif/corrompu
2. ✅ **28 nov soir:** Nettoyage local effectué, mais **état serveur persiste**
3. ✅ **29 nov matin:** Nouvelle conversation → serveur charge contexte corrompu → compression déclenchée → crash
4. ✅ **Pattern récurrent:** Marc a déjà eu incidents CPU similaires (branche existante)

**Ce n'est probablement PAS un bug Anthropic global**, mais un **état corrompu spécifique au compte Marc** causé par l'incident MCP.

---

## ✅ Actions Prioritaires MAINTENANT

### Pour Marc:
1. 🚨 Exécuter tests de vérification processus résiduel
2. 🚨 Contacter support Anthropic avec rapports complets
3. 🚨 Demander reset profil utilisateur serveur
4. 💾 Continuer travail ADAPA uniquement via CLI
5. ⏸️ NE PAS utiliser Desktop/Web jusqu'à résolution

### Pour Anthropic (via support):
1. 🚨 Investiguer compte Adapa2025 URGEMMENT
2. 🚨 Vérifier/reset état serveur profil utilisateur
3. 🚨 Analyser logs 28-29 nov pour ce compte
4. 🔧 Implémenter circuit breaker compression
5. 🔧 Améliorer gestion états MCP corrompus

---

**Rapport créé:** 29 novembre 2025
**Branche:** `claude/fix-conversation-compression-01GsnG7J4Wt1smm6BGwRRsQ2`
**Rapports liés:**
- `BUG_REPORT_CLAUDE_DESKTOP.md` (cette branche)
- `RESOLUTION_INSTABILITE_CPU.md` (branche `claude/fix-cpu-instability-01FzUKU9XZeLVRiYGj5va2cw`)

**Niveau de priorité:** 🔴 P0 - CRITIQUE - État compte utilisateur potentiellement corrompu
