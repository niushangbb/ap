// To make webstorm, I've commented out all the code that will be warned by jshint.
// If want to see jshint in action, just uncomment the code, red alert will be on the right side bar

//{
//    // JSHint Default Configuration File (as on JSHint website)
//    // See http://jshint.com/docs/ for more details

// some declarations
var x, a, obj = {};

//    "maxerr"        : 50,       // {int} Maximum error before stopping

//    // Enforcing
//    "bitwise"       : false,     // false: allow bitwise operators (&, |, ^, etc.)
// should not warn
a = 1|2;

//    "camelcase"     : false,    // false: Allow identifiers to be not in camelCase
// should not warn
var a_b;
// the two lines below is used to prevent unused var warning
a_b = 1;
a = a_b;

//    "curly"         : false,     // false: do not force {} for every new block or scope
// should not warn
if (a) a = 1;

//    "eqeqeq"        : false,     // false: Do not require triple equals (===) for comparison
// should not warn
a = 1==2;
a = 1!=2;

//    "forin"         : false,     // false: do not require filtering for..in loops with obj.hasOwnProperty()
// should not warn
// for-in without if (obj.hasOwnProperty(key)
for (var key in obj) {
    a = key;
}
// I think it's better to open this option to warn
// with this option closed, let's keep in mind on for-in

//   "freeze"        : true,     // true: prohibits overwriting prototypes of native objects such as Array, Date etc.
// should warn
//Date.prototype.x = function (){};

//    "immed"         : false,    // true: Require immediate invocations to be wrapped in parens e.g. `(function () { } ());`
// should warn
//function(){}();
// below is ok
(function(){})();

//    "indent"        : 4,        // {int} Number of spaces to use for indentation
// should warn
if (a) {
  a = 1;
}
// above it seems not work?

//    "latedef"       : "nofunc",    // true: Require variables/functions to be defined before being used
// should warn
// undeclared var
//console.log(undeclaredVar);
// should not warn
// late declaring function
window.f = f;
function f() {}

//    "newcap"        : false,    // false: do not require capitalization of all constructor functions e.g. `new F()`
// should not warn
a = new f();

//    "noarg"         : true,     // true: Prohibit use of `arguments.caller` and `arguments.callee`
// should warn
//function f(){
//    "use strict"
//    a = arguments.caller;
//    a = arguments.callee;
//}

//    "noempty"       : false,     // false: Do not prohibit use of empty blocks
// should not warn
if (a) {}

//    "nonbsp"        : true,     // true: Prohibit "non-breaking whitespace" characters.
// should not warn
a = 1;
  a = 2;
// this seems not work?

//   "nocomma"        : true,     // true: Prohibits the use of the comma operator. When misused, the comma operator can obscure the value of a statement and promote incorrect code.
// should warn
a = (1,2);
// this seems not work?

//    "nonew"         : true,    // true: Prohibit use of constructors for side-effects (without assignment)
// should not warn
function F() {}
a = F();
// this seems not work?

//    "plusplus"      : false,    // true: Prohibit use of `++` & `--`
// should not warn
a++;

//    "quotmark"      : false,    // Quotation mark consistency:
//    //   false    : do nothing (default)
//    //   true     : ensure whatever is used is consistent
//    //   "single" : require single quotes
//    //   "double" : require double quotes
// should not warn
a = ''+"";

//    "undef"         : true,     // true: Require all non-global variables to be declared (prevents global leaks)
// should warn
//globalVar = 1;

//    "unused"        : true,     // Unused variables:
//    //   true     : all variables, last function parameter
//    //   "vars"   : all variables only
//    //   "strict" : all variables, all function parameters
// should warn
//var unused = 1;

//    "strict"        : true,     // true: Requires all functions run in ES5 Strict Mode
// should not warn

//    "maxparams"     : false,    // {int} Max number of formal params allowed per function
//    "maxdepth"      : false,    // {int} Max depth of nested blocks (within functions)
//    "maxstatements" : false,    // {int} Max number statements per function
//    "maxcomplexity" : false,    // {int} Max cyclomatic complexity per function
//    "maxlen"        : false,    // {int} Max number of characters per line

//    // Relaxing
//    "asi"           : true,     // true: Tolerate Automatic Semicolon Insertion (no semicolons)
// should not warn
a = 1

//    "boss"          : false,     // true: Tolerate assignments where comparisons would be expected
// should not warn
//if (a=1) {}

//    "debug"         : false,     // true: Allow debugger statements e.g. browser breakpoints.
// should warn
//debugger;

