if vim.g.loaded_timber then
    return
end
vim.g.loaded_timber = true

local M = {}

local languageMap = {
    javascript = {
        default = "console.log(`{{value}}: `, {{value}});",
        info = "console.info(`{{value}}: `, {{value}});",
        warning = "console.warn(`{{value}}: `, {{value}});",
        error = "console.error(`{{value}}: `, {{value}});",
        custom = "console.log(`{{value}}: `, {{value}});",
    },
    typescript = {
        default = "console.log(`{{value}}: `, {{value}});",
        info = "console.info(`{{value}}: `, {{value}});",
        warning = "console.warn(`{{value}}: `, {{value}});",
        error = "console.error(`{{value}}: `, {{value}});",
        custom = "console.log(`{{value}}: `, {{value}});",
    },
    typescriptreact = {
        default = "console.log(`{{value}}: `, {{value}});",
        info = "console.info(`{{value}}: `, {{value}});",
        warning = "console.warn(`{{value}}: `, {{value}});",
        error = "console.error(`{{value}}: `, {{value}});",
        custom = "console.log(`{{value}}: `, {{value}});",
    },
    javascriptreact = {
        default = "console.log(`{{value}}: `, {{value}});",
        info = "console.info(`{{value}}: `, {{value}});",
        warning = "console.warn(`{{value}}: `, {{value}});",
        error = "console.error(`{{value}}: `, {{value}});",
        custom = "console.log(`{{value}}: `, {{value}});",
    },
    vim = {
        default = "echo \"{{value}}: \" . {{value}}",
        info = "echom \"{{value}}: \" . {{value}}",
        custom = "echo \"{{value}}: \" . {{value}}",
    },
    lua = {
        default = "print(\"{{value}}: \", {{value}})",
    }
}

local function getLogCommand(filetype, type)
    local commands = languageMap[filetype]
    if not commands then
        return nil
    end

    return commands[type] or commands.default
end

local function interpolateLogCommand(logCommand, value)
    return vim.fn.substitute(logCommand, "{{value}}", value, "g")
end

-- Logs the word under the cursor
local function log(type)
    type = type or "default"
    local filetype = vim.bo.filetype

    -- Get the current cursor position to use later
    local currentPos = vim.fn.getpos(".")

    local currentWord = vim.fn.expand("<cexpr>")
    local logCommand = getLogCommand(filetype, type)

    if logCommand then
        local logText = interpolateLogCommand(logCommand, currentWord)
        vim.api.nvim_command("normal! o" .. logText)
    else
        print("Timber error: filetype '" .. filetype .. "' not supported for log type '" .. type .. "'")
    end

    -- Return cursor to original position
    vim.fn.setpos(".", currentPos)
end

M.log = log

vim.api.nvim_create_user_command('TimberLog', function() M.log("default") end, {})
vim.api.nvim_create_user_command('TimberWarn', function() M.log("warning") end, {})
vim.api.nvim_create_user_command('TimberInfo', function() M.log("info") end, {})
vim.api.nvim_create_user_command('TimberError', function() M.log("error") end, {})
vim.api.nvim_create_user_command('TimberCustom', function() M.log("custom") end, {})

return M
