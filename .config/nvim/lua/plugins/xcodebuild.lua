return {
  "wojciech-kulik/xcodebuild.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "folke/snacks.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    { "<leader>X", "<cmd>XcodebuildPicker<cr>", desc = "Show Xcodebuild Actions" },
    { "<leader>X", "<cmd>XcodebuildPicker<cr>", desc = "Show Xcodebuild Actions" },
    { "<leader>xf", "<cmd>XcodebuildProjectManager<cr>", desc = "Show Project Manager Actions" },
    { "<leader>xb", "<cmd>XcodebuildBuild<cr>", desc = "Build Project" },
    { "<leader>xB", "<cmd>XcodebuildBuildForTesting<cr>", desc = "Build For Testing" },
    { "<leader>xr", "<cmd>XcodebuildBuildRun<cr>", desc = "Build & Run Project" },
    { "<leader>xt", "<cmd>XcodebuildTest<cr>", desc = "Run Tests" },
    { "<leader>xt", "<cmd>XcodebuildTestSelected<cr>", desc = "Run Selected Tests" },
    { "<leader>xT", "<cmd>XcodebuildTestClass<cr>", desc = "Run Current Test Class" },
    { "<leader>x.", "<cmd>XcodebuildTestRepeat<cr>", desc = "Repeat Last Test Run" },
    { "<leader>xl", "<cmd>XcodebuildToggleLogs<cr>", desc = "Toggle Xcodebuild Logs" },
    { "<leader>xc", "<cmd>XcodebuildToggleCodeCoverage<cr>", desc = "Toggle Code Coverage" },
    { "<leader>xC", "<cmd>XcodebuildShowCodeCoverageReport<cr>", desc = "Show Code Coverage Report" },
    { "<leader>xe", "<cmd>XcodebuildTestExplorerToggle<cr>", desc = "Toggle Test Explorer" },
    { "<leader>xs", "<cmd>XcodebuildFailingSnapshots<cr>", desc = "Show Failing Snapshots" },
    { "<leader>xp", "<cmd>XcodebuildPreviewGenerateAndShow<cr>", desc = "Generate Preview" },
    { "<leader>x<cr>", "<cmd>XcodebuildPreviewToggle<cr>", desc = "Toggle Preview" },
    { "<leader>xd", "<cmd>XcodebuildSelectDevice<cr>", desc = "Select Device" },
    { "<leader>xq", "<cmd>Telescope ickfix<cr>", desc = "Show QuickFix List" },
    { "<leader>xx", "<cmd>XcodebuildQuickfixLine<cr>", desc = "Quickfix Line" },
    { "<leader>xa", "<cmd>XcodebuildCodeActions<cr>", desc = "Show Code Actions" },
  },
  opts = {
    integrations = {
      -- Always secure the script before using `pymobiledevice`
      -- https://github.com/wojciech-kulik/xcodebuild.nvim/wiki/Integrations#-debugging-on-ios-17
      pymobiledevice = {
        enabled = true,
      },
    },
  },
  config = function(_, opts)
    require("xcodebuild").setup(opts)

    -- Auommand to open Trouble on build/test failures
    vim.api.nvim_create_autocmd("User", {
      pattern = { "XcodebuildBuildFinished", "XcodebuildTestsFinished" },
      callback = function(event)
        if event.data.cancelled then
          return
        end

        if event.data.success then
          local ok, trouble = pcall(require, "trouble")
          if ok then
            trouble.close()
          end
          return
        end

        local failed = not event.data.failedCount or event.data.failedCount > 0
        if not failed then
          return
        end

        local ok, trouble = pcall(require, "trouble")
        if not ok then
          return
        end

        if next(vim.fn.getqflist()) then
          trouble.open("quickfix")
        else
          trouble.close()
        end

        trouble.refresh()
      end,
    })
  end,
}
