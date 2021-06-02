project('ttrcalc', ['vala', 'c'])

application_id = 'eu.dupaw.ttrcalc'
datadir = get_option('datadir')

deps = [
	dependency('gtk4'),
	dependency('gmodule-2.0'),
	dependency('gee-0.8'),
	dependency('glib-2.0')
]

subdir('ui')
subdir('src')
