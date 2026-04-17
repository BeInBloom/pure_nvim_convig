local hints = {
	parameterNames = true,
	assignVariableTypes = true,
	rangeVariableTypes = true,
	compositeLiteralFields = true,
	compositeLiteralTypes = true,
	constantValues = true,
	functionTypeParameters = true,
}

return {
	settings = {
		gopls = {
			hints = hints,
		},
	},
}
