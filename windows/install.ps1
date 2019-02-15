# install chocolatey package manager
# https://chocolatey.org/packages
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# install chocolatey packages
choco install -y neovim emacs git poshgit cmdermini visualstudio2017community ninja sysinternals
choco install -y miniconda3 --params="/AddToPath:1"
choco install -y llvm --version=7.0.1

# add installed packages to path
refreshenv
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1" -Force
Update-SessionEnvironment

# install necessary VS workloads
# https://docs.microsoft.com/en-us/visualstudio/install/use-command-line-parameters-to-install-visual-studio?view=vs-2017
& 'C:\Program Files (x86)\Microsoft Visual Studio\Installer\vs_installer.exe' modify `
                 --installPath 'C:\Program Files (x86)\Microsoft Visual Studio\2017\Community' `
                 --add 'Microsoft.VisualStudio.Workload.NativeDesktop' `
                 --add 'microsoft.visualstudio.component.vc.140' `
                 --quiet --includeRecommended

# configure cmder to include the Visual Studio development environment
# (add cl.exe, msbuild.exe, devenv.exe, etc to path)
Set-Content -Path 'C:\tools\cmdermini\config\user_profile.cmd' @'
:: arguments in this batch are passed from init.bat
:: more useage can be seen by typing "cexec /?"
@echo off
set "__VSCMD_ARG_no_logo=1"
set "VS_2017_INSTALL_DIR=C:\Program Files (x86)\Microsoft Visual Studio\2017\Community"
"%VS_2017_INSTALL_DIR%\Common7\Tools\VsDevCmd.bat" -arch=amd64
'@

# clone arrow and create conda environment
git clone https://github.com/apache/arrow
cd arrow
cmd /c conda create -n pyarrow-dev -y `
                    -c conda-forge `
                    --file ci\conda_env_cpp.yml `
                    --file ci\conda_env_python.yml `
                    python=3.6

# save environment variables in this conda environment
mkdir C:\tools\miniconda3\envs\pyarrow-dev\etc\conda\activate.d
Set-Content -Path 'C:\tools\miniconda3\envs\pyarrow-dev\etc\conda\activate.d\env_vars.bat' @'
@echo off
set ARROW_BUILD_TOOLCHAIN=%CONDA_PREFIX%\Library
set ARROW_HOME=C:\thirdparty
set CLANG_TOOLS_HOME=C:\Program Files\LLVM\bin
'@
