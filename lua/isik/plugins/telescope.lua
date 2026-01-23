local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
  return
end

local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
  return
end

telescope.setup({
  defaults = {
    -- Performance optimizations
    preview = {
      -- Disable syntax highlighting in preview for better performance
      treesitter = false,
      -- Limit preview file size to prevent lag on large files
      filesize_limit = 0.1, -- 100KB
    },
    -- Reduce lag when moving through results
    dynamic_preview_title = true,
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      }
    },
  },
  pickers = {
    find_files = {
      -- Disable preview for find_files if you don't need it
      -- previewer = false,
      theme = "dropdown",
    },
  },
})

telescope.load_extension("fzf")
