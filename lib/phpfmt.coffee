{CompositeDisposable} = require 'atom'
{BufferedProcess} = require 'atom'

module.exports = PhpFmt =
    subscriptions: null
    config:
        executablePath:
            type: 'string'
            default: 'php'
            description: 'The full path to the `php` executable'
        pharPath:
            type: 'string'
            default: 'fmt.phar'
            description: 'The full path to `fmt` phar archive'
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
        config:
            type: 'boolean'
            default: 'false'
            description: 'Use a custom configuration file'
        configFile:
            type: 'string',
            default: '.php.tools.ini',
            description: 'The file containing your configuration'
        constructor:
            type: 'boolean'
            default: 'false'
            description: 'Analyse classes for attributes and generate constructor'
        constructorType:
            type: 'string'
            enum: ['camel', 'snake', 'golang']
            default: 'camel'
            description: 'The type of constructor to generate'
        autoAlign:
            type: 'boolean'
            default: 'true'
            description: 'Auto align of ST_EQUAL and T_DOUBLE_ARROW'
        exclude:
            type: 'object'
            properties:
                AddMissingParentheses:
                    type: 'boolean'
                    default: 'false'
                    description: 'Add extra parentheses in new instantiations'
                AliasToMaster:
                    type: 'boolean'
                    default: 'false'
                    description: 'Replace function aliases to their masters - only basic syntax alias'
                AlignDoubleArrow:
                    type: 'boolean'
                    default: 'false'
                    description: 'Vertically align T_DOUBLE_ARROW (=>)'
                AlignDoubleSlashComments:
                    type: 'boolean'
                    default: 'false'
                    description: 'Vertically align "//" comments'
                AlignEquals:
                    type: 'boolean'
                    default: 'false'
                    description: 'Vertically align "="'
                AlignGroupDoubleArrow:
                    type: 'boolean'
                    default: 'false'
                    description: 'Vertically align T_DOUBLE_ARROW (=>) by line groups'
                AlignPHPCode:
                    type: 'boolean'
                    default: 'false'
                    description: 'Align PHP code within HTML block'
                AlignTypehint:
                    type: 'boolean'
                    default: 'false'
                    description: 'Vertically align "//" comments'
                AllmanStyleBraces:
                    type: 'boolean'
                    default: 'false'
                    description: 'Transform all curly braces into Allman-style'
                AutoPreincrement:
                    type: 'boolean'
                    default: 'false'
                    description: 'Automatically convert postincrement to preincrement'
                AutoSemicolon:
                    type: 'boolean'
                    default: 'false'
                    description: 'Add semicolons in statements ends'
                CakePHPStyle:
                    type: 'boolean'
                    default: 'false'
                    description: 'Applies CakePHP Coding Style'
                ClassToSelf:
                    type: 'boolean'
                    default: 'false'
                    description: '"self" is preferred within class, trait or interface'
                ClassToStatic:
                    type: 'boolean'
                    default: 'false'
                    description: '"static" is preferred within class, trait or interface'
                ConvertOpenTagWithEcho:
                    type: 'boolean'
                    default: 'false'
                    description: 'Convert from "<?=" to "<?php echo "'
                DocBlockToComment:
                    type: 'boolean'
                    default: 'false'
                    description: 'Replace docblocks with regular comments when used in non structural elements'
                DoubleToSingleQuote:
                    type: 'boolean'
                    default: 'false'
                    description: 'Convert from double to single quotes'
                EncapsulateNamespaces:
                    type: 'boolean'
                    default: 'false'
                    description: 'Encapsulate namespaces with curly braces'
                GeneratePHPDoc:
                    type: 'boolean'
                    default: 'false'
                    description: 'Automatically generates PHPDoc blocks'
                IndentTernaryConditions:
                    type: 'boolean'
                    default: 'false'
                    description: 'Applies indentation to ternary conditions'
                JoinToImplode:
                    type: 'boolean'
                    default: 'false'
                    description: 'Replace implode() alias (join() -> implode())'
                LeftWordWrap:
                    type: 'boolean'
                    default: 'false'
                    description: 'Word wrap at 80 columns - left justify'
                LongArray:
                    type: 'boolean'
                    default: 'false'
                    description: 'Convert short to long arrays'
                MergeElseIf:
                    type: 'boolean'
                    default: 'false'
                    description: 'Merge if with else'
                MergeNamespaceWithOpenTag:
                    type: 'boolean'
                    default: 'false'
                    description: 'Ensure there is no more than one linebreak before namespace'
                MildAutoPreincrement:
                    type: 'boolean'
                    default: 'false'
                    description: 'Automatically convert postincrement to preincrement. (Deprecated pass. Use AutoPreincrement instead)'
                OrderMethod:
                    type: 'boolean'
                    default: 'false'
                    description: 'Sort methods within class in alphabetic order'
                OrderMethodAndVisibility:
                    type: 'boolean'
                    default: 'false'
                    description: 'Sort methods within class in alphabetic and visibility order'
                OrderAndRemoveUseClauses:
                    type: 'boolean'
                    default: 'false'
                    description: 'Order use block and remove unused imports'
                OnlyOrderUseClauses:
                    type: 'boolean'
                    default: 'false'
                    description: 'Order use block - do not remove unused imports'
                OrganizeClass:
                    type: 'boolean'
                    default: 'false'
                    description: 'Organize class structure (beta)'
                PrettyPrintDocBlocks:
                    type: 'boolean'
                    default: 'false'
                    description: 'Prettify Doc Blocks'
                PSR2EmptyFunction:
                    type: 'boolean'
                    default: 'false'
                    description: 'Merges in the same line of function header the body of empty functions'
                PSR2MultilineFunctionParams:
                    type: 'boolean'
                    default: 'false'
                    description: 'Break function parameters into multiple lines'
                ReindentAndAlignObjOps:
                    type: 'boolean'
                    default: 'false'
                    description: 'Align object operators'
                ReindentSwitchBlocks:
                    type: 'boolean'
                    default: 'false'
                    description: 'Reindent one level deeper the content of switch blocks'
                RemoveIncludeParentheses:
                    type: 'boolean'
                    default: 'false'
                    description: 'Remove parentheses from include declarations'
                RemoveUseLeadingSlash:
                    type: 'boolean'
                    default: 'false'
                    description: 'Remove leading slash in T_USE imports'
                ReplaceBooleanAndOr:
                    type: 'boolean'
                    default: 'false'
                    description: 'Convert from "and"/"or" to "&&"/"||". Danger! This pass leads to behavior change'
                ReplaceIsNull:
                    type: 'boolean'
                    default: 'false'
                    description: 'Replace is_null($a) with null === $a'
                ReturnNull:
                    type: 'boolean'
                    default: 'false'
                    description: 'Simplify empty returns'
                ShortArray:
                    type: 'boolean'
                    default: 'false'
                    description: 'Convert old array into new array. (array() -> [])'
                SmartLnAfterCurlyOpen:
                    type: 'boolean'
                    default: 'false'
                    description: 'Add line break when implicit curly block is added'
                SpaceAroundControlStructures:
                    type: 'boolean'
                    default: 'false'
                    description: 'Add space around control structures'
                SpaceBetweenMethods:
                    type: 'boolean'
                    default: 'false'
                    description: 'Put space between methods'
                StrictBehavior:
                    type: 'boolean'
                    default: 'false'
                    description: 'Activate strict option in array_search, base64_decode, in_array, array_keys, mb_detect_encoding. Danger! This pass leads to behavior change'
                StrictComparison:
                    type: 'boolean'
                    default: 'false'
                    description: 'All comparisons are converted to strict. Danger! This pass leads to behavior change'
                StripExtraCommaInArray:
                    type: 'boolean'
                    default: 'false'
                    description: 'Remove trailing commas within array blocks'
                StripNewlineAfterClassOpen:
                    type: 'boolean'
                    default: 'false'
                    description: 'Strip empty lines after class opening curly brace'
                StripNewlineAfterCurlyOpen:
                    type: 'boolean'
                    default: 'false'
                    description: 'Strip empty lines after opening curly brace'
                StripSpaces:
                    type: 'boolean'
                    default: 'false'
                    description: 'Remove all empty spaces'
                StripSpaceWithinControlStructures:
                    type: 'boolean'
                    default: 'false'
                    description: 'Strip empty lines within control structures'
                TightConcat:
                    type: 'boolean'
                    default: 'false'
                    description: 'Ensure string concatenation does not have spaces, except when close to numbers'
                UpgradeToPreg:
                    type: 'boolean'
                    default: 'false'
                    description: 'Upgrade ereg_* calls to preg_*'
                WordWrap:
                    type: 'boolean'
                    default: 'false'
                    description: 'Word wrap at 80 columns'
                WrongConstructorName:
                    type: 'boolean'
                    default: 'false'
                    description: 'Update old constructor names into new ones. http://php.net/manual/en/language.oop5.decon.php'
                YodaComparisons:
                    type: 'boolean'
                    default: 'false'
                    description: 'Execute Yoda Comparisons'
        indentWithSpace:
            type: 'boolean'
            default: 'false'
            description: 'Use spaces instead of tabs for indentation'
        indentWithSpaceSize:
            type: 'integer'
            default: '4'
            description: 'The number of spaces to indent for each tab'
        lintBefore:
            type: 'boolean',
            default: 'false',
            description: 'Lint files before pretty printing (PHP must be declared in %PATH%/$PATH)'
        noBackup:
            type: 'boolean'
            default: 'false'
            description: 'No backup file (original.php~)'
        include:
            type: 'object'
            properties:
                AddMissingParentheses:
                    type: 'boolean'
                    default: 'false'
                    description: 'Add extra parentheses in new instantiations'
                AliasToMaster:
                    type: 'boolean'
                    default: 'false'
                    description: 'Replace function aliases to their masters - only basic syntax alias'
                AlignDoubleArrow:
                    type: 'boolean'
                    default: 'false'
                    description: 'Vertically align T_DOUBLE_ARROW (=>)'
                AlignDoubleSlashComments:
                    type: 'boolean'
                    default: 'false'
                    description: 'Vertically align "//" comments'
                AlignEquals:
                    type: 'boolean'
                    default: 'false'
                    description: 'Vertically align "="'
                AlignGroupDoubleArrow:
                    type: 'boolean'
                    default: 'false'
                    description: 'Vertically align T_DOUBLE_ARROW (=>) by line groups'
                AlignPHPCode:
                    type: 'boolean'
                    default: 'false'
                    description: 'Align PHP code within HTML block'
                AlignTypehint:
                    type: 'boolean'
                    default: 'false'
                    description: 'Vertically align "//" comments'
                AllmanStyleBraces:
                    type: 'boolean'
                    default: 'false'
                    description: 'Transform all curly braces into Allman-style'
                AutoPreincrement:
                    type: 'boolean'
                    default: 'false'
                    description: 'Automatically convert postincrement to preincrement'
                AutoSemicolon:
                    type: 'boolean'
                    default: 'false'
                    description: 'Add semicolons in statements ends'
                CakePHPStyle:
                    type: 'boolean'
                    default: 'false'
                    description: 'Applies CakePHP Coding Style'
                ClassToSelf:
                    type: 'boolean'
                    default: 'false'
                    description: '"self" is preferred within class, trait or interface'
                ClassToStatic:
                    type: 'boolean'
                    default: 'false'
                    description: '"static" is preferred within class, trait or interface'
                ConvertOpenTagWithEcho:
                    type: 'boolean'
                    default: 'false'
                    description: 'Convert from "<?=" to "<?php echo "'
                DocBlockToComment:
                    type: 'boolean'
                    default: 'false'
                    description: 'Replace docblocks with regular comments when used in non structural elements'
                DoubleToSingleQuote:
                    type: 'boolean'
                    default: 'false'
                    description: 'Convert from double to single quotes'
                EncapsulateNamespaces:
                    type: 'boolean'
                    default: 'false'
                    description: 'Encapsulate namespaces with curly braces'
                GeneratePHPDoc:
                    type: 'boolean'
                    default: 'false'
                    description: 'Automatically generates PHPDoc blocks'
                IndentTernaryConditions:
                    type: 'boolean'
                    default: 'false'
                    description: 'Applies indentation to ternary conditions'
                JoinToImplode:
                    type: 'boolean'
                    default: 'false'
                    description: 'Replace implode() alias (join() -> implode())'
                LeftWordWrap:
                    type: 'boolean'
                    default: 'false'
                    description: 'Word wrap at 80 columns - left justify'
                LongArray:
                    type: 'boolean'
                    default: 'false'
                    description: 'Convert short to long arrays'
                MergeElseIf:
                    type: 'boolean'
                    default: 'false'
                    description: 'Merge if with else'
                MergeNamespaceWithOpenTag:
                    type: 'boolean'
                    default: 'false'
                    description: 'Ensure there is no more than one linebreak before namespace'
                MildAutoPreincrement:
                    type: 'boolean'
                    default: 'false'
                    description: 'Automatically convert postincrement to preincrement. (Deprecated pass. Use AutoPreincrement instead)'
                OrderMethod:
                    type: 'boolean'
                    default: 'false'
                    description: 'Sort methods within class in alphabetic order'
                OrderMethodAndVisibility:
                    type: 'boolean'
                    default: 'false'
                    description: 'Sort methods within class in alphabetic and visibility order'
                OrderAndRemoveUseClauses:
                    type: 'boolean'
                    default: 'false'
                    description: 'Order use block and remove unused imports'
                OnlyOrderUseClauses:
                    type: 'boolean'
                    default: 'false'
                    description: 'Order use block - do not remove unused imports'
                OrganizeClass:
                    type: 'boolean'
                    default: 'false'
                    description: 'Organize class structure (beta)'
                PrettyPrintDocBlocks:
                    type: 'boolean'
                    default: 'false'
                    description: 'Prettify Doc Blocks'
                PSR2EmptyFunction:
                    type: 'boolean'
                    default: 'false'
                    description: 'Merges in the same line of function header the body of empty functions'
                PSR2MultilineFunctionParams:
                    type: 'boolean'
                    default: 'false'
                    description: 'Break function parameters into multiple lines'
                ReindentAndAlignObjOps:
                    type: 'boolean'
                    default: 'false'
                    description: 'Align object operators'
                ReindentSwitchBlocks:
                    type: 'boolean'
                    default: 'false'
                    description: 'Reindent one level deeper the content of switch blocks'
                RemoveIncludeParentheses:
                    type: 'boolean'
                    default: 'false'
                    description: 'Remove parentheses from include declarations'
                RemoveUseLeadingSlash:
                    type: 'boolean'
                    default: 'false'
                    description: 'Remove leading slash in T_USE imports'
                ReplaceBooleanAndOr:
                    type: 'boolean'
                    default: 'false'
                    description: 'Convert from "and"/"or" to "&&"/"||". Danger! This pass leads to behavior change'
                ReplaceIsNull:
                    type: 'boolean'
                    default: 'false'
                    description: 'Replace is_null($a) with null === $a'
                ReturnNull:
                    type: 'boolean'
                    default: 'false'
                    description: 'Simplify empty returns'
                ShortArray:
                    type: 'boolean'
                    default: 'false'
                    description: 'Convert old array into new array. (array() -> [])'
                SmartLnAfterCurlyOpen:
                    type: 'boolean'
                    default: 'false'
                    description: 'Add line break when implicit curly block is added'
                SpaceAroundControlStructures:
                    type: 'boolean'
                    default: 'false'
                    description: 'Add space around control structures'
                SpaceBetweenMethods:
                    type: 'boolean'
                    default: 'false'
                    description: 'Put space between methods'
                StrictBehavior:
                    type: 'boolean'
                    default: 'false'
                    description: 'Activate strict option in array_search, base64_decode, in_array, array_keys, mb_detect_encoding. Danger! This pass leads to behavior change'
                StrictComparison:
                    type: 'boolean'
                    default: 'false'
                    description: 'All comparisons are converted to strict. Danger! This pass leads to behavior change'
                StripExtraCommaInArray:
                    type: 'boolean'
                    default: 'false'
                    description: 'Remove trailing commas within array blocks'
                StripNewlineAfterClassOpen:
                    type: 'boolean'
                    default: 'false'
                    description: 'Strip empty lines after class opening curly brace'
                StripNewlineAfterCurlyOpen:
                    type: 'boolean'
                    default: 'false'
                    description: 'Strip empty lines after opening curly brace'
                StripSpaces:
                    type: 'boolean'
                    default: 'false'
                    description: 'Remove all empty spaces'
                StripSpaceWithinControlStructures:
                    type: 'boolean'
                    default: 'false'
                    description: 'Strip empty lines within control structures'
                TightConcat:
                    type: 'boolean'
                    default: 'false'
                    description: 'Ensure string concatenation does not have spaces, except when close to numbers'
                UpgradeToPreg:
                    type: 'boolean'
                    default: 'false'
                    description: 'Upgrade ereg_* calls to preg_*'
                WordWrap:
                    type: 'boolean'
                    default: 'false'
                    description: 'Word wrap at 80 columns'
                WrongConstructorName:
                    type: 'boolean'
                    default: 'false'
                    description: 'Update old constructor names into new ones. http://php.net/manual/en/language.oop5.decon.php'
                YodaComparisons:
                    type: 'boolean'
                    default: 'false'
                    description: 'Execute Yoda Comparisons'
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
          selfUpdate:
              type: 'boolean',
              default: 'false',
              description: 'Self-update fmt.phar from Github - Will increase run time'
          settersAndGetters:
              type: 'boolean',
              default: 'false',
              description: 'Analyse classes for attributes and generate setters and getters'
          settersAndGettersType:
              type: 'string'
              enum: ['camel', 'snake', 'golang']
              default: 'camel'
              description: 'The type of setter/getter to generate'
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
          debug:
              type: 'boolean',
              default: 'false',
              description: 'Verbose output to console'

    activate: (state) ->
        # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
        @subscriptions = new CompositeDisposable

        # Register command that toggles this view
        @subscriptions.add atom.commands.add 'atom-workspace', 'phpfmt:format': => @format()

    deactivate: ->
        @subscriptions.dispose()

    format: ->
        atom.config.observe 'phpfmt.executablePath', =>
            @executablePath = atom.config.get 'phpfmt.executablePath'

        atom.config.observe 'phpfmt.pharPath', =>
            @pharPath = atom.config.get 'phpfmt.pharPath'

        atom.config.observe 'phpfmt.cache', =>
            @cache = atom.config.get 'phpfmt.cache'

        atom.config.observe 'phpfmt.cacheFilename', =>
            @cacheFilename = atom.config.get 'phpfmt.cacheFilename'

        atom.config.observe 'phpfmt.cakePhp', =>
            @cakePhp = atom.config.get 'phpfmt.cakePhp'

        atom.config.observe 'phpfmt.config', =>
            @config = atom.config.get 'phpfmt.config'

        atom.config.observe 'phpfmt.configFile', =>
            @configFile = atom.config.get 'phpfmt.configFile'

        atom.config.observe 'phpfmt.constructor', =>
            @constructor = atom.config.get 'phpfmt.constructor'

        atom.config.observe 'phpfmt.constructorType', =>
            @constructorType = atom.config.get 'phpfmt.constructorType'

        atom.config.observe 'phpfmt.autoAlign', =>
            @autoAlign = atom.config.get 'phpfmt.autoAlign'

        atom.config.observe 'phpfmt.exclude', =>
            @excludePasses = [];
            for pass, value of atom.config.get 'phpfmt.exclude'
                if value
                  @excludePasses.push(pass);
            @excludePasses = @excludePasses.join();

        atom.config.observe 'phpfmt.indentWithSpace', =>
            @indentWithSpace = atom.config.get 'phpfmt.indentWithSpace'

        atom.config.observe 'phpfmt.indentWithSpaceSize', =>
            @indentWithSpaceSize = atom.config.get 'phpfmt.indentWithSpaceSize'

        atom.config.observe 'phpfmt.lintBefore', =>
            @lintBefore = atom.config.get 'phpfmt.lintBefore'

        atom.config.observe 'phpfmt.noBackup', =>
            @noBackup = atom.config.get 'phpfmt.noBackup'

        atom.config.observe 'phpfmt.include', =>
            @passes = [];
            for pass, value of atom.config.get 'phpfmt.include'
                if value
                    @passes.push(pass);
            @passes = @passes.join(',');

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

        atom.config.observe 'phpfmt.settersAndGetters', =>
            @settersAndGetters = atom.config.get 'phpfmt.settersAndGetters'

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
        command = @executablePath

        # save file so we can format it
        editor.save();

        # options
        args = []
        args.push '-dshort_open_tag=On'
        args.push @pharPath
        args.push '-v' if @debug
        args.push '-o=' + filePath
        args.push '--cache' if @cache
        args.push '--cache=' + @cacheFilename if @cache && @cacheFilename.length != 0
        args.push '--cakephp' if @cakePhp
        args.push '--config=' + @configFile if @config && @configFile.length != 0
        args.push '--constructor=' + @constructorType if @constructor && @constructorType.length != 0
        args.push '--enable_auto_align' if !@autoAlign
        args.push '--exclude=' + @excludePasses if @excludePasses.length != 0
        args.push '--indent_with_space=' + @indentWithSpaceSize if @indentWithSpace && @indentWithSpaceSize.length != 0
        args.push '--lint-before' if @lintBefore
        args.push '--no-backup' if @noBackup
        args.push '--passes=' + @passes if @passes.length != 0
        args.push '--profile=' + @profileName if @profileName.length != 0 && @configFile.length != 0
        args.push '--psr1' if @psr1
        args.push '--psr1-naming' if @psr1Naming
        args.push '--psr2' if @psr2
        args.push '--selfupdate' if @selfUpdate
        args.push '--setters_and_getters=' + @settersAndGettersType if @settersAndGetters && @settersAndGettersType.length != 0
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
