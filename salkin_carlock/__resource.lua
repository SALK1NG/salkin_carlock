resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Simple CarLock System'
author 'SALKIN.G'
version '1.0'

shared_script 'config.lua'
client_scripts {
	"@es_extended/locale.lua",
    "client.lua"
}

server_scripts {
	"server.lua",
	'@es_extended/locale.lua',
	'@mysql-async/lib/MySQL.lua'
	
}