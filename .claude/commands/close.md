# Session Close

Execute the session close protocol:

## Step 1: Write Closing Report

Create file `notes/daily-summaries/closing-DDMMYYYY.md` with this format:

```
# Closing [DATE]

## TL;DR
- **Done**: [what completed today]
- **Pending**: [what remains to do]
- **Next**: [next priority action]

## Files Created/Modified
- [list of files created or modified]

## Notes
[Any important notes]

---
**Session Status**: Completed
```

## Step 2: Update Context

Update `brain/context.md` if there are:
- New key decisions
- Project status changes
- Completed tasks to remove
- New priorities

## Step 3: Confirm

Confirm to user: "Session closed. Report saved in [path]"

---

Don't ask for confirmation to write - just do it.
