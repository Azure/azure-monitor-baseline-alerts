# Git Hooks Setup

## Automatic EditorConfig Enforcement

This repository includes a pre-commit hook that automatically fixes EditorConfig issues (line endings, final newlines) before commits.

### Setup (One-time per developer)

Run this command once after cloning the repository:

```powershell
git config core.hooksPath .githooks
```

This configures git to use the hooks in the `.githooks` directory.

### What It Does

The pre-commit hook automatically:
- Detects JSON files being committed
- Fixes line endings (LF vs CRLF)
- Ensures proper final newlines
- Re-stages the fixed files

You don't need to manually run any scripts - it happens automatically on every commit!

### Manual Fix (if needed)

If you need to fix all files at once:

```powershell
.\tooling\Fix-EditorConfigIssues.ps1
```

### VS Code Integration

For real-time formatting while editing:

1. Install the **EditorConfig for VS Code** extension
2. Enable format-on-save in VS Code settings:
   ```json
   {
     "editor.formatOnSave": true,
     "files.insertFinalNewline": true,
     "files.trimTrailingWhitespace": true
   }
   ```
