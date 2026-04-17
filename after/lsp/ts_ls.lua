local hints = {
	includeInlayEnumMemberValueHints = true,
	includeInlayFunctionLikeReturnTypeHints = true,
	includeInlayFunctionParameterTypeHints = true,
	includeInlayParameterNameHints = "literals",
	includeInlayParameterNameHintsWhenArgumentMatchesName = false,
	includeInlayPropertyDeclarationTypeHints = true,
	includeInlayVariableTypeHints = true,
	includeInlayVariableTypeHintsWhenTypeMatchesName = false,
}

return {
	settings = {
		javascript = {
			inlayHints = hints,
		},
		typescript = {
			inlayHints = hints,
		},
	},
}
