# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a LazyVim-based Neovim configuration focused on Python development and Jupyter notebook integration. The configuration uses lazy.nvim for plugin management and includes specialized support for scientific computing workflows.

## Architecture

### Core Structure
- `init.lua`: Entry point that bootstraps lazy.nvim and sets up Python host
- `lua/config/`: Core configuration files (keymaps, options, lazy setup)
- `lua/plugins/`: Plugin specifications and configurations
- `stylua.toml`: Lua formatting configuration

### Key Features
- **Jupyter Integration**: Full Jupyter notebook support via Molten.nvim with automatic kernel management
- **Python Development**: Configured with Ruff LSP, Pyright, and isort formatting
- **DAP Debugging**: Debug Adapter Protocol setup for Python
- **Scientific Computing**: Image rendering support for plots and visualizations

## Development Commands

### Formatting
```bash
# Format Lua code (stylua is installed via Mason)
~/.local/share/nvim/mason/bin/stylua .
```

### Jupyter Setup
The configuration expects a specific virtualenv setup for Jupyter:

1. Create neovim virtualenv (referenced in init.lua):
```bash
mkdir ~/.virtualenvs
cd ~/.virtualenvs
uv venv neovim -p 3.13
source neovim/bin/activate
uv pip install pynvim jupyter_client cairosvg plotly kaleido pnglatex pyperclip
```

2. For each project, create a dedicated kernel:
```bash
cd my_project
uv venv .venv 3.13
source .venv/bin/activate
uv add ipykernel
python -m ipykernel install --user --name my_project
```

### Key Bindings

#### Jupyter Notebook (`<leader>j`)
- `<leader>jc`: Run current cell
- `<leader>ja`: Run cell and above
- `<leader>jA`: Run all cells
- `<leader>jL`: Run current line
- `<leader>ji`: Initialize Molten
- `<leader>jo`: Enter output window
- `<leader>jj`: Run line/visual selection
- `<leader>jF`: Force run all cells

#### Debug Adapter Protocol
- `<leader>db`: Toggle breakpoint
- `<leader>dr`: Start/continue debugging

#### Custom Keymaps
- `;`: Enter command mode
- `jj`: Exit insert mode
- `<leader>zz`: Window split shortcut

## Plugin Management

### Adding Plugins
- Create new files in `lua/plugins/` following the existing pattern
- Use lazy.nvim specification format
- Plugin files are automatically loaded via the `{ import = "plugins" }` spec

### Key Plugins
- **Molten.nvim**: Jupyter notebook execution
- **Quarto.nvim**: Scientific document support
- **Image.nvim**: Inline image rendering (requires Kitty terminal)
- **None-ls.nvim**: Formatting and linting integration
- **Jupytext.nvim**: Convert between notebook formats

## Configuration Notes

### Python LSP
- Uses Pyright as the primary LSP server
- Ruff configured for linting and formatting
- Python host points to `~/.virtualenvs/neovim/bin/python3`

### Root Directory
- Set to use current working directory (`vim.g.root_spec = { "cwd" }`)
- Suitable for monorepo setups

### Formatting
- Lua: stylua with 2-space indentation, 120 column width
- Python: Ruff and isort integration via none-ls

## File Modifications

When editing configuration files:
- Follow existing patterns in `lua/plugins/` for new plugin specs
- Use the established keymap structure with `<leader>` prefixes
- Maintain the LazyVim configuration override pattern
- Test Jupyter integration after changes to ensure kernel connectivity