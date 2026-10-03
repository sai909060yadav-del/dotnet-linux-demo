# Small .NET 10 Linux deployment demo

This is a separate practice application, not your company's OM solution. It has a
webpage, /api/info, and /health. There is no SQL Server connection or company data.
First prove code -> publish -> run -> update; database integration is a separate step.
NuGet.Config clears package feeds because this demo has no external packages.
Before adding SQL client or other NuGet packages, restore the needed package source.

## 1. Open and edit on Windows

Open DemoWeb.csproj in a Visual Studio version supporting .NET 10.
Program.cs is the entire backend. Change its message and version for your update test.
You can also run from this directory:

```powershell
dotnet run --urls http://127.0.0.1:5080
```

Visit http://localhost:5080. Ctrl+C stops the application.

## 2. Run in your Kali WSL terminal

The Windows SDK does not install a Linux SDK. Check:

```bash
dotnet --list-sdks
```

If no Linux .NET 10 SDK is available, install it first. For learning in Kali you can
use Microsoft's user-local installer (review it before running):

```bash
curl -fsSL https://dot.net/v1/dotnet-install.sh -o /tmp/dotnet-install-demo.sh
bash /tmp/dotnet-install-demo.sh --channel 10.0 --install-dir "$HOME/.dotnet"
export DOTNET_ROOT="$HOME/.dotnet"
export PATH="$DOTNET_ROOT:$PATH"
dotnet --info
```

The installer does not install operating-system dependencies. If it reports a
missing dependency, share the exact error. Kali is a practice environment here;
choose a supported Linux distribution for the company server. Repeat the export
commands in new terminals, or add them to your shell profile after checking them.

The source is available in this workspace from Kali:

```bash
cd /mnt/c/Users/Saiya/Documents/Codex/2026-09-22/i-x20/dotnet-linux-demo
bash scripts/run-linux.sh
```

Open http://localhost:5080 in Windows. The page should now report Linux as its OS.
Keep this terminal open. This foreground learning demo stops when its process or
WSL stops. It does not install a persistent system service or expose a public site.

In a second Kali terminal:

```bash
cd /mnt/c/Users/Saiya/Documents/Codex/2026-09-22/i-x20/dotnet-linux-demo
python3 scripts/smoke-test.py
```

## 3. Prove an update without Git first

1. Stop the demo using Ctrl+C.
2. Change version from 1.0 to 2.0 and edit the message in Program.cs.
3. Run `bash scripts/run-linux.sh` again.
4. Reload the page and verify version 2.0. Run the smoke test again.

## 4. Practise Git updates

Create a GitHub repository using only this demo directory as its root. Include
.github, scripts, wwwroot, Program.cs and DemoWeb.csproj; omit bin, obj and artifacts.
No repository or credentials have been created or changed for you.

After pushing, clone the repository inside Linux (replace the example URL):

```bash
git clone https://github.com/YOUR-USERNAME/YOUR-REPOSITORY.git ~/dotnet-demo
cd ~/dotnet-demo
bash scripts/run-linux.sh
```

After the next push, stop the running demo and update this Linux clone:

```bash
cd ~/dotnet-demo
bash scripts/update-linux.sh
```

This pulls the current branch's upstream, publishes it and runs the updated app.
It refuses to overwrite uncommitted local changes.

## 5. What happens automatically?

The included GitHub Actions workflow builds and smoke-tests on an Ubuntu runner
for pushes/PRs to main, then stores the publish folder as an artifact. It is ready
for use, but has not been run on your GitHub account. It does NOT automatically
update your computer/server. A deployment job needs your actual target server,
SSH/service configuration and repository settings; none are assumed here.

For a company server, use a supported Linux host, a systemd service and HTTPS
through a configured reverse proxy. Test database access and Windows-only libraries
before migration. Names such as OM.WinExam or OM.WinHelper alone do not prove that
the web project depends on Windows; inspect its references and code.

References:
- https://learn.microsoft.com/dotnet/core/tools/dotnet-install-script
- https://learn.microsoft.com/dotnet/core/deploying/
- https://learn.microsoft.com/aspnet/core/host-and-deploy/linux-nginx
