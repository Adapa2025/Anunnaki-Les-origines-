# Ressources

Ce dossier contient toutes les ressources multimédia du projet.

## Structure

### 📄 Textes (`textes/`)

Placez ici tous les documents textuels :
- Traductions de textes anciens
- Articles et études
- Transcriptions
- Documents PDF

**Format recommandé** : Markdown (.md), PDF, TXT

### 🖼️ Images (`images/`)

Placez ici toutes les ressources visuelles :
- Photos de tablettes cunéiformes
- Artefacts archéologiques
- Cartes géographiques
- Schémas et illustrations
- Reproductions artistiques

**Formats acceptés** : JPG, PNG, SVG, WEBP

**Convention de nommage** :
```
[type]_[description]_[source].[ext]
Exemple : tablette_enuma-elish_british-museum.jpg
```

### 🎥 Vidéos (`videos/`)

Pour les ressources vidéo, nous recommandons de **ne pas stocker les fichiers vidéo** directement dans le dépôt (trop volumineux).

À la place, créez un fichier Markdown avec les liens :

**Exemple** : `videos/documentaires.md`
```markdown
# Documentaires

## [Titre du documentaire]
- **Lien** : [URL YouTube/Vimeo]
- **Durée** : XX min
- **Année** : 20XX
- **Description** : ...
- **Notes** : ...
```

## Bonnes pratiques

### Organisation

- Créez des sous-dossiers par thème si nécessaire
- Utilisez des noms de fichiers descriptifs
- Évitez les caractères spéciaux dans les noms

### Documentation

- Pour chaque ressource importante, ajoutez une description
- Indiquez toujours la source et les crédits
- Datez vos ajouts

### Droits d'auteur

- Respectez les droits d'auteur
- Privilégiez les ressources du domaine public
- Indiquez clairement les licences

## Exemple de structure

```
ressources/
├── textes/
│   ├── traductions/
│   │   └── enuma-elish-traduction-fr.md
│   └── articles/
│       └── etude-anunnaki-kramer.pdf
├── images/
│   ├── tablettes/
│   │   └── tablette_deluge_british-museum.jpg
│   └── cartes/
│       └── carte-mesopotamie-antique.png
└── videos/
    └── documentaires.md
```

---

*Consultez le README principal pour plus d'informations*
