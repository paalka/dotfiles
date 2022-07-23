local home = os.getenv('HOME')
local db = require('dashboard')

db.custom_center = {
	{icon = '  ',
	desc ='File Browser                            ',
	action =  'Telescope file_browser',
	shortcut = 'SPC f b'},
	{icon = '  ',
	desc = 'Find  word                              ',
	action = 'Telescope live_grep',
	shortcut = 'SPC f w'},
}
