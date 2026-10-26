return {
	cmd = { "zls" },
	filetypes = { "zig" },
	root_markers = { "build.zig", ".git" },

	settings = {
		zls = {
			enable_build_on_save = true,
			build_on_save_args = { "check", "-fincremental" },
		},
	},
}
