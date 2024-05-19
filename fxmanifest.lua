fx_version 'cerulean'
game 'gta5'

author 'finalLy <amitaidvora81@gmail.com>'
description 'Adds speedometer.'
version '1.0.0'

ui_page 'html/index.html'

shared_script "config.lua"

client_scripts {
    'client/main.lua',
}

files {
    'html/index.html',
    'html/js/*.js',
    'html/styles/*.css',
    'config.json'
}
