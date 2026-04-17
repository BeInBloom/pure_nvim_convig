local hints = {
	variableTypes = true,
	functionReturnTypes = true,
	callArgumentNames = "partial",
	pytestParameters = true,
}

return {
	cmd = {
		"pyrefly",
		"lsp",
		"--indexing-mode",
		"lazy-non-blocking-background",
		"--workspace-indexing-limit",
		"2000",
	},
	settings = {
		python = {
			analysis = {
				inlayHints = hints,
			},
		},
	},
}
