fx_version 'adamant'
game 'gta5'
lua54 'yes'
version '2.0.0'
author 'EXPLORE - MilyonJames'

this_is_a_map 'yes'

shared_scripts {
    "@ox_lib/init.lua", -- This can be commented if you're not using ox_lib's notifications
    "@sd_lib/init.lua",
	'config.lua',
}

client_scripts {
	'client/**/*.lua',
}

server_scripts {
	"@oxmysql/lib/MySQL.lua",
	'server/*',
}

ui_page "client/hacking/ui/index.html"

files {
    "client/hacking/ui/**/*",
    "locales/*"
}

dependencies {
    "sd_lib"
}