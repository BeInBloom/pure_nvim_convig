local hints = {
	inlayHints = {
		typeHints = {
			enable = true,
		},
		parameterHints = {
			enable = true,
		},
		chainingHints = {
			enable = true,
		},
	},
}

return {
	settings = {
		["rust-analyzer"] = hints,
	},
}
