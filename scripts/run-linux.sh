#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
command -v dotnet >/dev/null || { echo 'Install the .NET 10 SDK in Linux first. See README.md.'; exit 1; }
dotnet publish DemoWeb.csproj -c Release -o artifacts/publish -p:UseAppHost=false
cd artifacts/publish
exec dotnet DemoWeb.dll --urls http://127.0.0.1:5080
