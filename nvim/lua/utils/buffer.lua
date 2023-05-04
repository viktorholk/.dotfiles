local buffer = {}

function buffer.close(loaded_only)
  loaded_only = (loaded_only == nil and true or loaded_only)
  local count = {
    normal = 0,
    acwrite = 0,
    help = 0,
    nofile = 0,
    nowrite = 0,
    quickfix = 0,
    terminal = 0,
    prompt = 0
  }
  local buftypes = vim.api.nvim_list_bufs()

  for _, bufname in pairs(buftypes) do
    if (not loaded_only) or vim.api.nvim_buf_is_loaded(bufname) then
      local buftype = vim.api.nvim_buf_get_option(bufname, 'buftype')
      buftype = buftype ~= '' and buftype or 'normal'
      count[buftype] = count[buftype] + 1
    end
  end

  if (count.normal <= 1) then
    vim.api.nvim_exec([[:q]], true)
  else
    vim.api.nvim_exec([[:bd]], true)
  end
end

return buffer
