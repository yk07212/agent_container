#!/bin/sh
WORKDIR="$(cd "${1:-$PWD}" && pwd)"   # resolve to absolute path

podman run -it --rm \
  -v "$WORKDIR":/work:Z \
  -v agentbox-state:/state \
  agentbox
