#!/bin/bash

# ============================================
#  AI WORKSPACE - ONE CLICK SETUP
#  Claude Code + Gemini CLI + Organized Structure
# ============================================
#
#  Run with:
#  curl -fsSL https://raw.githubusercontent.com/matteo-stratega/claude-workspace-template/main/setup.sh | bash
#
# ============================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo ""
echo -e "${BLUE}============================================${NC}"
echo -e "${BLUE}   AI WORKSPACE - ONE CLICK SETUP${NC}"
echo -e "${BLUE}============================================${NC}"
echo ""

# ============================================
# STEP 1: Check Node.js
# ============================================
echo -e "${YELLOW}[1/6] Checking Node.js...${NC}"

if ! command -v node &> /dev/null; then
    echo -e "${RED}Node.js not found!${NC}"
    echo ""
    echo "Please install Node.js first:"
    echo "  → https://nodejs.org (download LTS version)"
    echo ""
    echo "Then run this script again."
    exit 1
fi

NODE_VERSION=$(node --version)
echo -e "${GREEN}  ✓ Node.js $NODE_VERSION found${NC}"

# ============================================
# STEP 2: Install Claude Code
# ============================================
echo ""
echo -e "${YELLOW}[2/6] Installing Claude Code...${NC}"

if command -v claude &> /dev/null; then
    echo -e "${GREEN}  ✓ Claude Code already installed${NC}"
else
    npm install -g @anthropic-ai/claude-code
    echo -e "${GREEN}  ✓ Claude Code installed${NC}"
fi

# ============================================
# STEP 3: Install Gemini CLI
# ============================================
echo ""
echo -e "${YELLOW}[3/6] Installing Gemini CLI...${NC}"

if command -v gemini &> /dev/null; then
    echo -e "${GREEN}  ✓ Gemini CLI already installed${NC}"
else
    npm install -g @google/gemini-cli
    echo -e "${GREEN}  ✓ Gemini CLI installed${NC}"
fi

# ============================================
# STEP 4: Create workspace folder
# ============================================
echo ""
echo -e "${YELLOW}[4/6] Creating workspace...${NC}"

# Ask for project name
read -p "Workspace name (default: workspace): " PROJECT_NAME
PROJECT_NAME=${PROJECT_NAME:-workspace}

# Clean name
PROJECT_NAME=$(echo "$PROJECT_NAME" | tr ' ' '-' | tr -cd '[:alnum:]-')

# Create in home directory
WORKSPACE_PATH="$HOME/$PROJECT_NAME"

if [ -d "$WORKSPACE_PATH" ]; then
    echo -e "${YELLOW}  ! Folder already exists: $WORKSPACE_PATH${NC}"
    read -p "  Continue anyway? (y/n): " confirm
    if [[ $confirm != "y" ]]; then
        echo "Aborted."
        exit 1
    fi
else
    mkdir -p "$WORKSPACE_PATH"
fi

cd "$WORKSPACE_PATH"
echo -e "${GREEN}  ✓ Workspace: $WORKSPACE_PATH${NC}"

# ============================================
# STEP 5: Create folder structure + files
# ============================================
echo ""
echo -e "${YELLOW}[5/6] Creating structure...${NC}"

# Folders
mkdir -p brain
mkdir -p notes/daily-summaries
mkdir -p docs
mkdir -p .claude/commands

# CLAUDE.md
cat > CLAUDE.md << 'EOF'
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

## Rules

1. **Don't invent data** - Ask if you don't know
2. **Respect folder structure** - Each file in its place
3. **Execute autonomously** - Only ask if critical info is missing
4. **Be concise** - Short, actionable responses
5. **Update context.md** - Keep state updated

## Folder Structure

- `brain/` - Persistent context and state
- `notes/` - Notes and daily summaries
- `docs/` - Final documents

## Output Style

- Use markdown formatting
- Bullet points for lists
- No emojis (unless requested)
- Get to the point
EOF

# brain/context.md
cat > brain/context.md << 'EOF'
# Context File

**Last Updated:** [DATE]

---

## Current Focus

### This Week
- [ ] Task 1
- [ ] Task 2
- [ ] Task 3

---

## Active Projects

| Project | Status | Notes |
|---------|--------|-------|
| | | |

---

## Key Decisions

| Date | Decision | Why |
|------|----------|-----|
| | | |

---

## Next Actions

1.
2.
3.

---

*Update this file at end of each session*
EOF

# .claude/commands/start.md
cat > .claude/commands/start.md << 'EOF'
# Session Start

Execute the session start protocol:

## Step 1: Load Context
1. Read `brain/context.md` for current state
2. Read the latest `notes/daily-summaries/closing-*.md` file (if exists)

## Step 2: Propose
Summarize in max 5 bullet points:
- What was done in last session (if closing exists)
- What is pending
- Current focus from context

Then ask: **"Confirm these priorities or change?"**

## Step 3: STOP
**Wait for response before proceeding.**
EOF

# .claude/commands/close.md
cat > .claude/commands/close.md << 'EOF'
# Session Close

Execute the session close protocol:

1. **Write closing report** in `notes/daily-summaries/closing-DDMMYYYY.md`:

```
# Closing [DATE]

## TL;DR
- **Done**: [what completed today]
- **Pending**: [what remains]
- **Next**: [next priority action]

## Files Created/Modified
[file list]

---
**Session Status**: Completed
```

2. **Update brain/context.md** if there are significant changes

3. **Confirm** to user: "Session closed. Report saved."
EOF

# .gitignore
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
EOF

echo -e "${GREEN}  ✓ Folders created${NC}"
echo -e "${GREEN}  ✓ CLAUDE.md created${NC}"
echo -e "${GREEN}  ✓ brain/context.md created${NC}"
echo -e "${GREEN}  ✓ /start command created${NC}"
echo -e "${GREEN}  ✓ /close command created${NC}"

# ============================================
# STEP 6: Initialize git
# ============================================
echo ""
echo -e "${YELLOW}[6/6] Initializing git...${NC}"

if [ -d ".git" ]; then
    echo -e "${GREEN}  ✓ Git already initialized${NC}"
else
    git init --quiet
    git add -A
    git commit -m "Initial setup" --quiet
    echo -e "${GREEN}  ✓ Git initialized${NC}"
fi

# ============================================
# DONE!
# ============================================
echo ""
echo -e "${GREEN}============================================${NC}"
echo -e "${GREEN}   SETUP COMPLETE!${NC}"
echo -e "${GREEN}============================================${NC}"
echo ""
echo "Your AI workspace is ready at:"
echo -e "  ${BLUE}$WORKSPACE_PATH${NC}"
echo ""
echo -e "${YELLOW}To start with Claude (requires Claude Pro \$20/month):${NC}"
echo ""
echo "  cd $WORKSPACE_PATH"
echo "  claude"
echo "  /start"
echo ""
echo -e "${YELLOW}Or use Gemini (free with Google account):${NC}"
echo ""
echo "  cd $WORKSPACE_PATH"
echo "  gemini"
echo ""
echo "============================================"
echo ""
echo "First time using these tools?"
echo "  • Claude will open browser for Anthropic login"
echo "  • Gemini will open browser for Google login"
echo ""
echo "============================================"
echo ""
echo "Created by Matteo Lombardi"
echo "https://github.com/matteo-stratega/claude-workspace-template"
echo ""
