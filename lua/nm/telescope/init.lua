local M = {}
  local devicons = require("nvim-web-devicons")
  local entry_display = require("telescope.pickers.entry_display")

  local function generate_test(opts)
    local default_icons, _ = devicons.get_icon("file", "", { default = true })

    local displayer = entry_display.create({
      separator = " ",
      items = {
        { width = vim.fn.strwidth(default_icons) },
        { reamaining = true }, -- file_name
        { remaining = true }, -- path
      },
    })

    local function make_display(entry)

      return displayer({
        { entry.devicons, entry.devicons_highlight },
        { entry.file_name, "TelescopeResultsIdentifier" },
        { entry.dir_name, "Comment" },
      })
    end

    return function(line)
      -- print(line)

      local file_name = vim.fn.fnamemodify(line, ":p:t")
      local absolute_path_dir_name = vim.fn.fnamemodify(line, ":p:h")
      local relative_path_dir_name = vim.fn.fnamemodify(line, ':p:~:.')
      -- print('filename ' .. file_name)
      -- print('score ' .. score) -- score is coming up nil
      -- print('score_str ' .. score_str) -- score_str is coming up nil
      -- print('path ' .. path) -- path is coming up nil
      -- print("dir_name " .. dir_name) -- dir_name works
      local path = absolute_path_dir_name .. "/" .. file_name

      local icons, highlight = devicons.get_icon(line, string.match(line, "%a+$"), { default = true })

      return {
        -- value = score,
        ordinal = path,
        path = path,
        display = make_display,
        file_name = file_name,
        dir_name = relative_path_dir_name,
        devicons = icons,
        devicons_highlight = highlight,
      }
    end
  end
return M
