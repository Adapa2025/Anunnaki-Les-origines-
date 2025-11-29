# 🐛 Bug Report: Claude Desktop - Compression Inappropriée et Crash Système

**Date du rapport:** 29 novembre 2025
**Rapporté par:** Marc (Adapa2025)
**Plateforme affectée:** Claude Desktop
**Sévérité:** 🔴 CRITIQUE - Perte de fonctionnalité complète

---

## 📋 Résumé Exécutif

Claude Desktop présente un bug critique où des conversations courtes sont incorrectement évaluées comme "trop longues", déclenchant une compression inappropriée suivie d'un crash complet du système ("trou noir"). L'icône d'accès à Claude Code a également disparu de l'interface.

---

## 🔍 Symptômes Observés

### 1. **Évaluation Erronée de Longueur**
- ❌ Conversations courtes jugées "trop longues"
- ❌ Déclenchement inapproprié du mécanisme de compression
- ❌ Aucune logique apparente dans le seuil de déclenchement

### 2. **Compression Forcée**
- Les conversations sont compressées même si courtes
- Le processus de compression semble mal calibré
- Perte potentielle d'informations contextuelles importantes

### 3. **Crash Complet ("Trou Noir")**
- Après compression: crash système complet
- Interface devient non-réactive
- Perte totale d'accès à la conversation
- Comparaison utilisateur: "On se croirait revenu à Windows 3.11 avec les disquettes"

### 4. **Perte de l'Icône Claude Code**
- L'icône d'accès à Claude Code a disparu de Claude Desktop
- Perte d'accès à une fonctionnalité clé
- Impact sur le workflow développeur

---

## 🖥️ Environnement Technique

### Contexte Utilisateur
- **Utilisateur:** Développeur/Chercheur travaillant sur projet ADAPA
- **Projet actif:** Anunnaki-Les-origines (recueil de ressources)
- **Charge de travail:** Gestion de 260 PDFs structurés
- **Échéance projet:** 2027
- **Configuration récente:** MCP filesystem potentiellement configuré

### Système
- **Plateforme:** Claude Desktop (application native)
- **Date d'occurrence:** 29 novembre 2025, tôt le matin
- **Fréquence:** Récurrent, affecte plusieurs conversations

---

## 🔄 Étapes de Reproduction

### Scénario A: Compression Inappropriée
1. Ouvrir Claude Desktop
2. Démarrer une nouvelle conversation
3. Échanger quelques messages (conversation courte)
4. Observer: système juge conversation "trop longue"
5. Observer: compression forcée se déclenche
6. **Résultat:** Crash/Trou noir

### Scénario B: Perte d'Icône Claude Code
1. Ouvrir Claude Desktop
2. Chercher l'icône d'accès à Claude Code
3. **Résultat:** Icône manquante/inaccessible

---

## 💥 Impact Utilisateur

### Impact Immédiat
- ⛔ **Perte de productivité totale**
- ⛔ **Impossibilité de poursuivre le travail**
- ⛔ **Perte potentielle de données conversationnelles**
- ⛔ **Frustration extrême de l'utilisateur**

### Impact sur le Workflow
- Interruption du travail sur projet critique (ADAPA)
- Impossibilité d'accéder à Claude Code
- Nécessité de contournement via autres plateformes (claude.ai)
- Perte de confiance dans la stabilité du système

### Analogie Utilisateur (Significative)
> "On se croirait revenu à Windows 3.11 quand il fallait télécharger les programmes avec des disquettes!!!"

Cette comparaison indique:
- Régression perçue de qualité
- Instabilité inacceptable pour un outil professionnel
- Frustration comparable à des technologies obsolètes

---

## 🔬 Hypothèses Techniques

### Cause Possible #1: Bug du Mécanisme de Compression
- Seuil de déclenchement mal calibré
- Évaluation incorrecte de la longueur contextuelle
- Boucle infinie ou overflow dans le processus de compression

### Cause Possible #2: Conflit MCP Filesystem
- Configuration récente MCP pourrait interférer
- Problème de mémoire/ressources liées au filesystem
- Corruption de l'état conversationnel

### Cause Possible #3: Memory Leak
- Saturation progressive de la mémoire
- Déclenchement du GC au mauvais moment
- Crash lors de la libération de ressources

### Cause Possible #4: Bug Interface UI
- Corruption de l'état UI
- Disparition de l'icône Claude Code liée à un état UI corrompu
- Possible problème de rendering/repaint

---

## 🧪 Tests Comparatifs à Effectuer

- [ ] **Test sur claude.ai (web)** - À effectuer par Marc pour comparaison
- [ ] Test sans MCP filesystem activé
- [ ] Test avec conversation de longueur contrôlée
- [ ] Test de reproduction systématique

---

## 📊 Données de Diagnostic Souhaitées

Si Anthropic peut collecter:

1. **Logs système** au moment du crash
2. **Métriques de longueur** perçues vs réelles de la conversation
3. **État mémoire** avant/pendant/après compression
4. **Configuration MCP** active au moment du bug
5. **Stack trace** du crash
6. **État de l'interface UI** (pourquoi icône Claude Code disparaît)

---

## 🛠️ Solutions de Contournement Temporaires

### Pour Marc (Immédiat)
1. ✅ Utiliser Claude Code (CLI) - actuellement fonctionnel
2. ⏳ Tester claude.ai (web) pour comparer
3. 💾 Sauvegarder régulièrement les conversations importantes
4. 🔄 Potentiellement désactiver MCP filesystem temporairement

### Pour Anthropic (Correctif)
1. 🔧 Recalibrer le seuil de compression
2. 🔧 Ajouter des gardes-fous anti-crash
3. 🔧 Fixer la disparition de l'icône Claude Code
4. 🔧 Améliorer la gestion d'erreurs du processus de compression

---

## 📞 Informations de Contact

**Utilisateur:** Marc (Adapa2025)
**Contexte projet:** ADAPA - Compilation thématique, 260 PDFs, échéance 2027
**Branche Git actuelle:** `claude/fix-conversation-compression-01GsnG7J4Wt1smm6BGwRRsQ2`

---

## 📎 Pièces Jointes

- README.md du projet: `/home/user/Anunnaki-Les-origines-/README.md`
- Ce rapport: `BUG_REPORT_CLAUDE_DESKTOP.md`

---

## 🎯 Priorité et Urgence

**Priorité:** 🔴 P0 - Critique
**Urgence:** 🔴 Immédiate
**Justification:**
- Bloque complètement l'utilisateur
- Perte de fonctionnalité totale
- Impact sur projet professionnel avec échéance
- Régression majeure de l'expérience utilisateur

---

## 📝 Notes Additionnelles

- L'utilisateur est un utilisateur expérimenté (gestion de 260 PDFs, workflow git)
- Le timing "tôt le matin" pourrait indiquer un problème de charge serveur
- La métaphore "Windows 3.11" indique une frustration profonde et légitime
- L'utilisateur a déjà perdu accès à des fonctionnalités clés (icône Claude Code)

---

**Statut du rapport:** ✅ Prêt pour soumission à Anthropic
**Dernière mise à jour:** 29 novembre 2025
**Suivi:** En attente des résultats de tests sur claude.ai par Marc
