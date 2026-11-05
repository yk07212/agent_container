FROM node:22-bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
      curl ca-certificates git bash ripgrep less \
    && rm -rf /var/lib/apt/lists/*

# Codex (npm package)
RUN npm install -g @openai/codex

# Claude Code, OpenCode, uv (official install scripts)
RUN curl -fsSL https://claude.ai/install.sh | bash
RUN curl -fsSL https://opencode.ai/install | bash
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

ENV PATH="/root/.local/bin:/root/.opencode/bin:${PATH}"

# Put all logins/config in one directory so one volume can persist them
ENV CLAUDE_CONFIG_DIR=/state/claude \
    CODEX_HOME=/state/codex \
    XDG_CONFIG_HOME=/state/config \
    XDG_DATA_HOME=/state/data

WORKDIR /work
CMD ["bash"]
