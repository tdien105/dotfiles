-- Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "

local keymaps = {
    ["<Leader>"] = {
        b = {
            name = "buffer",
            b = { ":Buffers!<cr>", "Switch buffer" },
            n = { ":bnext<cr>", "Next buffer" },
            p = { ":bprevious<cr>", "Previous buffer" },
            d = {
                function()
                    require("mini.bufremove").delete(0, false)
                end,
                "Delete buffer",
            },
            l = { ":b#<cr>", "Switch to last buffer" },
        },
        f = {
            name = "file",
            f = { ":Files!<cr>", "Find file" },
            F = { ":Files! " .. vim.fn.expand("%:p:h"), "Find file from here", silent = false },
            g = { ":GitFiles!<cr>", "Find file in git project" },
            s = { ":update<cr>", "Save" },
            y = {
                function()
                    local path = vim.fn.expand("%:p:~")
                    vim.fn.setreg("+", path)
                    print("Copied path: " .. path)
                end,
                "Yank file path",
            },
            Y = {
                function()
                    local path = vim.fn.expand("%")
                    vim.fn.setreg("+", path)
                    print("Copied path: " .. path)
                end,
                "Yank file path from project",
            },
        },
        p = {
            name = "project",
            p = { ":Telescope projects<cr>", "Switch project" },
            b = { ":Oil .<cr>", "Browse project" },
            B = { ":Oil<cr>", "Browse project from here" },
        },
        q = {
            name = "quit/session",
            q = { ":quit<cr>", "Quit" },
            s = {
                function()
                    require("persistence").load()
                end,
                "Restore Session"
            },
            l = {
                function()
                    require("persistence").load({ last = true })
                end,
                "Restore Last Session"
            },
            d = {
                function()
                    require("persistence").stop()
                end,
                "Don't Save Current Session"
            },
        },
        s = {
            name = "search",
            p = { ":Rg!<cr>", "Search project" },
            r = {
                function()
                    require("spectre").open_file_search()
                end,
                "Search and replace",
            },
        },
        g = {
            name = "git",
            g = { ":Neogit<cr>", "Git status" },
            s = { ":Neogit<cr>", "Git status" },
            l = { ":DiffviewFileHistory<cr>", "Git log", mode = { "n", "v" } },
            i = { ":Octo issue list<cr>", "GitHub issues" },
            p = { ":Octo pr list<cr>", "GitHub pull requests" },
        },
        m = {
            name = "markdown",
            p = { ":MarkdownPreview<cr>", "Markdown preview" },
        },
        o = {
            name = "open",
            t = { ":edit ~/Documents/notes/todo.md<cr>", "Todo list" },
        },
        [":"] = { ":Legendary<cr>", "Commands" },
    },
    ["<C-c>"] = { '"+y', "Copy to system clipboard", mode = "v" },
}

-- Aliases
keymaps["<Leader>"]["<Leader>"] = keymaps["<Leader>"].f.g
keymaps["<Leader>"]["/"] = keymaps["<Leader>"].s.p
keymaps["<Leader>"][","] = keymaps["<Leader>"].b.b
keymaps["<Leader>"]["<"] = keymaps["<Leader>"].b.B
keymaps["<Leader>"]["`"] = keymaps["<Leader>"].b.l
keymaps["<C-s>"] = keymaps["<Leader>"].f.s
keymaps["<C-q>"] = keymaps["<Leader>"].q.q
keymaps["<C-Tab>"] = keymaps["<Leader>"].b.l
keymaps["-"] = keymaps["<Leader>"].p.B
keymaps["="] = keymaps["<Leader>"].p.B
keymaps["_"] = keymaps["<Leader>"].p.b

-- tabs
-- map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
-- map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
-- map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
-- map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
-- map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
-- map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

require("which-key").register(keymaps)
