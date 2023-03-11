local api = vim.api
-- local buf, win

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
    vim = {
        default = "echo \"{{value}}: \" . {{value}}",
        info = "echom \"{{value}}: \" . {{value}}",
        custom = "echo \"{{value}}: \" . {{value}}",
    },
    lua = {
        default = "print(\"{{value}}: \", {{value}})",
    }
}

local function getWordUnderCursor()
    return vim.fn.expand("<cexpr>")
end

local function getLogCommand(type)
    local filetype = vim.bo.filetype
    local logCommand = languageMap[filetype][type]
    return logCommand
end

local function interpolateLogCommand(logCommand, value)
    return vim.fn.substitute(logCommand, "{{value}}", value, "g")
end

-- Logs the word under the cursor
local function log(type)
    -- Get the current cursor position to use later
    local currentPos = vim.fn.getpos(".")

    local currentWord = getWordUnderCursor()
    local logCommand = getLogCommand(type)
    local logText = interpolateLogCommand(logCommand, currentWord)

    -- Insert the logText below the current line
    vim.api.nvim_command("normal! o" .. logText)

    -- Return cursor to original position
    vim.fn.setpos(".", currentPos)
end

log("default")

return {
    log = log,
}
