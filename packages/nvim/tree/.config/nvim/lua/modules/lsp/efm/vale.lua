local bin = 'vale'
return {
    lintCommand = bin .. ' --output line',
    lintFormats = { '%f:%l:%c:%s:%m' },
    lintIgnoreExitCode = true,
}
