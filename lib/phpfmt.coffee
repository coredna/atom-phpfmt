{CompositeDisposable} = require 'atom'
{BufferedProcess} = require 'atom'

module.exports = PhpFmt =
    subscriptions: null
    config:
        phpPath:
            type: 'string'
            default: 'php'
            description: 'The full path to the `php` executable'
        fmtPath:
            type: 'string'
            default: 'fmt.phar'
            description: 'The full path to `fmt` phar archive'
        debug:
            type: 'boolean',
            default: 'false',
            description: 'Verbose output to console'
        cache:
            type: 'boolean'
            default: 'false'
            description: 'Use a cache file'
        cacheFilename:
            type: 'string'
            default: ''
            description: 'The file used for caching'
        cakePhp:
            type: 'boolean'
            default: 'false'
            description: 'Apply CakePHP coding style'
        configFile:
            type: 'string',
            default: '',
            description: 'The path to a file containing your custom configuration'
        constructorType:
            type: 'string'
            enum: ['disabled', 'camel', 'snake', 'golang']
            default: 'disabled'
            description: 'Analyse classes for attributes and generate constructor'
        autoAlign:
            type: 'boolean'
            default: 'false'
            description: 'Auto align of ST_EQUAL and T_DOUBLE_ARROW'
        excludePasses:
            type: 'string'
            default: ''
            description: 'A comma separated list of passes to exclude. See <https://github.com/dericofilho/sublime-phpfmt#currently-supported-transformations> for a complete list'
        indentWithSpaceSize:
            type: 'integer'
            default: ''
            description: 'Use spaces instead of tabs for indentation, the number of spaces to replace tabs with'
        lintBefore:
            type: 'boolean',
            default: 'false',
            description: 'Lint files before pretty printing (PHP must be declared in %PATH%/$PATH)'
        noBackup:
            type: 'boolean'
            default: 'false'
            description: 'No backup file (original.php~)'
        passes:
            type: 'string'
            default: ''
            description: 'A comma separated list of passes to use. See <https://github.com/dericofilho/sublime-phpfmt#currently-supported-transformations> for a complete list'
        profileName:
            type: 'string',
            default: '',
            description: 'Use one of profiles present in configuration file'
        psr1:
            type: 'boolean'
            default: 'false'
            description: 'Activate PSR1 style'
        psr1Naming:
            type: 'boolean'
            default: 'false'
            description: 'Activate PSR1 style - Section 3 and 4.3 - Class and method names case'
        psr2:
            type: 'boolean'
            default: 'false'
            description: 'Activate PSR2 style'
        settersAndGettersType:
            type: 'string'
            enum: ['disabled', 'camel', 'snake', 'golang']
            default: 'disabled'
            description: 'Analyse classes for attributes and generate setters and getters'
        smartLinebreakAfterCurly:
            type: 'boolean'
            default: 'false'
            description: 'Convert multistatement blocks into multiline blocks'
        visibilityOrder:
            type: 'boolean',
            default: 'false',
            description: 'Fixes visibiliy order for method in classes - PSR-2 4.2'
        yodaStyle:
            type: 'boolean',
            default: 'false',
            description: 'Yoda-style comparisons'

    activate: (state) ->
        # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
        @subscriptions = new CompositeDisposable

        # Register command that toggles this view
        @subscriptions.add atom.commands.add 'atom-workspace', 'phpfmt:format': => @format()

    deactivate: ->
        @subscriptions.dispose()

    format: ->
        atom.config.observe 'phpfmt.phpPath', =>
            @phpPath = atom.config.get 'phpfmt.phpPath'

        atom.config.observe 'phpfmt.fmtPath', =>
            @fmtPath = atom.config.get 'phpfmt.fmtPath'

        atom.config.observe 'phpfmt.cache', =>
            @cache = atom.config.get 'phpfmt.cache'

        atom.config.observe 'phpfmt.cacheFilename', =>
            @cacheFilename = atom.config.get 'phpfmt.cacheFilename'

        atom.config.observe 'phpfmt.cakePhp', =>
            @cakePhp = atom.config.get 'phpfmt.cakePhp'

        atom.config.observe 'phpfmt.configFile', =>
            @configFile = atom.config.get 'phpfmt.configFile'

        atom.config.observe 'phpfmt.constructorType', =>
            @constructorType = atom.config.get 'phpfmt.constructorType'

        atom.config.observe 'phpfmt.autoAlign', =>
            @autoAlign = atom.config.get 'phpfmt.autoAlign'

        atom.config.observe 'phpfmt.excludePasses', =>
            @excludePasses = atom.config.get 'phpfmt.excludePasses'

        atom.config.observe 'phpfmt.indentWithSpaceSize', =>
            @indentWithSpaceSize = atom.config.get 'phpfmt.indentWithSpaceSize'

        atom.config.observe 'phpfmt.lintBefore', =>
            @lintBefore = atom.config.get 'phpfmt.lintBefore'

        atom.config.observe 'phpfmt.noBackup', =>
            @noBackup = atom.config.get 'phpfmt.noBackup'

        atom.config.observe 'phpfmt.include', =>
            @passes = atom.config.get 'phpfmt.passes'

        atom.config.observe 'phpfmt.profileName', =>
            @profileName = atom.config.get 'phpfmt.profileName'

        atom.config.observe 'phpfmt.psr1', =>
            @psr1 = atom.config.get 'phpfmt.psr1'

        atom.config.observe 'phpfmt.psr1Naming', =>
            @psr1Naming = atom.config.get 'phpfmt.psr1Naming'

        atom.config.observe 'phpfmt.psr2', =>
            @psr2 = atom.config.get 'phpfmt.psr2'

        atom.config.observe 'phpfmt.selfUpdate', =>
            @selfUpdate = atom.config.get 'phpfmt.selfUpdate'

        atom.config.observe 'phpfmt.settersAndGettersType', =>
            @settersAndGettersType = atom.config.get 'phpfmt.settersAndGettersType'

        atom.config.observe 'phpfmt.smartLinebreakAfterCurly', =>
            @smartLinebreakAfterCurly = atom.config.get 'phpfmt.smartLinebreakAfterCurly'

        atom.config.observe 'phpfmt.visibilityOrder', =>
            @visibilityOrder = atom.config.get 'phpfmt.visibilityOrder'

        atom.config.observe 'phpfmt.yodaStyle', =>
            @yodaStyle = atom.config.get 'phpfmt.yodaStyle'

        atom.config.observe 'phpfmt.debug', =>
            @debug = atom.config.get 'phpfmt.debug'

        editor = atom.workspace.getActivePaneItem()
        filePath = editor.getPath() if editor && editor.getPath
        command = @phpPath
        console.log(@autoAlign)
        # save file so we can format it
        editor.save();

        # options
        args = []
        args.push '-dshort_open_tag=On'
        args.push @fmtPath
        args.push '-v' if @debug
        args.push '-o=' + filePath
        args.push '--cache' if @cache
        args.push '--cache=' + @cacheFilename if @cache && @cacheFilename.length != 0
        args.push '--cakephp' if @cakePhp
        args.push '--config=' + @configFile if @configFile.length != 0
        args.push '--constructor=' + @constructorType if @constructorType != 'disabled'
        args.push '--enable_auto_align' if @autoAlign
        args.push '--exclude=' + @excludePasses if @excludePasses.length != 0
        args.push '--indent_with_space=' + @indentWithSpaceSize if @indentWithSpaceSize > 0
        args.push '--lint-before' if @lintBefore
        args.push '--no-backup' if @noBackup
        args.push '--passes=' + @passes if @passes.length != 0
        args.push '--profile=' + @profileName if @profileName.length != 0 && @configFile.length != 0
        args.push '--psr1' if @psr1
        args.push '--psr1-naming' if @psr1Naming
        args.push '--psr2' if @psr2
        args.push '--selfupdate' if @selfUpdate
        args.push '--setters_and_getters=' + @settersAndGettersType if @settersAndGettersType != 'disabled'
        args.push '--smart_linebreak_after_curly' if @smartLinebreakAfterCurly
        args.push '--visibility_order' if @visibilityOrder
        args.push '--yoda' if @yoda
        args.push filePath

        # some debug output for a better support feedback
        console.debug('phpfmt Command', command)
        console.debug('phpfmt Arguments', args)

        stdout = (output) -> console.log(output)
        stderr = (output) -> console.error(output)
        exit = (code) -> console.log("#{command} exited with code: #{code}")

        process = new BufferedProcess({
          command: command,
          args: args,
          stdout: stdout,
          stderr: stderr,
          exit: exit
        }) if filePath
