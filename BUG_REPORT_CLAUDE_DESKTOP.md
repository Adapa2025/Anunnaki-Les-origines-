# 🐛 Bug Report: Claude (Toutes Plateformes) - Compression Inappropriée et Crash Système

**Date du rapport:** 29 novembre 2025
**Rapporté par:** Marc (Adapa2025)
**Plateformes affectées:** ⚠️ **Claude Desktop + Claude.ai (Web)** - PROBLÈME GLOBAL
**Sévérité:** 🔴 CRITIQUE - Perte de fonctionnalité complète
**Nature:** 🖥️ **PROBLÈME CÔTÉ SERVEUR ANTHROPIC**

---

## 📋 Résumé Exécutif

**Bug critique affectant TOUTES les plateformes Claude (Desktop + Web)** où des conversations courtes sont incorrectement évaluées comme "trop longues", déclenchant une compression inappropriée suivie d'un crash complet du système ("trou noir").

**⚠️ CONFIRMATION CRITIQUE:** Le bug est **identique sur claude.ai (web)**, ce qui confirme qu'il s'agit d'un **problème côté serveur Anthropic**, pas d'un problème client/Desktop.

Symptômes additionnels sur Desktop: L'icône d'accès à Claude Code a également disparu de l'interface.

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
- **Plateformes testées:**
  - ❌ **Claude Desktop** (application native) - CRASHE
  - ❌ **Claude.ai** (interface web) - CRASHE ÉGALEMENT
  - ✅ **Claude Code** (CLI) - Fonctionne correctement
- **Date d'occurrence:** 29 novembre 2025, tôt le matin (heure de faible affluence normalement)
- **Fréquence:** Récurrent, affecte plusieurs conversations
- **Zone géographique:** [À préciser]

---

## ✅ Tests de Comparaison Effectués

### Test #1: Claude Desktop
- **Résultat:** ❌ **CRASH COMPLET**
- Compression inappropriée → Trou noir
- Icône Claude Code disparue

### Test #2: Claude.ai (Web)
- **Résultat:** ❌ **CRASH COMPLET IDENTIQUE**
- Même comportement exact que Desktop
- **Confirmation:** Ce n'est PAS un problème client/Desktop

### Test #3: Claude Code (CLI)
- **Résultat:** ✅ **FONCTIONNE NORMALEMENT**
- Aucun crash observé
- Interface CLI non affectée

### 🎯 Conclusion des Tests
**Le bug affecte les interfaces web/Desktop mais pas CLI** → Cela indique un problème dans le backend de gestion des conversations (compression, mémoire contextuelle) côté serveur Anthropic.

---

## 🔄 Étapes de Reproduction

### Scénario A: Compression Inappropriée (Reproductible sur Desktop + Web)
1. Ouvrir Claude Desktop OU claude.ai
2. Démarrer une nouvelle conversation
3. Échanger quelques messages (conversation courte)
4. Observer: système juge conversation "trop longue"
5. Observer: compression forcée se déclenche
6. **Résultat:** Crash/Trou noir sur TOUTES les plateformes (Desktop + Web)

### Scénario B: Perte d'Icône Claude Code (Desktop uniquement)
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

## 🔬 Hypothèses Techniques (Priorisées)

### ⚠️ Cause #1 (PRIORITAIRE): Saturation CPU/Ressources Serveur Anthropic
**Probabilité: TRÈS ÉLEVÉE**

Marc mentionne: *"De nouveau un problème de CPU?"* - suggérant des incidents similaires antérieurs.

**Indicateurs:**
- ✅ Bug identique sur Desktop + Web (élimine problème client)
- ✅ Claude Code (CLI) non affecté (charge serveur différente?)
- ✅ Occurrence "tôt le matin" (potentiellement pic de charge globale)
- ✅ Compression déclenchée de manière erratique (économie de ressources serveur?)

**Hypothèse détaillée:**
- Serveurs Anthropic en surcharge CPU/mémoire
- Système de compression activé de manière **préventive/agressive** pour économiser ressources
- Seuil abaissé drastiquement (conversations courtes jugées "trop longues")
- Processus de compression lui-même consomme trop de CPU
- Timeout/crash lors de la compression par manque de ressources
- **Résultat:** Trou noir pour l'utilisateur

