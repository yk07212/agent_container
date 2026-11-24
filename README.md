# agentbox

A Podman container with Claude Code, Codex, OpenCode and uv. Mounts any folder as `/work`. Intented use for the CATCH group (A container is !!NOT!! a sandbox) 

## Setup (once)

### Linux

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

### macOS

1. Install Podman.
2. Create and start the Podman machine:
   ```
   podman machine init
   podman machine start
   ```
3. Build the image:
   ```
   podman build -t agentbox -f Containerfile .
   chmod +x agentbox.sh
   ```
4. Optional alias in `~/.bashrc` / `~/.zshrc`:
   ```
   alias agentbox='/PATH/agentbox.sh'
   ```

### Windows

1. Install Podman.
2. Create and start the Podman machine:
   ```
   podman machine init
   podman machine start
   ```
3. Build the image:
   ```
   podman build -t agentbox -f Containerfile .
   ```
4. Run `agentbox.bat` (or put it on your `PATH`, see below).

#### Put `agentbox.bat` on your `PATH` (Windows)

1. Add the folder that contains `agentbox.bat` to your **user** `PATH` (no admin needed). In PowerShell, from that folder:
   ```
   setx PATH "$env:PATH;$PWD"
   ```
   (Or replace `$PWD` with the full folder path.) Via the GUI: Start → "Edit environment variables for your account" → select `Path` → Edit → New → enter that folder → OK.
2. Open a **new** terminal (existing ones keep the old `PATH`) and check it works:
   ```
   where agentbox.bat
   agentbox
   ```

If you prefer not to touch `PATH`, just run the script by its full path, e.g. `C:\path\to\agentbox.bat`.

## Use

```
cd path/to/my-thing
agentbox                    # mounts the current folder (agentbox.bat on Windows)
agentbox path/to/other      # or pick a folder
```

Inside the container: `claude`, `codex login --device-auth`, `opencode auth login`, `uv`.

## Notes

- Only `/work` (your folder) and the `agentbox-state` volume (logins) persist. Everything else is discarded on exit.
- Mount only the project folder, never `~` or a parent folder.
- Don’t log into GitHub inside the container. Commit and push from the host after reviewing the changes.
- Update tools: `podman build --no-cache -t agentbox -f Containerfile .`
- Reset logins: `podman volume rm agentbox-state`
- If `opencode` crashes, give Podman more RAM: `podman machine stop && podman machine set --memory 6144 && podman machine start`
