-- lua/ernesto/pack/clean.lua
--
-- :PackClean — vim.pack.add() clona un plugin la PRIMERA vez y lo deja
-- en disco para siempre. Si después dejás de hacerle require() en algún
-- lado, queda "instalado pero inactivo" (lo que te marca el checkhealth).
-- Este comando busca esos huérfanos y te pregunta si los querés borrar.
local function pack_clean()
  local active = {}
  for _, plugin in ipairs(vim.pack.get()) do
    active[plugin.spec.name] = plugin.active
  end

  local unused = {}
  for name, is_active in pairs(active) do
    if not is_active then
      table.insert(unused, name)
    end
  end

  if #unused == 0 then
    vim.notify("No hay plugins sin usar.")
    return
  end

  vim.notify("Plugins sin usar:\n  " .. table.concat(unused, "\n  "))
  local choice = vim.fn.confirm("¿Borrar estos plugins del disco?", "&Si\n&No", 2)
  if choice == 1 then
    vim.pack.del(unused)
  end
end

vim.api.nvim_create_user_command("PackClean", pack_clean, {
  desc = "Borra plugins de vim.pack que quedaron sin usar",
})
