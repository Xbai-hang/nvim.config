LUA_FORMAT_TARGETS := init.lua lua/ after/lsp

format:
	@echo "Formatting lua files with stylua... "
	stylua $(LUA_FORMAT_TARGETS)
	@echo "Lua files formatted. "
