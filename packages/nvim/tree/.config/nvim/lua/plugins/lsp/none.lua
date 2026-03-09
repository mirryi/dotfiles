local builtins = require('null-ls').builtins

return {
    -- generic
    builtins.diagnostics.trail_space,

    -- bibtex
    builtins.formatting.bibclean,

    -- c++
    builtins.diagnostics.cppcheck,

    -- cmake
    builtins.formatting.cmake_format,

    -- docker
    builtins.diagnostics.hadolint,

    -- git
    builtins.diagnostics.gitleaks,

    -- github actions
    builtins.diagnostics.actionlint,

    -- just
    builtins.formatting.just,

    -- lua
    builtins.formatting.stylua,
    builtins.diagnostics.selene,

    -- nix
    builtins.diagnostics.deadnix,

    -- shell
    builtins.formatting.shellharden,
    builtins.hover.printenv,

    -- vimscript
    builtins.diagnostics.vint,
}
