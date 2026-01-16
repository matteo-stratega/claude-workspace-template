# Claude Code Workspace Setup

A ready-to-use workspace template for Claude Code with persistent memory, custom commands, and organized structure.

## What You Get

- **Claude Code** - AI in your terminal
- **Gemini CLI** - Backup AI from Google
- **Persistent memory** - Claude remembers your projects between sessions
- **Custom commands** - `/start` and `/close` for workflow automation
- **Organized structure** - Folders for notes, docs, and context

## Quick Start

### Prerequisites

- **Mac users:** Xcode Command Line Tools (see Troubleshooting if prompted)
- [Node.js](https://nodejs.org) (LTS version) - free
- [Claude Pro subscription](https://claude.ai) ($20/month)

### One-Click Installation

**Option 1: One-liner**
```bash
curl -fsSL https://raw.githubusercontent.com/matteo-stratega/claude-workspace-template/main/setup.sh | bash
```

**Option 2: Two steps (if the above doesn't work)**
```bash
curl -fsSL https://raw.githubusercontent.com/matteo-stratega/claude-workspace-template/main/setup.sh -o setup.sh
bash setup.sh
```

**Windows (PowerShell)**
```powershell
irm https://raw.githubusercontent.com/matteo-stratega/claude-workspace-template/main/setup-windows.ps1 | iex
```

This will:
- Install Claude Code
- Install Gemini CLI
- Create your workspace folder
- Set up the folder structure
- Initialize git

### Manual Installation

```bash
# 1. Install Claude Code
npm install -g @anthropic-ai/claude-code

# 2. Install Gemini CLI (optional)
npm install -g @google/gemini-cli

# 3. Clone this repo
git clone https://github.com/matteo-stratega/claude-workspace-template.git my-workspace
cd my-workspace

# 4. Start Claude
claude

# 5. Begin session
/start
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

```bash
cd ~/workspace
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

For local AI models (free, private, offline):

```bash
# Install Ollama
brew install ollama
# Or download from https://ollama.com

# Pull a model
ollama pull mistral:7b-instruct

# Test it
ollama run mistral:7b-instruct
```

## Commands Reference

| Command | What it does |
|---------|--------------|
| `/start` | Load context, show priorities |
| `/close` | Save report, end session |
| `/help` | Show help |
| `/clear` | Clear conversation |

## Troubleshooting

### Xcode Command Line Tools (Mac)

If you see a popup asking to install developer tools, click **Install** and wait for it to complete. Then run the setup script again.

Or install manually:
```bash
xcode-select --install
```

---

### Permission Error (EACCES) on Mac

If you see `EACCES: permission denied` during installation, choose ONE of these fixes:

---

**Option A: Quick fix (just works)**

Add `sudo` before the install commands:
```bash
sudo npm install -g @anthropic-ai/claude-code
sudo npm install -g @google/gemini-cli
```

Then run the setup script again.

---

**Option B: Proper fix (recommended)**

This fixes npm permissions permanently. You only need to do this once, and you'll never see this error again:

```bash
mkdir -p ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.zshrc
source ~/.zshrc
```

Then run the setup script again:
```bash
curl -fsSL https://raw.githubusercontent.com/matteo-stratega/claude-workspace-template/main/setup.sh | bash
```

---

## Video Tutorial

- [My AI Brain: 1-Click Setup](https://www.youtube.com/watch?v=FxcAz0oRD7A)

## Credits

Created by [Matteo Lombardi](https://linkedin.com/in/matteolombardi9) - Growth Architect building in public.

## License

MIT - Use it, modify it, share it.
