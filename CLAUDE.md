# CLAUDE.md

Instructions for Claude Code in this workspace.

## Startup Protocol

On session start:
1. Read `brain/context.md` for current state
2. Read latest `notes/daily-summaries/closing-*.md` (if exists)
3. Propose priorities and ask for confirmation

## Commands

- `/start` - Start work session
- `/close` - End session with report

## General Rules

1. **Don't invent data** - Ask if you don't know
2. **Respect folder structure** - Each file in its place
3. **Execute autonomously** - Only ask if critical info is missing
4. **Be concise** - Short, actionable responses
5. **Update context.md** - Keep state updated

## Project Structure

```
workspace/
├── brain/              # Persistent state and context
│   └── context.md      # Main state file
├── notes/              # Notes and memos
│   └── daily-summaries/  # Daily reports
├── docs/               # Final documents
├── .claude/            # Claude Code config
│   └── commands/       # Custom commands
└── CLAUDE.md           # This file
```

## Output Style

- Use markdown formatting
- Bullet points for lists
- No emojis (unless requested)
- Get to the point
- Short sentences

## Things NOT to Do

1. Don't load entire large files - sample first, then ask
2. Don't read files "just in case" - only what's needed
3. Don't invent numbers or data
4. Don't run long sessions without saving
