# 📮 Comment Signaler ce Bug à Anthropic

## 🎯 Méthode Recommandée: GitHub Issues

Le meilleur moyen de signaler ce bug est via le repository officiel Claude Code:

### Étapes:

1. **Aller sur:** https://github.com/anthropics/claude-code/issues

2. **Cliquer sur:** "New Issue"

3. **Titre suggéré:**
   ```
   [CRITICAL] Claude Desktop: Inappropriate conversation compression causing crashes + Missing Claude Code icon
   ```

4. **Copier-coller le contenu de:** `BUG_REPORT_CLAUDE_DESKTOP.md`

5. **Ajouter le label:** `bug` (si disponible)

6. **Mentionner:**
   - Version de Claude Desktop utilisée
   - Système d'exploitation (Windows/Mac/Linux)
   - Résultats des tests sur claude.ai

---

## 📧 Méthode Alternative: Support Direct

Si tu préfères un contact direct:

1. **Email de support Anthropic:**
   - Chercher "Anthropic support" sur leur site officiel
   - Ou via les paramètres de Claude Desktop → "Help & Support"

2. **Inclure dans l'email:**
   - Objet: "BUG CRITIQUE - Compression inappropriée + Crash Desktop"
   - Pièce jointe: `BUG_REPORT_CLAUDE_DESKTOP.md`
   - Ton niveau de priorité (P0/Critique)

---

## 🔍 Informations Additionnelles à Ajouter

Quand tu soumets le bug, ajoute:

### A. Résultats de Test claude.ai
```
TESTS SUR CLAUDE.AI (web):
- [ ] Même problème de compression observé: OUI/NON
- [ ] Crash également présent: OUI/NON
- [ ] Icône Claude Code disponible: OUI/NON
- Conclusion: ___________
```

### B. Version de Claude Desktop
```
Version: [À vérifier dans Settings → About]
OS: [Windows 10/11, macOS, Linux + version]
Date d'installation: ___________
Dernière mise à jour: ___________
```

### C. Configuration MCP (si applicable)
```
MCP Filesystem configuré: OUI/NON
Autres MCP servers actifs: [Liste]
Fichier de config: [Emplacement]
```

### D. Captures d'Écran
Si possible, ajouter:
- Screenshot du crash/erreur
- Screenshot de l'interface montrant l'icône Claude Code manquante
- Screenshot du message de compression

---

## ⚡ Format de Soumission Rapide

Si tu veux faire vite, voici un template minimal:

```markdown
**BUG CRITIQUE: Claude Desktop - Crash après compression**

**Symptômes:**
- Conversations courtes jugées "trop longues"
- Compression forcée inappropriée
- Crash complet ("trou noir")
- Icône Claude Code disparue

**Impact:**
- Bloque totalement l'utilisation
- Perte de productivité complète
- Projet professionnel affecté

**Environnement:**
- Claude Desktop [VERSION]
- OS: [SYSTÈME]
- Date: 29 nov 2025

**Rapport complet:** [Attacher BUG_REPORT_CLAUDE_DESKTOP.md]

**Tests effectués:**
- claude.ai: [RÉSULTAT]
```

---

## 📋 Checklist Avant Soumission

- [ ] Test sur claude.ai effectué
- [ ] Version de Claude Desktop notée
- [ ] Screenshots capturés (si possible)
- [ ] Rapport BUG_REPORT_CLAUDE_DESKTOP.md prêt
- [ ] Configuration MCP documentée
- [ ] Titre clair et descriptif

---

## 🎯 Suivi du Bug

Une fois soumis:

1. **Noter le numéro d'issue/ticket**
2. **Surveiller les réponses** (GitHub notifications ou email)
3. **Fournir infos supplémentaires** si demandées
4. **Tester les correctifs** quand proposés

---

## 💡 En Attendant le Correctif

Solutions temporaires:

1. **Utiliser Claude Code (CLI)** ✅ Fonctionne actuellement
2. **Tester claude.ai (web)** ⏳ À vérifier
3. **Désactiver MCP temporairement** (si configuré)
4. **Sauvegarder conversations importantes** ailleurs

---

Bon courage Marc, et tiens-moi au courant des résultats de tes tests sur claude.ai!
