project('discordpp-echo-bot', 'cpp')

add_project_arguments('-DMYPROJ=projname', language : 'c')
add_project_arguments(['-DALL_DISCORDPP_PLUGINS=discordpp::PluginEndpoints,discordpp::PluginInteractionHandler,discordpp::PluginOverload,discordpp::PluginRateLimit,discordpp::PluginResponder,discordpp::RestSimpleWeb,discordpp::WebsocketSimpleWeb'], language : 'cpp')
add_project_link_arguments(['-lstdc++fs'], language : 'cpp')

cpp = meson.get_compiler('cpp')

dep = [
	dependency('boost', modules : ['system']),
	dependency('nlohmann_json'),
	dependency('threads'),
	dependency('fmt'),
	cpp.find_library('ssl'),
	cpp.find_library('crypto')
]

inc = [
	'.'
]

src = [
	'main.cc',
	'extern.cc'
]

executable(
	'echo_bot',
	sources : src,
	dependencies : dep,
	include_directories : inc,
	install : true,
	override_options : ['cpp_std=c++17']
)

