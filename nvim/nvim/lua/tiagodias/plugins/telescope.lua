return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require('telescope.builtin')

    telescope.setup({
      defaults = {
        file_ignore_patterns = { "%.git/" },
        path_display = { "truncate " },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next,     -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
    })

    telescope.load_extension("fzf")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
    keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[ ] Find existing buffers' })
    keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Search [G]it [F]iles' })
    keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    keymap.set('n', '<leader>st', builtin.treesitter, { desc = '[S]earch [T]reesitter' })
  end,
}

