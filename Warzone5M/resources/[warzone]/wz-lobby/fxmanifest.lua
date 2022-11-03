fx_version "bodacious"
game "gta5"

ui_page "ui-files/index.html"

client_scripts {
	"@wz-core/lib/utils.lua",
	"client/*"
}

server_scripts {
	"@wz-core/lib/utils.lua",
	"server/*"
}

files {
	"ui-files/*"
}