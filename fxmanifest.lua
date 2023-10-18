fx_version 'adamant'
game 'gta5'
lua54 'yes'
version '1.0.0'
author 'EXPLORE - MilyonJames'

this_is_a_map 'yes'

client_scripts {
	"locales/*",
	'config.lua',
	'client/*',
}

server_scripts {
	"@oxmysql/lib/MySQL.lua",
	"locales/*",
	'config.lua',
	'server/*',
}

escrow_ignore {
    "**/editables.lua",
    "locales/*",
    "config.lua"
}