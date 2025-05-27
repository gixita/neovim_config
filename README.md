# Jupyter notebook configuration

The jupyter notebook configuration is a bit involved, but worth it.

First create a folder in your home user directory and create a virtualenv called neovim which is used in the init.lua. Install the necessary dependencies.

```bash
mkdir .virtualenvs
cd .virtualenvs
uv venv neovim -p 3.13
source neovim/bin/activate
uv pip install pynvim jupyter_client cairosvg plotly kaleido pnglatex pyperclip
deactivate
```

In your project folder create a brand new virtualenv for your project called my_project. Then we will install ipykernel and install a kernel for your project only for your user.

```bash
cd my_project
uv venv .venv 3.13
source .venv/bin/activate
uv add ipykernel
python -m ipykernel install --user --name my_project
```

Because the kernel was installed in the virtual env .venv of the my_project, it will take the python interpretor of that virtualenvs making all libraries available.

When running a ipynb file, everything should spin automatically, but if you want to use it directly in markdown files, you need to initialize molten and quarto with the following: 

:MoltenInit
:QuartoActivate

The all the useful commands (for me) can be triggered by <leader>j
