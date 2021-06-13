gnome = import('gnome')

resources_xml = files('resources.xml')
resources = gnome.compile_resources('resources', resources_xml, source_dir: '.')

resource_args = [
	'--gresources', resources_xml,
	'--target-glib=2.38'
]

desktop_file_name = '@0@.desktop'.format(application_id)
install_data(
    desktop_file_name,
	install_dir: join_paths(datadir, 'applications')
)

icondir = join_paths(datadir, 'icons', 'hicolor')
install_data('icons/hicolor/scalable/@0@.svg'.format(application_id),
  install_dir: join_paths(icondir, 'scalable', 'apps')
)
install_data('icons/hicolor/symbolic/@0@-symbolic.svg'.format(application_id),
  install_dir: join_paths(icondir, 'symbolic', 'apps')
)
