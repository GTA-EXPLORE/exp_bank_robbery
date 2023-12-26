fx_version 'adamant'
game 'gta5'
lua54 'yes'
version '1.0.0'
author 'EXPLORE - MilyonJames'

this_is_a_map 'yes'

client_scripts {
	"locales/*",
	'config.lua',
	'client/**/*.lua',
}

server_scripts {
	"@oxmysql/lib/MySQL.lua",
	"locales/*",
	'config.lua',
	'server/*',
}

ui_page "client/hacking/ui/index.html"

files {
    "client/hacking/ui/**/*"
}