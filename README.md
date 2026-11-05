# agentbox

A Podman container with Claude Code, Codex, OpenCode and uv. Mounts any folder as `/work`. Intented use for the CATCH group (A container is !!NOT!! a sandbox) 

## Setup (once)

1. Install Podman.
2. Build the image:
   ```
   podman build -t agentbox -f Containerfile .
   chmod +x agentbox.sh
   ```
3. Optional alias in `~/.bashrc` / `~/.zshrc`:
   ```
   alias agentbox='/PATH/agentbox.sh'
   ```

## Use

```
cd ~/projects/my-thing
agentbox                    # mounts the current folder
agentbox ~/projects/other   # or pick a folder
```

Inside the container: `claude`, `codex login --device-auth`, `opencode auth login`, `uv`.

## Notes

- Only `/work` (your folder) and the `agentbox-state` volume (logins) persist. Everything else is discarded on exit.
- Mount only the project folder, never `~` or a parent folder.
- Don’t log into GitHub inside the container. Commit and push from the host after reviewing the changes.
- Update tools: `podman build --no-cache -t agentbox -f Containerfile .`
- Reset logins: `podman volume rm agentbox-state`