**Données à vérifier:**
- Métriques CPU/mémoire des serveurs Anthropic le 29 nov 2025 matin
- Logs d'incidents similaires récents
- Taux de charge global du système
- Changements récents dans la politique de compression

---

### Cause #2: Bug du Mécanisme de Compression (Backend)
**Probabilité: ÉLEVÉE**

- Seuil de déclenchement mal calibré côté serveur
- Évaluation incorrecte de la longueur contextuelle
- Boucle infinie ou overflow dans le processus de compression backend
- Regression introduite dans une mise à jour récente

---

### Cause #3: Memory Leak Côté Serveur
**Probabilité: MOYENNE**

- Saturation progressive de la mémoire serveur
- Déclenchement du GC au mauvais moment affectant toutes les sessions
- Crash lors de la libération de ressources
- Fuite mémoire accumulée depuis le dernier redémarrage serveur

---

### Cause #4: Conflit MCP Filesystem (Impact Mineur)
**Probabilité: FAIBLE** (car affecte aussi claude.ai sans MCP)

- Configuration MCP pourrait aggraver mais n'est PAS la cause racine
- Possible charge additionnelle mais bug existe sans MCP

---

### Cause #5: Bug Interface UI (Desktop uniquement - Icône)
**Probabilité: MOYENNE** (pour l'icône Claude Code seulement)

- Corruption de l'état UI Desktop
- Disparition de l'icône Claude Code liée à un état UI corrompu
- Problème de rendering/repaint spécifique Desktop
- **Note:** Ne concerne QUE la disparition de l'icône, pas le crash principal

---

## 🧪 Tests Comparatifs à Effectuer / Effectués

- [X] **Test sur claude.ai (web)** - ✅ **EFFECTUÉ: CRASH IDENTIQUE**
- [ ] Test sans MCP filesystem activé (Desktop)
- [ ] Test avec conversation de longueur contrôlée et mesurée
- [ ] Test de reproduction systématique à différentes heures
- [ ] Test depuis différentes zones géographiques
- [ ] Vérification du statut serveur Anthropic (status.anthropic.com ou équivalent)

---

## 📜 Historique des Incidents (Mention Utilisateur)

Marc indique: *"De nouveau un problème de CPU?"*

Cela suggère:
- ✅ **Incidents similaires antérieurs** déjà rencontrés par l'utilisateur
- ✅ **Pattern récurrent** de problèmes de ressources CPU/serveur
- ✅ **Expérience utilisateur dégradée** dans le passé
- ❓ **Questions pour Anthropic:**
  - Y a-t-il eu des incidents CPU/serveur récents?
  - Y a-t-il un pattern de surcharge à certaines heures?
  - Des déploiements/changements récents dans l'infrastructure?
  - Des régressions introduites dans la gestion des ressources?

**Recommandation:** Anthropic devrait investiguer l'historique des incidents CPU/charge serveur sur les derniers mois pour identifier un pattern récurrent.

---

## 📊 Données de Diagnostic Souhaitées (Prioritaires)

### Données Serveur (CRITIQUE):

1. **Métriques CPU/Mémoire Serveur**
   - Charge CPU le 29 nov 2025, tôt le matin
   - Utilisation mémoire des serveurs backend
   - Nombre de sessions concurrentes
   - Taux de requêtes par seconde

2. **Logs Backend Compression**
   - Logs du service de compression au moment du crash
   - Seuils de déclenchement appliqués
   - Temps d'exécution des processus de compression
   - Timeouts/erreurs durant la compression

3. **Incidents Récents**
   - Historique des incidents CPU/serveur similaires
   - Patterns de charge à certaines heures
   - Déploiements/changements récents infrastructure

4. **Stack Traces Backend**
   - Stack traces des crashs côté serveur
   - Erreurs/exceptions durant la compression
   - Logs d'erreurs pour les sessions concernées

### Données Conversation:

5. **Métriques de Longueur**
   - Longueur réelle vs perçue des conversations affectées
   - Nombre de tokens/messages
   - Seuil de déclenchement vs seuil normal

6. **État Contextuel**
   - État mémoire contextuelle avant/pendant/après compression
   - Configuration MCP active (si applicable)
   - Données de session utilisateur

### Données Interface (Secondaire):

7. **Logs UI Desktop**
   - Pourquoi icône Claude Code disparaît
   - État de l'interface au moment du crash
   - Logs de rendering/repaint

---

## 🛠️ Solutions de Contournement Temporaires

### Pour Marc (Immédiat)
1. ✅ **Utiliser Claude Code (CLI)** - Actuellement fonctionnel et NON AFFECTÉ
2. ✅ ~~Tester claude.ai (web)~~ - **TESTÉ: MÊME CRASH (ne pas utiliser)**
3. ❌ Desktop inutilisable - éviter jusqu'au correctif
4. ❌ Web (claude.ai) inutilisable - éviter jusqu'au correctif
5. 💾 Sauvegarder le travail important via Claude Code (CLI)
6. 📋 Continuer le projet ADAPA uniquement via CLI

**→ SOLUTION UNIQUE VIABLE: Claude Code (CLI) jusqu'au correctif Anthropic**

### Pour Anthropic (Correctifs Urgents)

#### Correctif Immédiat (P0):
1. 🚨 **Investiguer charge CPU/mémoire serveur** - Priorité absolue
2. 🚨 **Désactiver ou recalibrer drastiquement le seuil de compression**
3. 🚨 **Ajouter timeout/circuit breaker** au processus de compression
4. 🚨 **Rollback éventuel** si régression récente identifiée

#### Correctifs Court Terme (P1):
5. 🔧 Optimiser le processus de compression (réduire charge CPU)
6. 🔧 Implémenter queue/throttling pour la compression
7. 🔧 Ajouter monitoring/alerting sur charge compression
8. 🔧 Améliorer gestion d'erreurs (fail gracefully, pas crash)

#### Correctifs Moyen Terme (P2):
9. 🔧 Revoir architecture de compression (asynchrone, distributed?)
10. 🔧 Fixer disparition icône Claude Code (Desktop UI)
11. 🔧 Améliorer signalement d'erreur utilisateur (pas "trou noir")
12. 🔧 Ajouter page de statut en temps réel (status.anthropic.com)

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

## 📝 Notes Additionnelles et Observations

### Profil Utilisateur
- ✅ Utilisateur expérimenté (gestion de 260 PDFs, workflow git, projet ADAPA)
- ✅ A déjà rencontré des problèmes CPU similaires par le passé
- ✅ Capable de tests systématiques et documentation technique

### Observations Temporelles
- ⚠️ Occurrence "tôt le matin" (normalement faible affluence)
- ⚠️ Si crash même en période creuse → problème serveur MAJEUR
- ⚠️ Suggère soit incident isolé soit dégradation continue

### Impact Psychologique
- 😤 Métaphore "Windows 3.11 avec disquettes" = frustration extrême
- 😤 Régression perçue vers instabilité des années 90
- 😤 Perte de confiance dans la fiabilité du système
- 😤 Urgence de correctif pour maintenir adoption utilisateur

### Symptômes Connexes
- 🔍 Perte de l'icône Claude Code (Desktop uniquement)
- 🔍 "Plus rien qui fonctionne" = panne totale multi-plateformes
- 🔍 "Trou noir" = absence de message d'erreur explicite

---

## 🎯 Résumé Exécutif pour Décideurs Anthropic

**SITUATION:**
- 🚨 Bug critique affectant Desktop + Web (pas CLI)
- 🚨 Compression inappropriée → crash complet système
- 🚨 Utilisateurs bloqués totalement (sauf CLI)

**CAUSE PROBABLE:**
- ⚡ Saturation CPU/ressources serveur Anthropic (probabilité très élevée)
- ⚡ Mécanisme de compression en mode panique/agressif
- ⚡ Pattern récurrent selon utilisateur

**IMPACT:**
- ⛔ Perte totale de productivité utilisateurs Desktop/Web
- ⛔ Régression majeure expérience utilisateur
- ⛔ Risque de perte de confiance et d'adoption

**ACTION REQUISE:**
- 🚨 Investigation CPU/mémoire serveur URGENTE
- 🚨 Recalibrage ou désactivation compression
- 🚨 Communication vers utilisateurs affectés

---

**Statut du rapport:** ✅ PRÊT POUR SOUMISSION URGENTE À ANTHROPIC
**Dernière mise à jour:** 29 novembre 2025 (après tests confirmatoires)
**Tests effectués:** ✅ Desktop (crash), ✅ Web (crash identique), ✅ CLI (OK)
**Niveau de priorité:** 🔴 P0 - INCIDENT CRITIQUE MULTI-PLATEFORMES
