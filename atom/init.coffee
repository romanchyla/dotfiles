atom.commands.add '.platform-linux atom-text-editor', 'custom:toggle-linter', ->
	atom.commands.dispatch(document.querySelector('atom-text-editor'), 'linter:toggle')
	atom.commands.dispatch(document.querySelector('atom-text-editor'), 'linter:togglePanel')
