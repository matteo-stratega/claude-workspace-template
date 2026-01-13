#!/bin/bash

# ============================================
# CLAUDE CODE - SETUP AUTOMATICO
# ============================================
# Esegui questo script per configurare tutto
# automaticamente. Non serve essere tecnici!
# ============================================

echo ""
echo "=========================================="
echo "   CLAUDE CODE - SETUP AUTOMATICO"
echo "=========================================="
echo ""

# Chiedi il nome del progetto
read -p "Come vuoi chiamare il tuo progetto? (es: lavoro, progetti, notes): " PROJECT_NAME

# Usa un nome di default se vuoto
if [ -z "$PROJECT_NAME" ]; then
    PROJECT_NAME="mio-progetto"
fi

# Rimuovi spazi e caratteri speciali
PROJECT_NAME=$(echo "$PROJECT_NAME" | tr ' ' '-' | tr -cd '[:alnum:]-')

echo ""
echo "Creo il progetto '$PROJECT_NAME'..."
echo ""

# Crea la cartella principale
mkdir -p "$HOME/$PROJECT_NAME"
cd "$HOME/$PROJECT_NAME"

# Inizializza git
git init --quiet

# Crea struttura cartelle
mkdir -p brain
mkdir -p notes/daily-summaries
mkdir -p docs
mkdir -p .claude/commands

# ============================================
# CREA CLAUDE.md
# ============================================
cat > CLAUDE.md << 'EOF'
# CLAUDE.md

Istruzioni per Claude Code in questo progetto.

## Startup Protocol

All'avvio di ogni sessione:
1. Leggi `brain/context.md` per capire lo stato corrente
2. Leggi l'ultimo closing report in `notes/daily-summaries/` (se esiste)
3. Proponi le priorita e chiedi conferma

## Comandi

- `/start` - Inizia sessione di lavoro
- `/close` - Chiudi sessione con report

## Regole Generali

1. **Non inventare dati** - Se non sai qualcosa, chiedi
2. **Rispetta la struttura cartelle** - Ogni file al suo posto
3. **Esegui in autonomia** - Chiedi solo se mancano info critiche
4. **Sii conciso** - Risposte brevi e actionable
5. **Aggiorna context.md** - Mantieni lo stato aggiornato

## Struttura Progetto

- `brain/` - Stato e contesto persistente
- `notes/` - Note e appunti
- `docs/` - Documenti finali
- `.claude/commands/` - Comandi custom

## Stile Output

- Usa markdown per formattare
- Bullet points per liste
- Niente emoji (a meno che non richiesto)
- Vai dritto al punto
EOF

# ============================================
# CREA brain/context.md
# ============================================
cat > brain/context.md << 'EOF'
# Context File

**Last Updated:** [DATA]

---

## Focus Corrente

### Questa Settimana
- [ ] Task 1
- [ ] Task 2
- [ ] Task 3

---

## Progetti Attivi

| Progetto | Status | Note |
|----------|--------|------|
| | | |

---

## Decisioni Chiave

| Data | Decisione | Motivazione |
|------|-----------|-------------|
| | | |

---

## Prossime Azioni

1.
2.
3.

---

*Aggiornare questo file a fine sessione*
EOF

# ============================================
# CREA .claude/commands/start.md
# ============================================
cat > .claude/commands/start.md << 'EOF'
# Session Start

Esegui il protocollo di inizio sessione:

## Step 1: Load Context
1. Leggi `brain/context.md` per lo stato corrente
2. Leggi l'ultimo file `notes/daily-summaries/closing-*.md` (se esiste)

## Step 2: Propose
Riassumi in max 5 bullet points:
- Cosa e' stato fatto nell'ultima sessione (se c'e' un closing)
- Cosa e' pending
- Focus corrente da context

Poi chiedi: **"Confermi queste priorita' o cambiamo?"**

## Step 3: STOP
**Aspetta risposta prima di procedere.**
EOF

# ============================================
# CREA .claude/commands/close.md
# ============================================
cat > .claude/commands/close.md << 'EOF'
# Session Close

Esegui il protocollo di chiusura:

1. **Scrivi closing report** in `notes/daily-summaries/closing-DDMMYYYY.md`:

```
# Closing [DATA]

## TL;DR
- **Done**: [cosa completato oggi]
- **Pending**: [cosa rimane da fare]
- **Next**: [prossima azione prioritaria]

## Files Created/Modified
[lista file]

---
**Session Status**: Completed
```

2. **Aggiorna brain/context.md** se ci sono cambi significativi

3. **Conferma** all'utente: "Sessione chiusa. Report salvato."
EOF

# ============================================
# CREA .gitignore
# ============================================
cat > .gitignore << 'EOF'
.DS_Store
Thumbs.db
*.swp
*~
node_modules/
.credentials/
*.pem
*.key
.env
.env.local
.claude/settings.local.json
EOF

# Primo commit
git add -A
git commit -m "Setup iniziale progetto" --quiet

# ============================================
# FINE!
# ============================================
echo ""
echo "=========================================="
echo "   SETUP COMPLETATO!"
echo "=========================================="
echo ""
echo "Il tuo progetto e' stato creato in:"
echo "   $HOME/$PROJECT_NAME"
echo ""
echo "Per iniziare:"
echo ""
echo "   1. Apri il terminale"
echo "   2. Scrivi: cd $HOME/$PROJECT_NAME"
echo "   3. Scrivi: claude"
echo "   4. Scrivi: /start"
echo ""
echo "=========================================="
echo ""
