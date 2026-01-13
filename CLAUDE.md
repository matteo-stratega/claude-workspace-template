# CLAUDE.md

Istruzioni per Claude Code in questo progetto.

## Startup Protocol

All'avvio di ogni sessione:
1. Leggi `brain/context.md` per capire lo stato corrente
2. Leggi l'ultimo closing report in `notes/daily-summaries/` (se esiste)
3. Proponi le priorità e chiedi conferma

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

```
progetto/
├── brain/              # Stato e contesto persistente
│   └── context.md      # File principale di stato
├── notes/              # Note e appunti
│   └── daily-summaries/  # Report giornalieri
├── docs/               # Documenti finali
├── .claude/            # Config Claude Code
│   └── commands/       # Comandi custom
└── CLAUDE.md           # Questo file
```

## Stile Output

- Usa markdown per formattare
- Bullet points per liste
- Niente emoji (a meno che non richiesto)
- Vai dritto al punto
- Frasi brevi

## Cose da NON Fare

1. Non caricare file grandi interi - prima sample, poi chiedi
2. Non leggere file "just in case" - solo quello che serve
3. Non inventare numeri o dati
4. Non fare sessioni troppo lunghe senza salvare
