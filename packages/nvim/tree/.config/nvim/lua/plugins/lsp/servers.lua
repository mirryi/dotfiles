local M = {}

-- c/c++
M['clangd'] = {}

-- cmake
M['cmake'] = {}

-- dafny
M['dafny'] = {}

-- dockerfile
M['dockerls'] = {}

-- dot
M['dotls'] = {}

-- go
M['gopls'] = {}

-- haskell
M['hls'] = {}

-- html
M['html'] = {}

-- java
M['jdtls'] = {
    cmd = { vim.fn.stdpath('config') .. '/lua/plugins/lsp/servers/jdtls.sh' },
}

-- javascript/typescript
M['biome'] = {}
M['oxlint'] = {}
M['ts_ls'] = {}

-- json
local schemastore = require('schemastore')
M['jsonls'] = {
    settings = {
        schemas = schemastore.json.schemas(),
    },
}

-- julia
M['julials'] = {}

-- kotlin
M['kotlin_language_server'] = {}

-- lua
M['lua_ls'] = {
    settings = {
        Lua = {
            diagnostics = { enable = false },
            format = { enable = false },
            workspace = { maxPreload = 9999, checkThirdParty = false },
        },
    },
}

-- nickel
M['nickel_ls'] = {}

-- nix
M['nil_ls'] = {}
M['statix'] = {}

-- nushell
M['nushell'] = {}

-- ocaml/reason
M['ocamllsp'] = {}

-- perl
M['perlls'] = {}

-- python
M['pylsp'] = {}
M['pyright'] = {}

-- r
M['r_language_server'] = {}

-- shell
M['bashls'] = {}

-- toml
M['taplo'] = {}

-- texlab
M['texlab'] = {}

-- typst
M['tinymist'] = {}

-- vim
M['vimls'] = {}

return M
