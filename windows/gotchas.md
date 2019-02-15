## Visual Studio

When using the Visual Studio generator instead of Ninja, beware: cmake defaults to x86.
To select x64, use `cmake -G "Visual Studio 15 2017 Win64" ...`

Be sure to open Visual Studio from a command line with
`pyarrow-dev` active- this allows it to inherit the conda environment
(-> no need to set up include paths etc by hand)

```cmd
conda activate pyarrow-dev
devenv.exe
```

## Debug builds

Building debug effectively restricts you to the c++ project.
Windows considers loading/linking a debug library
alongside a release library an error, and since your conda python is a release build you
can't use debug arrow libraries with it. My usual workaround is to disable optimizations
in a RelWithDebInfo build- `NDEBUG` is still defined but it's debuggable.

If you come up with a better one, please post it here.

## Cmd doesn't respect single quotes

```
python -c "import sys; print(sys.argv[1])" hello
# hello
python -c "import sys; print(sys.argv[1])" "hello"
# hello
python -c "import sys; print(sys.argv[1])" 'hello'
# 'hello'
```
