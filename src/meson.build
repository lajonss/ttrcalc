ttrcalc_vala_args = [
	'--gresources', resources_xml,
	'--pkg', 'posix'
]

src = [
	'App.vala',
	'MainWindow.vala',
	resources
]

ttrcalc_executable = executable(meson.project_name(), src,
	vala_args: ttrcalc_vala_args,
	dependencies: deps,
	install: true
)
