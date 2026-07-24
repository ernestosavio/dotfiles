-- Solo aplica en buffers de tipo C
vim.opt_local.makeprg = "gcc -Wall -Wextra -pedantic -no-pie -g % -o %<"

-- (Opcional) Definir errorformat para que la quickfix capture bien los errores
-- Este formato es común para gcc:
vim.opt_local.errorformat = "%f:%l:%c: %m"

-- Luego, utilizar `:make` para compilar
