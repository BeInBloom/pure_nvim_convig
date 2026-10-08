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
			pyrefly = {
				-- The default "basic" preset suppresses type errors in unconfigured files.
				typeCheckingMode = "default",
			},
			analysis = {
				inlayHints = hints,
			},
		},
	},
}