//    "eqnull"        : true,     // true: Tolerate use of `== null`
// should not warn
a = a==null;

//    "es5"           : false,     // true: Allow ES5 syntax (ex: getters and setters)
// should warn
// es5 features

//    "esnext"        : false,     // true: Allow ES.next (ES6) syntax (ex: `const`)
// should not warn
//const x = 1;

//    "moz"           : false,     // true: Allow Mozilla specific syntax (extends and overrides esnext features)
// should warn

//    // (ex: `for each`, multiple try/catch, function expression…)
// should not warn

//    "evil"          : false,     // true: Tolerate use of `eval` and `new Function()`
// should warn
//eval('1');

//    "expr"          : true,     // true: Tolerate `ExpressionStatement` as Programs
// should not warn

//    "funcscope"     : true,     // false: Tolerate defining variables inside control statements
// should not warn
(function(){
    "use strict";
    if (a) {
        var b = 2;
        console.log(b);
    }
})();
// this seems not work

//    "globalstrict"  : true,     // false: Allow global "use strict" (also enables 'strict')
// should not warn

//    "iterator"      : false,     // true: Tolerate using the `__iterator__` property
// should warn

//    "lastsemic"     : true,     // true: Tolerate omitting a semicolon for the last statement of a 1-line block
// should not warn
a = 1

//    "laxbreak"      : true,     // true: Tolerate possibly unsafe line breakings
// should not warn
a = 1
  && 2;

//    "laxcomma"      : false,     // true: Tolerate comma-first style coding
// should warn
//a = {"a":1,}

//    "loopfunc"      : false,     // true: Tolerate functions being defined in loops
// should warn
//for (var x in obj) {
//    var b = (function(){"use strict"; console.log(x)});
//}
//b();

//    "multistr"      : false,     // true: Tolerate multi-line strings
// should warn
//a = "fsdaf
//    afsdas";

//    "noyield"       : false,     // true: Tolerate generator functions with no yield statement in them.
// should not warn

//   "notypeof"      : false,     // true: Prohibit invalid typeof operator values
// should warn
a = typeof 1 ==='intxxx';
// this seems not work

//    "proto"         : false,     // false: Prohibit using the `__proto__` property
// should warn below
//a = x.__proto__;

//    "scripturl"     : true,     // true: Tolerate script-targeted URLs
// should not warn

//    "shadow"        : true,     // true: Allows re-define variables later in code e.g. `var x=1; x=2;`
// should not warn
var x=1, x=2;

//    "sub"           : true,     // true: Tolerate using `[]` notation when it can still be expressed in dot notation
// should not warn
a = a['x']

//    "supernew"      : true,     // true: Tolerate `new function () { ... };` and `new Object;`
// should not warn

//    "validthis"     : true,     // true: Tolerate using this in a non-constructor function
// should not warn
var f = function(){
    "use strict";
    this.a = 1;
    return 1;
}
//    // Environments
//    "browser"       : true,     // Web Browser (window, document, etc)
//    "browserify"    : false,    // Browserify (node.js code in the browser)
//    "couch"         : false,    // CouchDB
//    "devel"         : true,     // Development/debugging (alert, confirm, etc)
//    "dojo"          : false,    // Dojo Toolkit
//    "jasmine"       : false,    // Jasmine
//    "jquery"        : false,    // jQuery
//    "mocha"         : true,     // Mocha
//    "mootools"      : false,    // MooTools
//    "node"          : false,    // Node.js
//    "nonstandard"   : false,    // Widely adopted globals (escape, unescape, etc)
//    "phantom"       : false,    // PhantomJS
//    "prototypejs"   : false,    // Prototype and Scriptaculous
//    "qunit"         : false,    // QUnit
//    "rhino"         : false,    // Rhino
//    "shelljs"       : false,    // ShellJS
//    "typed"         : false,    // Globals for typed array constructions
//    "worker"        : false,    // Web Workers
//    "wsh"           : false,    // Windows Scripting Host
//    "yui"           : false,    // Yahoo User Interface
//
//    // Custom Globals
//    // additional predefined global variables
//    //This option can be used to specify a white list of global variables that are not formally defined in the source code.
//    //This is most useful when combined with the undef option in order to suppress warnings for project-specific global variables.
//    //Setting an entry to true enables reading and writing to that variable.
//    //Setting it to false will trigger JSHint to consider that variable read-only.
//    "globals"       : {
//    "isNumber":false,
//        "edo":false,
//        "baseName":false,
//        "trace":false
//}

// the lines below are used to prevent unused variables warning
console.log(a, x);
//}