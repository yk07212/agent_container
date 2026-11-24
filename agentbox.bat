@echo off
setlocal

set "TARGET=%~1"
if "%TARGET%"=="" set "TARGET=%CD%"

pushd "%TARGET%" 2>nul
if errorlevel 1 (
  echo agentbox: cannot access directory "%TARGET%" 1>&2
  exit /b 1
)
set "WORKDIR=%CD%"
popd

podman run -it --rm ^
  -v "%WORKDIR%":/work:Z ^
  -v agentbox-state:/state ^
  agentbox

endlocal
