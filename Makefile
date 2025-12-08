LUA_FORMAT_TARGETS := init.lua lua/ lsp/

format:
	@echo "Formatting lua files with stylua... "
	stylua $(LUA_FORMAT_TARGETS)
	@echo "Lua files formatted. "
