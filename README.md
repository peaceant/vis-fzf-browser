# Simple fuzzy file browser with the power of FZF

Use [fzf](https://github.com/junegunn/fzf) to browse files in [vis](https://github.com/martanne/vis).

Did not spent much time writing this plugin. Use at your own risk.


![fzf-browser](https://user-images.githubusercontent.com/12976480/162830762-17282fd9-370e-4357-9f43-81a5b99fb822.gif)

## Usage

In vis:
- `:fzfbrowser`: list all files in the current working directory.

## Configuration

In visrc.lua:

```lua
plugin_vis_fzf_browser = require('plugins/vis-fzf-browser/fzf-browser')

-- Path to the fzf executable (default: 'echo "..\n$(ls -Ap)" | fzf')
plugin_vis_browser.fzf_browser_path = 'echo "..\n$(ls -p) | fzf'

-- Arguments passed to fzf (defaul: "")
plugin_vis_browser.fzf_browser_args = "--height 24%"

-- Mapping configuration example (<Space>e)
vis.events.subscribe(vis.events.INIT, function()
    vis:map(vis.modes.NORMAL, " e", ":fzfbrowser<Enter>")
end)
```

