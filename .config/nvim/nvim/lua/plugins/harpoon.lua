return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup()

    vim.keymap.set("n", "<leader>hj", function() harpoon:list():add() end, { desc = "Add file to harpoon" })
    vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Toggle harpoon quick menu" })

    vim.keymap.set("n", "<leader>11", function() harpoon:list():select(1) end, { desc = "Select harpoon file 1" })
    vim.keymap.set("n", "<leader>22", function() harpoon:list():select(2) end, { desc = "Select harpoon file 2" })
    vim.keymap.set("n", "<leader>33", function() harpoon:list():select(3) end, { desc = "Select harpoon file 3" })
    vim.keymap.set("n", "<leader>44", function() harpoon:list():select(4) end, { desc = "Select harpoon file 4" })
    vim.keymap.set("n", "<leader>55", function() harpoon:list():select(5) end, { desc = "Select harpoon file 5" })
    vim.keymap.set("n", "<leader>66", function() harpoon:list():select(6) end, { desc = "Select harpoon file 6" })
    vim.keymap.set("n", "<leader>77", function() harpoon:list():select(7) end, { desc = "Select harpoon file 7" })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end, { desc = "Previous harpoon file" })
    vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end, { desc = "Next harpoon file" }) 

    -- basic telescope configuration
    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
            table.insert(file_paths, item.value)
        end

        require("telescope.pickers").new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
                results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
        }):find()
    end

    vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })
  end
}
