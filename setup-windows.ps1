# ============================================
# CLAUDE CODE - SETUP AUTOMATICO WINDOWS
# ============================================
# Click destro -> Esegui con PowerShell
# ============================================

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "   CLAUDE CODE - SETUP AUTOMATICO" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# Chiedi nome progetto
$ProjectName = Read-Host "Come vuoi chiamare il tuo progetto? (es: lavoro)"

if ([string]::IsNullOrWhiteSpace($ProjectName)) {
    $ProjectName = "workspace"
}

# Pulisci nome
$ProjectName = $ProjectName -replace '[^a-zA-Z0-9-]', ''

$ProjectPath = "$env:USERPROFILE\Documents\$ProjectName"

Write-Host ""
Write-Host "Creo il progetto in: $ProjectPath" -ForegroundColor Yellow
Write-Host ""

# Crea struttura
New-Item -ItemType Directory -Force -Path "$ProjectPath\brain" | Out-Null
New-Item -ItemType Directory -Force -Path "$ProjectPath\notes\daily-summaries" | Out-Null
New-Item -ItemType Directory -Force -Path "$ProjectPath\docs" | Out-Null
New-Item -ItemType Directory -Force -Path "$ProjectPath\.claude\commands" | Out-Null

# CLAUDE.md
@"
# CLAUDE.md

Istruzioni per Claude Code in questo progetto.

## Startup Protocol

All'avvio di ogni sessione:
1. Leggi brain/context.md per capire lo stato corrente
2. Leggi l'ultimo closing report in notes/daily-summaries/ (se esiste)
3. Proponi le priorita e chiedi conferma

## Comandi

- /start - Inizia sessione di lavoro
- /close - Chiudi sessione con report

## Regole

1. Non inventare dati - Se non sai qualcosa, chiedi
2. Rispetta la struttura cartelle
3. Sii conciso - Risposte brevi
4. Aggiorna context.md a fine sessione

## Struttura

- brain/ - Stato e contesto
- notes/ - Appunti e note
- docs/ - Documenti finali
"@ | Out-File -FilePath "$ProjectPath\CLAUDE.md" -Encoding UTF8

# context.md
@"
# Context File

**Last Updated:** $(Get-Date -Format "dd/MM/yyyy")

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

## Prossime Azioni

1.
2.
3.

---

*Aggiornare questo file a fine sessione*
"@ | Out-File -FilePath "$ProjectPath\brain\context.md" -Encoding UTF8

# start.md
@"
# Session Start

Esegui il protocollo di inizio sessione:

## Step 1: Load Context
1. Leggi brain/context.md
2. Leggi ultimo file notes/daily-summaries/closing-*.md

## Step 2: Propose
Riassumi in max 5 bullet:
- Cosa fatto ultima sessione
- Cosa pending
- Focus corrente

Poi chiedi: "Confermi queste priorita o cambiamo?"

## Step 3: STOP
Aspetta risposta prima di procedere.
"@ | Out-File -FilePath "$ProjectPath\.claude\commands\start.md" -Encoding UTF8

# close.md
@"
# Session Close

1. Scrivi closing report in notes/daily-summaries/closing-DDMMYYYY.md

Formato:
# Closing [DATA]

## TL;DR
- Done: [completato]
- Pending: [da fare]
- Next: [prossima azione]

## Files Modified
[lista]

---
Session Status: Completed

2. Aggiorna brain/context.md se necessario

3. Conferma: "Sessione chiusa. Report salvato."
"@ | Out-File -FilePath "$ProjectPath\.claude\commands\close.md" -Encoding UTF8

# .gitignore
@"
.DS_Store
Thumbs.db
*.swp
node_modules/
.env
"@ | Out-File -FilePath "$ProjectPath\.gitignore" -Encoding UTF8

# Inizializza git se disponibile
$gitExists = Get-Command git -ErrorAction SilentlyContinue
if ($gitExists) {
    Set-Location $ProjectPath
    git init --quiet
    git add -A
    git commit -m "Setup iniziale" --quiet
    Write-Host "Git inizializzato!" -ForegroundColor Green
}

Write-Host ""
Write-Host "==========================================" -ForegroundColor Green
Write-Host "   SETUP COMPLETATO!" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Il progetto e' in: $ProjectPath" -ForegroundColor Yellow
Write-Host ""
Write-Host "Per iniziare:" -ForegroundColor Cyan
Write-Host ""
Write-Host "   1. Apri un nuovo terminale (cmd)"
Write-Host "   2. cd $ProjectPath"
Write-Host "   3. claude"
Write-Host "   4. /start"
Write-Host ""
Write-Host "Apri Obsidian e seleziona questa cartella come vault!"
Write-Host ""
Write-Host "==========================================" -ForegroundColor Green

# Chiedi se aprire la cartella
$openFolder = Read-Host "Vuoi aprire la cartella ora? (s/n)"
if ($openFolder -eq "s" -or $openFolder -eq "S") {
    explorer $ProjectPath
}

Write-Host ""
Write-Host "Premi un tasto per chiudere..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
