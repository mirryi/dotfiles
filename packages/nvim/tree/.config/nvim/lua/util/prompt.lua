local M = {}

M.input_is_yes = function(input)
    local input_lower = vim.fn.tolower(input)
    return input_lower == 'y' or input_lower == 'yes'
end

M.prompt_yn = function(opts, on_confirm, on_abort)
    local on_confirm_wrap = function(input)
        if input == nil then
            if on_abort ~= nil then
                on_abort()
            end
        else
            on_confirm(M.input_is_yes(input))
        end
    end

    vim.ui.input(opts, on_confirm_wrap)
end

return M
