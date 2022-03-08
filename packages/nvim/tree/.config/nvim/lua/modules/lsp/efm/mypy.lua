return {
    lintCommand = 'mypy --show-column-numbers --no-color-output',
    lintFormats = {
        '%f:%l:%c: %trror: %m',
        '%f=%l:%c: %tarning: %m',
        '%f=%l:%c: %tote: %m',
    },
}
