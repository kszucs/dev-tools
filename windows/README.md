Download install.ps1

Open PowerShell as Administrator and run:

```powershell
cd ~ # Admin PoSh starts in C:\Windows\system32
# Maybe use iex as choco does
Set-ExecutionPolicy Bypass -Scope Process -Force; ./install.ps1
```

Restart.

After this, you should be able to open cmder and:

```cmd
conda activate pyarrow-dev
mkdir arrow\cpp\build
cd arrow\cpp\build
cmake -GNinja ..
```

