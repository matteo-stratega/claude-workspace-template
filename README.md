# Claude Code Workspace Setup

A ready-to-use workspace template for Claude Code with persistent memory, custom commands, and organized structure.

## What You Get

- **Persistent memory** - Claude remembers your projects between sessions
- **Custom commands** - `/start` and `/close` for workflow automation
- **Organized structure** - Folders for notes, docs, and context
- **Session reports** - Automatic daily summaries

## Quick Start

### Prerequisites

- [Node.js](https://nodejs.org) (LTS version)
- [Claude Pro subscription](https://claude.ai) ($20/month)

### Installation

```bash
# 1. Install Claude Code
npm install -g @anthropic-ai/claude-code

# 2. Clone this repo
git clone https://github.com/YOUR_USERNAME/claude-workspace-template.git my-workspace
cd my-workspace

# 3. Start Claude
claude

# 4. Initialize
/init
```

Or use the automated setup:

```bash
# Mac/Linux
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/claude-workspace-template/main/setup.sh | bash

# Windows (PowerShell)
irm https://raw.githubusercontent.com/YOUR_USERNAME/claude-workspace-template/main/setup.ps1 | iex
```

## Folder Structure

```
workspace/
├── CLAUDE.md              # Main instructions for Claude
├── brain/
│   └── context.md         # Your current state and priorities
├── notes/
│   └── daily-summaries/   # Session reports
├── docs/                  # Final documents
└── .claude/
    └── commands/
        ├── start.md       # /start command
        └── close.md       # /close command
```

## Usage

### Starting a Session

```
claude
/start
```

Claude will:
1. Load your context
2. Check your last session
3. Propose today's priorities

### During Work

Ask Claude anything:
- "Create a file for..."
- "Summarize this document..."
- "Help me organize..."

### Ending a Session

```
/close
```

Claude will:
1. Save a session report
2. Update context if needed
3. Confirm closure

## Customization

### Edit CLAUDE.md

Add project-specific instructions:

```markdown
## Project Rules

- Always use TypeScript
- Follow our coding standards in docs/standards.md
- Ask before deleting files
```

### Edit brain/context.md

Update with your projects:

```markdown
## Focus This Week
- [ ] Launch new feature
- [ ] Client meeting Thursday
- [ ] Review Q1 metrics

## Active Projects
| Project | Status | Notes |
|---------|--------|-------|
| Website | In progress | Landing page due Friday |
| API | Planning | Start next week |
```

## Optional: Add Ollama (Local AI)

For local AI models (free, private):

```bash
# Install Ollama
# Mac: brew install ollama
# Or download from ollama.com

# Pull models
ollama pull llama3.1
ollama pull gemma3

# Test
ollama run llama3.1
```

## Optional: Add Obsidian (Nice Viewer)

1. Download [Obsidian](https://obsidian.md)
2. Open your workspace as a vault
3. Browse your notes visually

## Commands Reference

| Command | What it does |
|---------|--------------|
| `/start` | Load context, show priorities |
| `/close` | Save report, end session |
| `/init` | Create CLAUDE.md (first time) |
| `/help` | Show help |
| `/clear` | Clear conversation |

## Video Tutorials

- [Part 1: Quick Setup (5 min)](YOUTUBE_LINK)
- [Part 2: Full Power Mode (15 min)](YOUTUBE_LINK)

## Credits

Created by [Matteo Lombardi](https://linkedin.com/in/matteolombardigrowth) - Growth Architect building in public.

Inspired by [NetworkChuck's video](https://www.youtube.com/watch?v=MsQACpcuTkU).

## License

MIT - Use it, modify it, share it.
