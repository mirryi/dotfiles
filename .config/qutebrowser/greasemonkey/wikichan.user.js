/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 3);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;(function() {
  // Public sightglass interface.
  function sightglass(obj, keypath, callback, options) {
    return new Observer(obj, keypath, callback, options)
  }

  // Batteries not included.
  sightglass.adapters = {}

  // Constructs a new keypath observer and kicks things off.
  function Observer(obj, keypath, callback, options) {
    this.options = options || {}
    this.options.adapters = this.options.adapters || {}
    this.obj = obj
    this.keypath = keypath
    this.callback = callback
    this.objectPath = []
    this.update = this.update.bind(this)
    this.parse()

    if (isObject(this.target = this.realize())) {
      this.set(true, this.key, this.target, this.callback)
    }
  }

  // Tokenizes the provided keypath string into interface + path tokens for the
  // observer to work with.
  Observer.tokenize = function(keypath, interfaces, root) {
    var tokens = []
    var current = {i: root, path: ''}
    var index, chr

    for (index = 0; index < keypath.length; index++) {
      chr = keypath.charAt(index)

      if (!!~interfaces.indexOf(chr)) {
        tokens.push(current)
        current = {i: chr, path: ''}
      } else {
        current.path += chr
      }
    }

    tokens.push(current)
    return tokens
  }

  // Parses the keypath using the interfaces defined on the view. Sets variables
  // for the tokenized keypath as well as the end key.
  Observer.prototype.parse = function() {
    var interfaces = this.interfaces()
    var root, path

    if (!interfaces.length) {
      error('Must define at least one adapter interface.')
    }

    if (!!~interfaces.indexOf(this.keypath[0])) {
      root = this.keypath[0]
      path = this.keypath.substr(1)
    } else {
      if (typeof (root = this.options.root || sightglass.root) === 'undefined') {
        error('Must define a default root adapter.')
      }

      path = this.keypath
    }

    this.tokens = Observer.tokenize(path, interfaces, root)
    this.key = this.tokens.pop()
  }

  // Realizes the full keypath, attaching observers for every key and correcting
  // old observers to any changed objects in the keypath.
  Observer.prototype.realize = function() {
    var current = this.obj
    var unreached = false
    var prev

    this.tokens.forEach(function(token, index) {
      if (isObject(current)) {
        if (typeof this.objectPath[index] !== 'undefined') {
          if (current !== (prev = this.objectPath[index])) {
            this.set(false, token, prev, this.update)
            this.set(true, token, current, this.update)
            this.objectPath[index] = current
          }
        } else {
          this.set(true, token, current, this.update)
          this.objectPath[index] = current
        }

        current = this.get(token, current)
      } else {
        if (unreached === false) {
          unreached = index
        }

        if (prev = this.objectPath[index]) {
          this.set(false, token, prev, this.update)
        }
      }
    }, this)

    if (unreached !== false) {
      this.objectPath.splice(unreached)
    }

    return current
  }

  // Updates the keypath. This is called when any intermediary key is changed.
  Observer.prototype.update = function() {
    var next, oldValue

    if ((next = this.realize()) !== this.target) {
      if (isObject(this.target)) {
        this.set(false, this.key, this.target, this.callback)
      }

      if (isObject(next)) {
        this.set(true, this.key, next, this.callback)
      }

      oldValue = this.value()
      this.target = next

      // Always call callback if value is a function. If not a function, call callback only if value changed
      if (this.value() instanceof Function || this.value() !== oldValue) this.callback()
    }
  }

  // Reads the current end value of the observed keypath. Returns undefined if
  // the full keypath is unreachable.
  Observer.prototype.value = function() {
    if (isObject(this.target)) {
      return this.get(this.key, this.target)
    }
  }

  // Sets the current end value of the observed keypath. Calling setValue when
  // the full keypath is unreachable is a no-op.
  Observer.prototype.setValue = function(value) {
    if (isObject(this.target)) {
      this.adapter(this.key).set(this.target, this.key.path, value)
    }
  }

  // Gets the provided key on an object.
  Observer.prototype.get = function(key, obj) {
    return this.adapter(key).get(obj, key.path)
  }

  // Observes or unobserves a callback on the object using the provided key.
  Observer.prototype.set = function(active, key, obj, callback) {
    var action = active ? 'observe' : 'unobserve'
    this.adapter(key)[action](obj, key.path, callback)
  }

  // Returns an array of all unique adapter interfaces available.
  Observer.prototype.interfaces = function() {
    var interfaces = Object.keys(this.options.adapters)

    Object.keys(sightglass.adapters).forEach(function(i) {
      if (!~interfaces.indexOf(i)) {
        interfaces.push(i)
      }
    })

    return interfaces
  }

  // Convenience function to grab the adapter for a specific key.
  Observer.prototype.adapter = function(key) {
    return this.options.adapters[key.i] ||
      sightglass.adapters[key.i]
  }

  // Unobserves the entire keypath.
  Observer.prototype.unobserve = function() {
    var obj

    this.tokens.forEach(function(token, index) {
      if (obj = this.objectPath[index]) {
        this.set(false, token, obj, this.update)
      }
    }, this)

    if (isObject(this.target)) {
      this.set(false, this.key, this.target, this.callback)
    }
  }

  // Check if a value is an object than can be observed.
  function isObject(obj) {
    return typeof obj === 'object' && obj !== null
  }

  // Error thrower.
  function error(message) {
    throw new Error('[sightglass] ' + message)
  }

  // Export module for Node and the browser.
  if ( true && module.exports) {
    module.exports = sightglass
  } else if (true) {
    !(__WEBPACK_AMD_DEFINE_ARRAY__ = [], __WEBPACK_AMD_DEFINE_RESULT__ = (function() {
      return this.sightglass = sightglass
    }).apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__),
				__WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__))
  } else {}
}).call(this);


/***/ }),
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
var Language = (function () {
    function Language(id, name, priority, disambId) {
        this.id = id;
        this.name = name;
        this.priority = priority;
        this.disambId = disambId;
    }
    Object.defineProperty(Language.prototype, "url", {
        get: function () {
            return "https://" + this.id.toLowerCase() + ".wikipedia.org";
        },
        enumerable: true,
        configurable: true
    });
    return Language;
}());
exports.Language = Language;
(function (Language) {
    Language.EN = new Language("EN", "English", 1, "Category:All article disambiguation pages");
})(Language = exports.Language || (exports.Language = {}));
exports.Language = Language;
var Page = (function () {
    function Page() {
        this.aliases = [];
        this.categories = [];
        this.extlinks = [];
        this.redirects = [];
    }
    Object.defineProperty(Page.prototype, "searchLink", {
        get: function () {
            return (this.lang.url +
                "/w/index.php?" +
                "profile=advanced&fulltext=1&search=" +
                this.searchPhrase);
        },
        enumerable: true,
        configurable: true
    });
    Object.defineProperty(Page.prototype, "isDisambiguation", {
        get: function () {
            return this.categories.indexOf(this.lang.disambId) !== -1;
        },
        enumerable: true,
        configurable: true
    });
    Page.prototype.equals = function (other) {
        if (other === null) {
            return false;
        }
        return this.id === other.id;
    };
    return Page;
}());
exports.Page = Page;
var Redirect = (function () {
    function Redirect(from, to) {
        this.from = from;
        this.to = to;
    }
    Redirect.fromJson = function (json) {
        return new Redirect(json.from, json.to);
    };
    return Redirect;
}());
exports.Redirect = Redirect;
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoicGFnZS5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzIjpbIi4uL3NyYy9wYWdlLnRzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7O0FBRUE7SUFNRSxrQkFBWSxFQUFVLEVBQUUsSUFBWSxFQUFFLFFBQWdCLEVBQUUsUUFBZ0I7UUFDdEUsSUFBSSxDQUFDLEVBQUUsR0FBRyxFQUFFLENBQUM7UUFDYixJQUFJLENBQUMsSUFBSSxHQUFHLElBQUksQ0FBQztRQUNqQixJQUFJLENBQUMsUUFBUSxHQUFHLFFBQVEsQ0FBQztRQUN6QixJQUFJLENBQUMsUUFBUSxHQUFHLFFBQVEsQ0FBQztJQUMzQixDQUFDO0lBRUQsc0JBQUkseUJBQUc7YUFBUDtZQUNFLE9BQU8sVUFBVSxHQUFHLElBQUksQ0FBQyxFQUFFLENBQUMsV0FBVyxFQUFFLEdBQUcsZ0JBQWdCLENBQUM7UUFDL0QsQ0FBQzs7O09BQUE7SUFDSCxlQUFDO0FBQUQsQ0FBQyxBQWhCRCxJQWdCQztBQWhCWSw0QkFBUTtBQWtCckIsV0FBYyxRQUFRO0lBQ1AsV0FBRSxHQUFHLElBQUksUUFBUSxDQUM1QixJQUFJLEVBQ0osU0FBUyxFQUNULENBQUMsRUFDRCwyQ0FBMkMsQ0FDNUMsQ0FBQztBQUNKLENBQUMsRUFQYSxRQUFRLEdBQVIsZ0JBQVEsS0FBUixnQkFBUSxRQU9yQjtBQXpCWSw0QkFBUTtBQTJCckI7SUFnQkU7UUFDRSxJQUFJLENBQUMsT0FBTyxHQUFHLEVBQUUsQ0FBQztRQUNsQixJQUFJLENBQUMsVUFBVSxHQUFHLEVBQUUsQ0FBQztRQUNyQixJQUFJLENBQUMsUUFBUSxHQUFHLEVBQUUsQ0FBQztRQUNuQixJQUFJLENBQUMsU0FBUyxHQUFHLEVBQUUsQ0FBQztJQUN0QixDQUFDO0lBRUQsc0JBQUksNEJBQVU7YUFBZDtZQUNFLE9BQU8sQ0FDTCxJQUFJLENBQUMsSUFBSSxDQUFDLEdBQUc7Z0JBQ2IsZUFBZTtnQkFDZixxQ0FBcUM7Z0JBQ3JDLElBQUksQ0FBQyxZQUFZLENBQ2xCLENBQUM7UUFDSixDQUFDOzs7T0FBQTtJQUVELHNCQUFJLGtDQUFnQjthQUFwQjtZQUNFLE9BQU8sSUFBSSxDQUFDLFVBQVUsQ0FBQyxPQUFPLENBQUMsSUFBSSxDQUFDLElBQUksQ0FBQyxRQUFRLENBQUMsS0FBSyxDQUFDLENBQUMsQ0FBQztRQUM1RCxDQUFDOzs7T0FBQTtJQUVELHFCQUFNLEdBQU4sVUFBTyxLQUFXO1FBQ2hCLElBQUksS0FBSyxLQUFLLElBQUksRUFBRTtZQUNsQixPQUFPLEtBQUssQ0FBQztTQUNkO1FBRUQsT0FBTyxJQUFJLENBQUMsRUFBRSxLQUFLLEtBQUssQ0FBQyxFQUFFLENBQUM7SUFDOUIsQ0FBQztJQUNILFdBQUM7QUFBRCxDQUFDLEFBM0NELElBMkNDO0FBM0NZLG9CQUFJO0FBNkNqQjtJQUlFLGtCQUFZLElBQVksRUFBRSxFQUFVO1FBQ2xDLElBQUksQ0FBQyxJQUFJLEdBQUcsSUFBSSxDQUFDO1FBQ2pCLElBQUksQ0FBQyxFQUFFLEdBQUcsRUFBRSxDQUFDO0lBQ2YsQ0FBQztJQUVNLGlCQUFRLEdBQWYsVUFBZ0IsSUFBa0M7UUFDaEQsT0FBTyxJQUFJLFFBQVEsQ0FBQyxJQUFJLENBQUMsSUFBSSxFQUFFLElBQUksQ0FBQyxFQUFFLENBQUMsQ0FBQztJQUMxQyxDQUFDO0lBQ0gsZUFBQztBQUFELENBQUMsQUFaRCxJQVlDO0FBWlksNEJBQVEiLCJzb3VyY2VzQ29udGVudCI6WyJpbXBvcnQgeyBFcXVhbHMgfSBmcm9tIFwiLi9zZXRcIjtcblxuZXhwb3J0IGNsYXNzIExhbmd1YWdlIHtcbiAgaWQ6IHN0cmluZztcbiAgcHJpb3JpdHk6IG51bWJlcjtcbiAgbmFtZTogc3RyaW5nO1xuICBkaXNhbWJJZDogc3RyaW5nO1xuXG4gIGNvbnN0cnVjdG9yKGlkOiBzdHJpbmcsIG5hbWU6IHN0cmluZywgcHJpb3JpdHk6IG51bWJlciwgZGlzYW1iSWQ6IHN0cmluZykge1xuICAgIHRoaXMuaWQgPSBpZDtcbiAgICB0aGlzLm5hbWUgPSBuYW1lO1xuICAgIHRoaXMucHJpb3JpdHkgPSBwcmlvcml0eTtcbiAgICB0aGlzLmRpc2FtYklkID0gZGlzYW1iSWQ7XG4gIH1cblxuICBnZXQgdXJsKCk6IHN0cmluZyB7XG4gICAgcmV0dXJuIFwiaHR0cHM6Ly9cIiArIHRoaXMuaWQudG9Mb3dlckNhc2UoKSArIFwiLndpa2lwZWRpYS5vcmdcIjtcbiAgfVxufVxuXG5leHBvcnQgbW9kdWxlIExhbmd1YWdlIHtcbiAgZXhwb3J0IGNvbnN0IEVOID0gbmV3IExhbmd1YWdlKFxuICAgIFwiRU5cIixcbiAgICBcIkVuZ2xpc2hcIixcbiAgICAxLFxuICAgIFwiQ2F0ZWdvcnk6QWxsIGFydGljbGUgZGlzYW1iaWd1YXRpb24gcGFnZXNcIlxuICApO1xufVxuXG5leHBvcnQgY2xhc3MgUGFnZSBpbXBsZW1lbnRzIEVxdWFsczxQYWdlPiB7XG4gIGlkOiBudW1iZXI7XG4gIHRpdGxlOiBzdHJpbmc7XG4gIHN1bW1hcnk6IHN0cmluZztcbiAgZGVzY3JpcHRpb246IHN0cmluZztcbiAgYWxpYXNlczogc3RyaW5nW107XG4gIGNhdGVnb3JpZXM6IHN0cmluZ1tdO1xuXG4gIGxhbmc6IExhbmd1YWdlO1xuICB1cmw6IHN0cmluZztcbiAgZWRpdFVybDogc3RyaW5nO1xuICBleHRsaW5rczogc3RyaW5nW107XG4gIHJlZGlyZWN0czogUmVkaXJlY3RbXTtcblxuICBzZWFyY2hQaHJhc2U6IHN0cmluZztcblxuICBjb25zdHJ1Y3RvcigpIHtcbiAgICB0aGlzLmFsaWFzZXMgPSBbXTtcbiAgICB0aGlzLmNhdGVnb3JpZXMgPSBbXTtcbiAgICB0aGlzLmV4dGxpbmtzID0gW107XG4gICAgdGhpcy5yZWRpcmVjdHMgPSBbXTtcbiAgfVxuXG4gIGdldCBzZWFyY2hMaW5rKCk6IHN0cmluZyB7XG4gICAgcmV0dXJuIChcbiAgICAgIHRoaXMubGFuZy51cmwgK1xuICAgICAgXCIvdy9pbmRleC5waHA/XCIgK1xuICAgICAgXCJwcm9maWxlPWFkdmFuY2VkJmZ1bGx0ZXh0PTEmc2VhcmNoPVwiICtcbiAgICAgIHRoaXMuc2VhcmNoUGhyYXNlXG4gICAgKTtcbiAgfVxuXG4gIGdldCBpc0Rpc2FtYmlndWF0aW9uKCk6IGJvb2xlYW4ge1xuICAgIHJldHVybiB0aGlzLmNhdGVnb3JpZXMuaW5kZXhPZih0aGlzLmxhbmcuZGlzYW1iSWQpICE9PSAtMTtcbiAgfVxuXG4gIGVxdWFscyhvdGhlcjogUGFnZSk6IGJvb2xlYW4ge1xuICAgIGlmIChvdGhlciA9PT0gbnVsbCkge1xuICAgICAgcmV0dXJuIGZhbHNlO1xuICAgIH1cblxuICAgIHJldHVybiB0aGlzLmlkID09PSBvdGhlci5pZDtcbiAgfVxufVxuXG5leHBvcnQgY2xhc3MgUmVkaXJlY3Qge1xuICBmcm9tOiBzdHJpbmc7XG4gIHRvOiBzdHJpbmc7XG5cbiAgY29uc3RydWN0b3IoZnJvbTogc3RyaW5nLCB0bzogc3RyaW5nKSB7XG4gICAgdGhpcy5mcm9tID0gZnJvbTtcbiAgICB0aGlzLnRvID0gdG87XG4gIH1cblxuICBzdGF0aWMgZnJvbUpzb24oanNvbjogeyBmcm9tOiBzdHJpbmc7IHRvOiBzdHJpbmcgfSkge1xuICAgIHJldHVybiBuZXcgUmVkaXJlY3QoanNvbi5mcm9tLCBqc29uLnRvKTtcbiAgfVxufVxuIl19

/***/ }),
/* 2 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


/*
  MIT License http://www.opensource.org/licenses/mit-license.php
  Author Tobias Koppers @sokra
*/
// css base code, injected by the css-loader
// eslint-disable-next-line func-names
module.exports = function (useSourceMap) {
  var list = []; // return the list of modules as css string

  list.toString = function toString() {
    return this.map(function (item) {
      var content = cssWithMappingToString(item, useSourceMap);

      if (item[2]) {
        return "@media ".concat(item[2], " {").concat(content, "}");
      }

      return content;
    }).join('');
  }; // import a list of modules into the list
  // eslint-disable-next-line func-names


  list.i = function (modules, mediaQuery, dedupe) {
    if (typeof modules === 'string') {
      // eslint-disable-next-line no-param-reassign
      modules = [[null, modules, '']];
    }

    var alreadyImportedModules = {};

    if (dedupe) {
      for (var i = 0; i < this.length; i++) {
        // eslint-disable-next-line prefer-destructuring
        var id = this[i][0];

        if (id != null) {
          alreadyImportedModules[id] = true;
        }
      }
    }

    for (var _i = 0; _i < modules.length; _i++) {
      var item = [].concat(modules[_i]);

      if (dedupe && alreadyImportedModules[item[0]]) {
        // eslint-disable-next-line no-continue
        continue;
      }

      if (mediaQuery) {
        if (!item[2]) {
          item[2] = mediaQuery;
        } else {
          item[2] = "".concat(mediaQuery, " and ").concat(item[2]);
        }
      }

      list.push(item);
    }
  };

  return list;
};

function cssWithMappingToString(item, useSourceMap) {
  var content = item[1] || ''; // eslint-disable-next-line prefer-destructuring

  var cssMapping = item[3];

  if (!cssMapping) {
    return content;
  }

  if (useSourceMap && typeof btoa === 'function') {
    var sourceMapping = toComment(cssMapping);
    var sourceURLs = cssMapping.sources.map(function (source) {
      return "/*# sourceURL=".concat(cssMapping.sourceRoot || '').concat(source, " */");
    });
    return [content].concat(sourceURLs).concat([sourceMapping]).join('\n');
  }

  return [content].join('\n');
} // Adapted from convert-source-map (MIT)


function toComment(sourceMap) {
  // eslint-disable-next-line no-undef
  var base64 = btoa(unescape(encodeURIComponent(JSON.stringify(sourceMap))));
  var data = "sourceMappingURL=data:application/json;charset=utf-8;base64,".concat(base64);
  return "/*# ".concat(data, " */");
}

/***/ }),
/* 3 */
/***/ (function(module, exports, __webpack_require__) {

module.exports = __webpack_require__(4);


/***/ }),
/* 4 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (_) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
var rivets_1 = __importDefault(__webpack_require__(5));
var page_1 = __webpack_require__(1);
var set_1 = __webpack_require__(7);
var query_1 = __webpack_require__(8);
var selector_1 = __webpack_require__(9);
var frame_html_1 = __importDefault(__webpack_require__(10));
var frame_scss_1 = __importDefault(__webpack_require__(11));
var inject_scss_1 = __importDefault(__webpack_require__(13));
var Wikichan = (function () {
    function Wikichan() {
        this.pages = new set_1.Set();
        this.frame = document.createElement("iframe");
        this.frame.id = "wikichan";
        this.frame.frameBorder = "0";
        this.frame.style.position = "fixed";
        this.frame.style.visibility = "hidden";
    }
    Wikichan.prototype.register = function (w) {
        w.addEventListener("mousedown", this.open.bind(this));
        w.document.body.appendChild(this.frame);
        if (!this.frameDocument) {
            return;
        }
        this.frameDocument.write(frame_html_1.default);
        addCSS(frame_scss_1.default, this.frameDocument);
        addCSS(inject_scss_1.default, window.document);
    };
    Wikichan.prototype.open = function (e) {
        return __awaiter(this, void 0, void 0, function () {
            var source, before, after, search;
            var _this = this;
            return __generator(this, function (_a) {
                this.unshow();
                this.pages.clear();
                if (!e.altKey) {
                    return [2];
                }
                source = selector_1.getSourceUnderCursor(e);
                if (!source) {
                    return [2];
                }
                for (before = 0; before < 4; before++) {
                    for (after = 0; after < 4; after++) {
                        search = source.phrase(before, after);
                        query_1.fetchExtract(search, page_1.Language.EN).then(function (p) {
                            if (p) {
                                _this.pages.add(p);
                            }
                        });
                    }
                }
                this.show(e.clientX, e.clientY, 475, 315);
                return [2];
            });
        });
    };
    Wikichan.prototype.show = function (left, top, width, height) {
        var _a;
        this.frame.style.width = width + "px";
        this.frame.style.height = height + "px";
        var offset = this.calculateOffset(left, top, width, height);
        var x = left + offset.x;
        var y = top + offset.y;
        this.frame.style.top = y + "px";
        this.frame.style.left = x + "px";
        this.frame.style.visibility = "visible";
        var frameBody = (_a = this.frameDocument) === null || _a === void 0 ? void 0 : _a.body;
        if (frameBody) {
            rivets_1.default.bind(frameBody, {
                pages: this.pages
            });
        }
        else {
        }
    };
    Wikichan.prototype.unshow = function () {
        this.frame.style.visibility = "hidden";
    };
    Wikichan.prototype.calculateOffset = function (x, y, w, h) {
        var offset = { x: 10, y: 10 };
        if (x + offset.x + w > window.innerWidth) {
            offset.x = -(offset.x + w);
        }
        if (y + offset.y + h > window.innerHeight) {
            offset.y = -(offset.y + h);
        }
        return offset;
    };
    Object.defineProperty(Wikichan.prototype, "frameDocument", {
        get: function () {
            var cw = this.frame.contentWindow;
            if (!cw) {
                return null;
            }
            return cw.document;
        },
        enumerable: true,
        configurable: true
    });
    Object.defineProperty(Wikichan.prototype, "frameResults", {
        get: function () {
            var dc = this.frameDocument;
            if (!dc) {
                return null;
            }
            return dc.getElementById("results");
        },
        enumerable: true,
        configurable: true
    });
    return Wikichan;
}());
exports.Wikichan = Wikichan;
function addCSS(sty, d) {
    var styleNode = d.createElement("style");
    styleNode.innerHTML = sty;
    d.body.appendChild(styleNode);
}
if (self == top) {
    var wikichan = new Wikichan();
    wikichan.register(window);
    console.log("wikichan: Loaded");
}
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoid2lraWNoYW4uanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi9zcmMvd2lraWNoYW4udHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6Ijs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7QUFFQSxrREFBNEI7QUFDNUIsK0JBQXdDO0FBQ3hDLDZCQUE0QjtBQUM1QixpQ0FBdUM7QUFDdkMsdUNBQWtEO0FBRWxELG1FQUE0QztBQUM1QyxtRUFBMkM7QUFDM0MscUVBQTZDO0FBRTdDO0lBSUU7UUFDRSxJQUFJLENBQUMsS0FBSyxHQUFHLElBQUksU0FBRyxFQUFRLENBQUM7UUFFN0IsSUFBSSxDQUFDLEtBQUssR0FBRyxRQUFRLENBQUMsYUFBYSxDQUFDLFFBQVEsQ0FBQyxDQUFDO1FBQzlDLElBQUksQ0FBQyxLQUFLLENBQUMsRUFBRSxHQUFHLFVBQVUsQ0FBQztRQUMzQixJQUFJLENBQUMsS0FBSyxDQUFDLFdBQVcsR0FBRyxHQUFHLENBQUM7UUFDN0IsSUFBSSxDQUFDLEtBQUssQ0FBQyxLQUFLLENBQUMsUUFBUSxHQUFHLE9BQU8sQ0FBQztRQUNwQyxJQUFJLENBQUMsS0FBSyxDQUFDLEtBQUssQ0FBQyxVQUFVLEdBQUcsUUFBUSxDQUFDO0lBQ3pDLENBQUM7SUFFRCwyQkFBUSxHQUFSLFVBQVMsQ0FBUztRQUNoQixDQUFDLENBQUMsZ0JBQWdCLENBQUMsV0FBVyxFQUFFLElBQUksQ0FBQyxJQUFJLENBQUMsSUFBSSxDQUFDLElBQUksQ0FBQyxDQUFDLENBQUM7UUFDdEQsQ0FBQyxDQUFDLFFBQVEsQ0FBQyxJQUFJLENBQUMsV0FBVyxDQUFDLElBQUksQ0FBQyxLQUFLLENBQUMsQ0FBQztRQUN4QyxJQUFJLENBQUMsSUFBSSxDQUFDLGFBQWEsRUFBRTtZQUN2QixPQUFPO1NBQ1I7UUFDRCxJQUFJLENBQUMsYUFBYSxDQUFDLEtBQUssQ0FBQyxvQkFBUyxDQUFDLENBQUM7UUFFcEMsTUFBTSxDQUFDLG9CQUFRLEVBQUUsSUFB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QVEsR0FBRyxJQUFJLFFBQVEsRUFBRSxDQUFDO0lBQ2hDLFFBQVEsQ0FBQyxRQUFRLENBQUMsTUFBTSxDQUFDLENBQUM7SUFDMUIsT0FBTyxDQUFDLEdBQUcsQ0FBQyxrQkFBa0IsQ0FBQyxDQUFDO0NBQ2pDIiwic291cmNlc0NvbnRlbnQiOlsiLy8vIDxyZWZlcmVuY2UgcGF0aD1cIi4vQHR5cGVzL3R5cGluZ3MuZC50c1wiIC8+XG5cbmltcG9ydCByaXZldHMgZnJvbSBcInJpdmV0c1wiO1xuaW1wb3J0IHsgTGFuZ3VhZ2UsIFBhZ2UgfSBmcm9tIFwiLi9wYWdlXCI7XG5pbXBvcnQgeyBTZXQgfSBmcm9tIFwiLi9zZXRcIjtcbmltcG9ydCB7IGZldGNoRXh0cmFjdCB9IGZyb20gXCIuL3F1ZXJ5XCI7XG5pbXBvcnQgeyBnZXRTb3VyY2VVbmRlckN1cnNvciB9IGZyb20gXCIuL3NlbGVjdG9yXCI7XG5cbmltcG9ydCBmcmFtZUhUTUwgZnJvbSBcIi4vc3RhdGljL2ZyYW1lLmh0bWxcIjtcbmltcG9ydCBmcmFtZUNTUyBmcm9tIFwiLi9zdGF0aWMvZnJhbWUuc2Nzc1wiO1xuaW1wb3J0IGluamVjdENTUyBmcm9tIFwiLi9zdGF0aWMvaW5qZWN0LnNjc3NcIjtcblxuZXhwb3J0IGNsYXNzIFdpa2ljaGFuIHtcbiAgcGFnZXM6IFNldDxQYWdlPjtcbiAgZnJhbWU6IEhUTUxJRnJhbWVFbGVtZW50O1xuXG4gIGNvbnN0cnVjdG9yKCkge1xuICAgIHRoaXMucGFnZXMgPSBuZXcgU2V0PFBhZ2U+KCk7XG5cbiAgICB0aGlzLmZyYW1lID0gZG9jdW1lbnQuY3JlYXRlRWxlbWVudChcImlmcmFtZVwiKTtcbiAgICB0aGlzLmZyYW1lLmlkID0gXCJ3aWtpY2hhblwiO1xuICAgIHRoaXMuZnJhbWUuZnJhbWVCb3JkZXIgPSBcIjBcIjtcbiAgICB0aGlzLmZyYW1lLnN0eWxlLnBvc2l0aW9uID0gXCJmaXhlZFwiO1xuICAgIHRoaXMuZnJhbWUuc3R5bGUudmlzaWJpbGl0eSA9IFwiaGlkZGVuXCI7XG4gIH1cblxuICByZWdpc3Rlcih3OiBXaW5kb3cpIHtcbiAgICB3LmFkZEV2ZW50TGlzdGVuZXIoXCJtb3VzZWRvd25cIiwgdGhpcy5vcGVuLmJpbmQodGhpcykpO1xuICAgIHcuZG9jdW1lbnQuYm9keS5hcHBlbmRDaGlsZCh0aGlzLmZyYW1lKTtcbiAgICBpZiAoIXRoaXMuZnJhbWVEb2N1bWVudCkge1xuICAgICAgcmV0dXJuO1xuICAgIH1cbiAgICB0aGlzLmZyYW1lRG9jdW1lbnQud3JpdGUoZnJhbWVIVE1MKTtcblxuICAgIGFkZENTUyhmcmFtZUNTUywgdGhpcy5mcmFtZURvY3VtZW50KTtcbiAgICBhZGRDU1MoaW5qZWN0Q1NTLCB3aW5kb3cuZG9jdW1lbnQpO1xuICB9XG5cbiAgYXN5bmMgb3BlbihlOiBNb3VzZUV2ZW50KTogUHJvbWlzZTx2b2lkPiB7XG4gICAgdGhpcy51bnNob3coKTtcbiAgICB0aGlzLnBhZ2VzLmNsZWFyKCk7XG5cbiAgICBpZiAoIWUuYWx0S2V5KSB7XG4gICAgICByZXR1cm47XG4gICAgfVxuXG4gICAgY29uc3Qgc291cmNlID0gZ2V0U291cmNlVW5kZXJDdXJzb3IoZSk7XG4gICAgaWYgKCFzb3VyY2UpIHtcbiAgICAgIHJldHVybjtcbiAgICB9XG5cbiAgICBmb3IgKGxldCBiZWZvcmUgPSAwOyBiZWZvcmUgPCA0OyBiZWZvcmUrKykge1xuICAgICAgZm9yIChsZXQgYWZ0ZXIgPSAwOyBhZnRlciA8IDQ7IGFmdGVyKyspIHtcbiAgICAgICAgY29uc3Qgc2VhcmNoID0gc291cmNlLnBocmFzZShiZWZvcmUsIGFmdGVyKTtcbiAgICAgICAgZmV0Y2hFeHRyYWN0KHNlYXJjaCwgTGFuZ3VhZ2UuRU4pLnRoZW4ocCA9PiB7XG4gICAgICAgICAgaWYgKHApIHtcbiAgICAgICAgICAgIHRoaXMucGFnZXMuYWRkKHApO1xuICAgICAgICAgIH1cbiAgICAgICAgfSk7XG4gICAgICB9XG4gICAgfVxuXG4gICAgdGhpcy5zaG93KGUuY2xpZW50WCwgZS5jbGllbnRZLCA0NzUsIDMxNSk7XG4gIH1cblxuICBzaG93KGxlZnQ6IG51bWJlciwgdG9wOiBudW1iZXIsIHdpZHRoOiBudW1iZXIsIGhlaWdodDogbnVtYmVyKSB7XG4gICAgdGhpcy5mcmFtZS5zdHlsZS53aWR0aCA9IGAke3dpZHRofXB4YDtcbiAgICB0aGlzLmZyYW1lLnN0eWxlLmhlaWdodCA9IGAke2hlaWdodH1weGA7XG5cbiAgICBjb25zdCBvZmZzZXQgPSB0aGlzLmNhbGN1bGF0ZU9mZnNldChsZWZ0LCB0b3AsIHdpZHRoLCBoZWlnaHQpO1xuICAgIGNvbnN0IHggPSBsZWZ0ICsgb2Zmc2V0Lng7XG4gICAgY29uc3QgeSA9IHRvcCArIG9mZnNldC55O1xuXG4gICAgdGhpcy5mcmFtZS5zdHlsZS50b3AgPSBgJHt5fXB4YDtcbiAgICB0aGlzLmZyYW1lLnN0eWxlLmxlZnQgPSBgJHt4fXB4YDtcbiAgICB0aGlzLmZyYW1lLnN0eWxlLnZpc2liaWxpdHkgPSBcInZpc2libGVcIjtcblxuICAgIGNvbnN0IGZyYW1lQm9keSA9IHRoaXMuZnJhbWVEb2N1bWVudD8uYm9keTtcbiAgICBpZiAoZnJhbWVCb2R5KSB7XG4gICAgICByaXZldHMuYmluZCg8SFRNTEVsZW1lbnQ+ZnJhbWVCb2R5LCB7XG4gICAgICAgIHBhZ2VzOiB0aGlzLnBhZ2VzXG4gICAgICB9KTtcbiAgICB9IGVsc2Uge1xuICAgICAgLy8gTG9nIGVycm9yXG4gICAgfVxuICB9XG5cbiAgdW5zaG93KCkge1xuICAgIHRoaXMuZnJhbWUuc3R5bGUudmlzaWJpbGl0eSA9IFwiaGlkZGVuXCI7XG4gIH1cblxuICBwcml2YXRlIGNhbGN1bGF0ZU9mZnNldChcbiAgICB4OiBudW1iZXIsXG4gICAgeTogbnVtYmVyLFxuICAgIHc6IG51bWJlcixcbiAgICBoOiBudW1iZXJcbiAgKTogeyB4OiBudW1iZXI7IHk6IG51bWJlciB9IHtcbiAgICBsZXQgb2Zmc2V0ID0geyB4OiAxMCwgeTogMTAgfTtcbiAgICBpZiAoeCArIG9mZnNldC54ICsgdyA+IHdpbmRvdy5pbm5lcldpZHRoKSB7XG4gICAgICBvZmZzZXQueCA9IC0ob2Zmc2V0LnggKyB3KTtcbiAgICB9XG5cbiAgICBpZiAoeSArIG9mZnNldC55ICsgaCA+IHdpbmRvdy5pbm5lckhlaWdodCkge1xuICAgICAgb2Zmc2V0LnkgPSAtKG9mZnNldC55ICsgaCk7XG4gICAgfVxuXG4gICAgcmV0dXJuIG9mZnNldDtcbiAgfVxuXG4gIGdldCBmcmFtZURvY3VtZW50KCk6IERvY3VtZW50IHwgbnVsbCB7XG4gICAgY29uc3QgY3cgPSB0aGlzLmZyYW1lLmNvbnRlbnRXaW5kb3c7XG4gICAgaWYgKCFjdykge1xuICAgICAgcmV0dXJuIG51bGw7XG4gICAgfVxuICAgIHJldHVybiBjdy5kb2N1bWVudDtcbiAgfVxuXG4gIGdldCBmcmFtZVJlc3VsdHMoKTogSFRNTEVsZW1lbnQgfCBudWxsIHtcbiAgICBjb25zdCBkYyA9IHRoaXMuZnJhbWVEb2N1bWVudDtcbiAgICBpZiAoIWRjKSB7XG4gICAgICByZXR1cm4gbnVsbDtcbiAgICB9XG4gICAgcmV0dXJuIGRjLmdldEVsZW1lbnRCeUlkKFwicmVzdWx0c1wiKTtcbiAgfVxufVxuXG5mdW5jdGlvbiBhZGRDU1Moc3R5OiBzdHJpbmcsIGQ6IERvY3VtZW50KSB7XG4gIGNvbnN0IHN0eWxlTm9kZSA9IGQuY3JlYXRlRWxlbWVudChcInN0eWxlXCIpO1xuICBzdHlsZU5vZGUuaW5uZXJIVE1MID0gc3R5O1xuICBkLmJvZHkuYXBwZW5kQ2hpbGQoc3R5bGVOb2RlKTtcbn1cblxuaWYgKHNlbGYgPT0gdG9wKSB7XG4gIGNvbnN0IHdpa2ljaGFuID0gbmV3IFdpa2ljaGFuKCk7XG4gIHdpa2ljaGFuLnJlZ2lzdGVyKHdpbmRvdyk7XG4gIGNvbnNvbGUubG9nKFwid2lraWNoYW46IExvYWRlZFwiKTtcbn1cbiJdfQ==

/***/ }),
/* 5 */
/***/ (function(module, exports, __webpack_require__) {

/* WEBPACK VAR INJECTION */(function(module) {var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;// Rivets.js
// version: 0.9.6
// author: Michael Richards
// license: MIT
(function() {
  var Rivets, bindMethod, jQuery, unbindMethod, _ref,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __slice = [].slice,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  Rivets = {
    options: ['prefix', 'templateDelimiters', 'rootInterface', 'preloadData', 'handler', 'executeFunctions'],
    extensions: ['binders', 'formatters', 'components', 'adapters'],
    "public": {
      binders: {},
      components: {},
      formatters: {},
      adapters: {},
      prefix: 'rv',
      templateDelimiters: ['{', '}'],
      rootInterface: '.',
      preloadData: true,
      executeFunctions: false,
      iterationAlias: function(modelName) {
        return '%' + modelName + '%';
      },
      handler: function(context, ev, binding) {
        return this.call(context, ev, binding.view.models);
      },
      configure: function(options) {
        var descriptor, key, option, value;
        if (options == null) {
          options = {};
        }
        for (option in options) {
          value = options[option];
          if (option === 'binders' || option === 'components' || option === 'formatters' || option === 'adapters') {
            for (key in value) {
              descriptor = value[key];
              Rivets[option][key] = descriptor;
            }
          } else {
            Rivets["public"][option] = value;
          }
        }
      },
      bind: function(el, models, options) {
        var view;
        if (models == null) {
          models = {};
        }
        if (options == null) {
          options = {};
        }
        view = new Rivets.View(el, models, options);
        view.bind();
        return view;
      },
      init: function(component, el, data) {
        var scope, template, view;
        if (data == null) {
          data = {};
        }
        if (el == null) {
          el = document.createElement('div');
        }
        component = Rivets["public"].components[component];
        template = component.template.call(this, el);
        if (template instanceof HTMLElement) {
          while (el.firstChild) {
            el.removeChild(el.firstChild);
          }
          el.appendChild(template);
        } else {
          el.innerHTML = template;
        }
        scope = component.initialize.call(this, el, data);
        view = new Rivets.View(el, scope);
        view.bind();
        return view;
      }
    }
  };

  if (window['jQuery'] || window['$']) {
    jQuery = window['jQuery'] || window['$'];
    _ref = 'on' in jQuery.prototype ? ['on', 'off'] : ['bind', 'unbind'], bindMethod = _ref[0], unbindMethod = _ref[1];
    Rivets.Util = {
      bindEvent: function(el, event, handler) {
        return jQuery(el)[bindMethod](event, handler);
      },
      unbindEvent: function(el, event, handler) {
        return jQuery(el)[unbindMethod](event, handler);
      },
      getInputValue: function(el) {
        var $el;
        $el = jQuery(el);
        if ($el.attr('type') === 'checkbox') {
          return $el.is(':checked');
        } else {
          return $el.val();
        }
      }
    };
  } else {
    Rivets.Util = {
      bindEvent: (function() {
        if ('addEventListener' in window) {
          return function(el, event, handler) {
            return el.addEventListener(event, handler, false);
          };
        }
        return function(el, event, handler) {
          return el.attachEvent('on' + event, handler);
        };
      })(),
      unbindEvent: (function() {
        if ('removeEventListener' in window) {
          return function(el, event, handler) {
            return el.removeEventListener(event, handler, false);
          };
        }
        return function(el, event, handler) {
          return el.detachEvent('on' + event, handler);
        };
      })(),
      getInputValue: function(el) {
        var o, _i, _len, _results;
        if (el.type === 'checkbox') {
          return el.checked;
        } else if (el.type === 'select-multiple') {
          _results = [];
          for (_i = 0, _len = el.length; _i < _len; _i++) {
            o = el[_i];
            if (o.selected) {
              _results.push(o.value);
            }
          }
          return _results;
        } else {
          return el.value;
        }
      }
    };
  }

  Rivets.TypeParser = (function() {
    function TypeParser() {}

    TypeParser.types = {
      primitive: 0,
      keypath: 1
    };

    TypeParser.parse = function(string) {
      if (/^'.*'$|^".*"$/.test(string)) {
        return {
          type: this.types.primitive,
          value: string.slice(1, -1)
        };
      } else if (string === 'true') {
        return {
          type: this.types.primitive,
          value: true
        };
      } else if (string === 'false') {
        return {
          type: this.types.primitive,
          value: false
        };
      } else if (string === 'null') {
        return {
          type: this.types.primitive,
          value: null
        };
      } else if (string === 'undefined') {
        return {
          type: this.types.primitive,
          value: void 0
        };
      } else if (string === '') {
        return {
          type: this.types.primitive,
          value: void 0
        };
      } else if (isNaN(Number(string)) === false) {
        return {
          type: this.types.primitive,
          value: Number(string)
        };
      } else {
        return {
          type: this.types.keypath,
          value: string
        };
      }
    };

    return TypeParser;

  })();

  Rivets.TextTemplateParser = (function() {
    function TextTemplateParser() {}

    TextTemplateParser.types = {
      text: 0,
      binding: 1
    };

    TextTemplateParser.parse = function(template, delimiters) {
      var index, lastIndex, lastToken, length, substring, tokens, value;
      tokens = [];
      length = template.length;
      index = 0;
      lastIndex = 0;
      while (lastIndex < length) {
        index = template.indexOf(delimiters[0], lastIndex);
        if (index < 0) {
          tokens.push({
            type: this.types.text,
            value: template.slice(lastIndex)
          });
          break;
        } else {
          if (index > 0 && lastIndex < index) {
            tokens.push({
              type: this.types.text,
              value: template.slice(lastIndex, index)
            });
          }
          lastIndex = index + delimiters[0].length;
          index = template.indexOf(delimiters[1], lastIndex);
          if (index < 0) {
            substring = template.slice(lastIndex - delimiters[1].length);
            lastToken = tokens[tokens.length - 1];
            if ((lastToken != null ? lastToken.type : void 0) === this.types.text) {
              lastToken.value += substring;
            } else {
              tokens.push({
                type: this.types.text,
                value: substring
              });
            }
            break;
          }
          value = template.slice(lastIndex, index).trim();
          tokens.push({
            type: this.types.binding,
            value: value
          });
          lastIndex = index + delimiters[1].length;
        }
      }
      return tokens;
    };

    return TextTemplateParser;

  })();

  Rivets.View = (function() {
    function View(els, models, options) {
      var k, option, v, _base, _i, _j, _len, _len1, _ref1, _ref2, _ref3, _ref4, _ref5;
      this.els = els;
      this.models = models;
      if (options == null) {
        options = {};
      }
      this.update = __bind(this.update, this);
      this.publish = __bind(this.publish, this);
      this.sync = __bind(this.sync, this);
      this.unbind = __bind(this.unbind, this);
      this.bind = __bind(this.bind, this);
      this.select = __bind(this.select, this);
      this.traverse = __bind(this.traverse, this);
      this.build = __bind(this.build, this);
      this.buildBinding = __bind(this.buildBinding, this);
      this.bindingRegExp = __bind(this.bindingRegExp, this);
      this.options = __bind(this.options, this);
      if (!(this.els.jquery || this.els instanceof Array)) {
        this.els = [this.els];
      }
      _ref1 = Rivets.extensions;
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        option = _ref1[_i];
        this[option] = {};
        if (options[option]) {
          _ref2 = options[option];
          for (k in _ref2) {
            v = _ref2[k];
            this[option][k] = v;
          }
        }
        _ref3 = Rivets["public"][option];
        for (k in _ref3) {
          v = _ref3[k];
          if ((_base = this[option])[k] == null) {
            _base[k] = v;
          }
        }
      }
      _ref4 = Rivets.options;
      for (_j = 0, _len1 = _ref4.length; _j < _len1; _j++) {
        option = _ref4[_j];
        this[option] = (_ref5 = options[option]) != null ? _ref5 : Rivets["public"][option];
      }
      this.build();
    }

    View.prototype.options = function() {
      var option, options, _i, _len, _ref1;
      options = {};
      _ref1 = Rivets.extensions.concat(Rivets.options);
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        option = _ref1[_i];
        options[option] = this[option];
      }
      return options;
    };

    View.prototype.bindingRegExp = function() {
      return new RegExp("^" + this.prefix + "-");
    };

    View.prototype.buildBinding = function(binding, node, type, declaration) {
      var context, ctx, dependencies, keypath, options, pipe, pipes;
      options = {};
      pipes = (function() {
        var _i, _len, _ref1, _results;
        _ref1 = declaration.match(/((?:'[^']*')*(?:(?:[^\|']*(?:'[^']*')+[^\|']*)+|[^\|]+))|^$/g);
        _results = [];
        for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
          pipe = _ref1[_i];
          _results.push(pipe.trim());
        }
        return _results;
      })();
      context = (function() {
        var _i, _len, _ref1, _results;
        _ref1 = pipes.shift().split('<');
        _results = [];
        for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
          ctx = _ref1[_i];
          _results.push(ctx.trim());
        }
        return _results;
      })();
      keypath = context.shift();
      options.formatters = pipes;
      if (dependencies = context.shift()) {
        options.dependencies = dependencies.split(/\s+/);
      }
      return this.bindings.push(new Rivets[binding](this, node, type, keypath, options));
    };

    View.prototype.build = function() {
      var el, parse, _i, _len, _ref1;
      this.bindings = [];
      parse = (function(_this) {
        return function(node) {
          var block, childNode, delimiters, n, parser, text, token, tokens, _i, _j, _len, _len1, _ref1;
          if (node.nodeType === 3) {
            parser = Rivets.TextTemplateParser;
            if (delimiters = _this.templateDelimiters) {
              if ((tokens = parser.parse(node.data, delimiters)).length) {
                if (!(tokens.length === 1 && tokens[0].type === parser.types.text)) {
                  for (_i = 0, _len = tokens.length; _i < _len; _i++) {
                    token = tokens[_i];
                    text = document.createTextNode(token.value);
                    node.parentNode.insertBefore(text, node);
                    if (token.type === 1) {
                      _this.buildBinding('TextBinding', text, null, token.value);
                    }
                  }
                  node.parentNode.removeChild(node);
                }
              }
            }
          } else if (node.nodeType === 1) {
            block = _this.traverse(node);
          }
          if (!block) {
            _ref1 = (function() {
              var _k, _len1, _ref1, _results;
              _ref1 = node.childNodes;
              _results = [];
              for (_k = 0, _len1 = _ref1.length; _k < _len1; _k++) {
                n = _ref1[_k];
                _results.push(n);
              }
              return _results;
            })();
            for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
              childNode = _ref1[_j];
              parse(childNode);
            }
          }
        };
      })(this);
      _ref1 = this.els;
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        el = _ref1[_i];
        parse(el);
      }
      this.bindings.sort(function(a, b) {
        var _ref2, _ref3;
        return (((_ref2 = b.binder) != null ? _ref2.priority : void 0) || 0) - (((_ref3 = a.binder) != null ? _ref3.priority : void 0) || 0);
      });
    };

    View.prototype.traverse = function(node) {
      var attribute, attributes, binder, bindingRegExp, block, identifier, regexp, type, value, _i, _j, _len, _len1, _ref1, _ref2, _ref3;
      bindingRegExp = this.bindingRegExp();
      block = node.nodeName === 'SCRIPT' || node.nodeName === 'STYLE';
      _ref1 = node.attributes;
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        attribute = _ref1[_i];
        if (bindingRegExp.test(attribute.name)) {
          type = attribute.name.replace(bindingRegExp, '');
          if (!(binder = this.binders[type])) {
            _ref2 = this.binders;
            for (identifier in _ref2) {
              value = _ref2[identifier];
              if (identifier !== '*' && identifier.indexOf('*') !== -1) {
                regexp = new RegExp("^" + (identifier.replace(/\*/g, '.+')) + "$");
                if (regexp.test(type)) {
                  binder = value;
                }
              }
            }
          }
          binder || (binder = this.binders['*']);
          if (binder.block) {
            block = true;
            attributes = [attribute];
          }
        }
      }
      _ref3 = attributes || node.attributes;
      for (_j = 0, _len1 = _ref3.length; _j < _len1; _j++) {
        attribute = _ref3[_j];
        if (bindingRegExp.test(attribute.name)) {
          type = attribute.name.replace(bindingRegExp, '');
          this.buildBinding('Binding', node, type, attribute.value);
        }
      }
      if (!block) {
        type = node.nodeName.toLowerCase();
        if (this.components[type] && !node._bound) {
          this.bindings.push(new Rivets.ComponentBinding(this, node, type));
          block = true;
        }
      }
      return block;
    };

    View.prototype.select = function(fn) {
      var binding, _i, _len, _ref1, _results;
      _ref1 = this.bindings;
      _results = [];
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        binding = _ref1[_i];
        if (fn(binding)) {
          _results.push(binding);
        }
      }
      return _results;
    };

    View.prototype.bind = function() {
      var binding, _i, _len, _ref1;
      _ref1 = this.bindings;
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        binding = _ref1[_i];
        binding.bind();
      }
    };

    View.prototype.unbind = function() {
      var binding, _i, _len, _ref1;
      _ref1 = this.bindings;
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        binding = _ref1[_i];
        binding.unbind();
      }
    };

    View.prototype.sync = function() {
      var binding, _i, _len, _ref1;
      _ref1 = this.bindings;
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        binding = _ref1[_i];
        if (typeof binding.sync === "function") {
          binding.sync();
        }
      }
    };

    View.prototype.publish = function() {
      var binding, _i, _len, _ref1;
      _ref1 = this.select(function(b) {
        var _ref1;
        return (_ref1 = b.binder) != null ? _ref1.publishes : void 0;
      });
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        binding = _ref1[_i];
        binding.publish();
      }
    };

    View.prototype.update = function(models) {
      var binding, key, model, _i, _len, _ref1;
      if (models == null) {
        models = {};
      }
      for (key in models) {
        model = models[key];
        this.models[key] = model;
      }
      _ref1 = this.bindings;
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        binding = _ref1[_i];
        if (typeof binding.update === "function") {
          binding.update(models);
        }
      }
    };

    return View;

  })();

  Rivets.Binding = (function() {
    function Binding(view, el, type, keypath, options) {
      this.view = view;
      this.el = el;
      this.type = type;
      this.keypath = keypath;
      this.options = options != null ? options : {};
      this.getValue = __bind(this.getValue, this);
      this.update = __bind(this.update, this);
      this.unbind = __bind(this.unbind, this);
      this.bind = __bind(this.bind, this);
      this.publish = __bind(this.publish, this);
      this.sync = __bind(this.sync, this);
      this.set = __bind(this.set, this);
      this.eventHandler = __bind(this.eventHandler, this);
      this.formattedValue = __bind(this.formattedValue, this);
      this.parseFormatterArguments = __bind(this.parseFormatterArguments, this);
      this.parseTarget = __bind(this.parseTarget, this);
      this.observe = __bind(this.observe, this);
      this.setBinder = __bind(this.setBinder, this);
      this.formatters = this.options.formatters || [];
      this.dependencies = [];
      this.formatterObservers = {};
      this.model = void 0;
      this.setBinder();
    }

    Binding.prototype.setBinder = function() {
      var identifier, regexp, value, _ref1;
      if (!(this.binder = this.view.binders[this.type])) {
        _ref1 = this.view.binders;
        for (identifier in _ref1) {
          value = _ref1[identifier];
          if (identifier !== '*' && identifier.indexOf('*') !== -1) {
            regexp = new RegExp("^" + (identifier.replace(/\*/g, '.+')) + "$");
            if (regexp.test(this.type)) {
              this.binder = value;
              this.args = new RegExp("^" + (identifier.replace(/\*/g, '(.+)')) + "$").exec(this.type);
              this.args.shift();
            }
          }
        }
      }
      this.binder || (this.binder = this.view.binders['*']);
      if (this.binder instanceof Function) {
        return this.binder = {
          routine: this.binder
        };
      }
    };

    Binding.prototype.observe = function(obj, keypath, callback) {
      return Rivets.sightglass(obj, keypath, callback, {
        root: this.view.rootInterface,
        adapters: this.view.adapters
      });
    };

    Binding.prototype.parseTarget = function() {
      var token;
      token = Rivets.TypeParser.parse(this.keypath);
      if (token.type === Rivets.TypeParser.types.primitive) {
        return this.value = token.value;
      } else {
        this.observer = this.observe(this.view.models, this.keypath, this.sync);
        return this.model = this.observer.target;
      }
    };

    Binding.prototype.parseFormatterArguments = function(args, formatterIndex) {
      var ai, arg, observer, processedArgs, _base, _i, _len;
      args = (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = args.length; _i < _len; _i++) {
          arg = args[_i];
          _results.push(Rivets.TypeParser.parse(arg));
        }
        return _results;
      })();
      processedArgs = [];
      for (ai = _i = 0, _len = args.length; _i < _len; ai = ++_i) {
        arg = args[ai];
        processedArgs.push(arg.type === Rivets.TypeParser.types.primitive ? arg.value : ((_base = this.formatterObservers)[formatterIndex] || (_base[formatterIndex] = {}), !(observer = this.formatterObservers[formatterIndex][ai]) ? (observer = this.observe(this.view.models, arg.value, this.sync), this.formatterObservers[formatterIndex][ai] = observer) : void 0, observer.value()));
      }
      return processedArgs;
    };

    Binding.prototype.formattedValue = function(value) {
      var args, fi, formatter, id, processedArgs, _i, _len, _ref1, _ref2;
      _ref1 = this.formatters;
      for (fi = _i = 0, _len = _ref1.length; _i < _len; fi = ++_i) {
        formatter = _ref1[fi];
        args = formatter.match(/[^\s']+|'([^']|'[^\s])*'|"([^"]|"[^\s])*"/g);
        id = args.shift();
        formatter = this.view.formatters[id];
        processedArgs = this.parseFormatterArguments(args, fi);
        if ((formatter != null ? formatter.read : void 0) instanceof Function) {
          value = (_ref2 = formatter.read).call.apply(_ref2, [this.model, value].concat(__slice.call(processedArgs)));
        } else if (formatter instanceof Function) {
          value = formatter.call.apply(formatter, [this.model, value].concat(__slice.call(processedArgs)));
        }
      }
      return value;
    };

    Binding.prototype.eventHandler = function(fn) {
      var binding, handler;
      handler = (binding = this).view.handler;
      return function(ev) {
        return handler.call(fn, this, ev, binding);
      };
    };

    Binding.prototype.set = function(value) {
      var _ref1;
      value = value instanceof Function && !this.binder["function"] && Rivets["public"].executeFunctions ? this.formattedValue(value.call(this.model)) : this.formattedValue(value);
      return (_ref1 = this.binder.routine) != null ? _ref1.call(this, this.el, value) : void 0;
    };

    Binding.prototype.sync = function() {
      var dependency, observer;
      return this.set((function() {
        var _i, _j, _len, _len1, _ref1, _ref2, _ref3;
        if (this.observer) {
          if (this.model !== this.observer.target) {
            _ref1 = this.dependencies;
            for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
              observer = _ref1[_i];
              observer.unobserve();
            }
            this.dependencies = [];
            if (((this.model = this.observer.target) != null) && ((_ref2 = this.options.dependencies) != null ? _ref2.length : void 0)) {
              _ref3 = this.options.dependencies;
              for (_j = 0, _len1 = _ref3.length; _j < _len1; _j++) {
                dependency = _ref3[_j];
                observer = this.observe(this.model, dependency, this.sync);
                this.dependencies.push(observer);
              }
            }
          }
          return this.observer.value();
        } else {
          return this.value;
        }
      }).call(this));
    };

    Binding.prototype.publish = function() {
      var args, fi, fiReversed, formatter, id, lastformatterIndex, processedArgs, value, _i, _len, _ref1, _ref2, _ref3;
      if (this.observer) {
        value = this.getValue(this.el);
        lastformatterIndex = this.formatters.length - 1;
        _ref1 = this.formatters.slice(0).reverse();
        for (fiReversed = _i = 0, _len = _ref1.length; _i < _len; fiReversed = ++_i) {
          formatter = _ref1[fiReversed];
          fi = lastformatterIndex - fiReversed;
          args = formatter.split(/\s+/);
          id = args.shift();
          processedArgs = this.parseFormatterArguments(args, fi);
          if ((_ref2 = this.view.formatters[id]) != null ? _ref2.publish : void 0) {
            value = (_ref3 = this.view.formatters[id]).publish.apply(_ref3, [value].concat(__slice.call(processedArgs)));
          }
        }
        return this.observer.setValue(value);
      }
    };

    Binding.prototype.bind = function() {
      var dependency, observer, _i, _len, _ref1, _ref2, _ref3;
      this.parseTarget();
      if ((_ref1 = this.binder.bind) != null) {
        _ref1.call(this, this.el);
      }
      if ((this.model != null) && ((_ref2 = this.options.dependencies) != null ? _ref2.length : void 0)) {
        _ref3 = this.options.dependencies;
        for (_i = 0, _len = _ref3.length; _i < _len; _i++) {
          dependency = _ref3[_i];
          observer = this.observe(this.model, dependency, this.sync);
          this.dependencies.push(observer);
        }
      }
      if (this.view.preloadData) {
        return this.sync();
      }
    };

    Binding.prototype.unbind = function() {
      var ai, args, fi, observer, _i, _len, _ref1, _ref2, _ref3, _ref4;
      if ((_ref1 = this.binder.unbind) != null) {
        _ref1.call(this, this.el);
      }
      if ((_ref2 = this.observer) != null) {
        _ref2.unobserve();
      }
      _ref3 = this.dependencies;
      for (_i = 0, _len = _ref3.length; _i < _len; _i++) {
        observer = _ref3[_i];
        observer.unobserve();
      }
      this.dependencies = [];
      _ref4 = this.formatterObservers;
      for (fi in _ref4) {
        args = _ref4[fi];
        for (ai in args) {
          observer = args[ai];
          observer.unobserve();
        }
      }
      return this.formatterObservers = {};
    };

    Binding.prototype.update = function(models) {
      var _ref1, _ref2;
      if (models == null) {
        models = {};
      }
      this.model = (_ref1 = this.observer) != null ? _ref1.target : void 0;
      return (_ref2 = this.binder.update) != null ? _ref2.call(this, models) : void 0;
    };

    Binding.prototype.getValue = function(el) {
      if (this.binder && (this.binder.getValue != null)) {
        return this.binder.getValue.call(this, el);
      } else {
        return Rivets.Util.getInputValue(el);
      }
    };

    return Binding;

  })();

  Rivets.ComponentBinding = (function(_super) {
    __extends(ComponentBinding, _super);

    function ComponentBinding(view, el, type) {
      var attribute, bindingRegExp, propertyName, token, _i, _len, _ref1, _ref2;
      this.view = view;
      this.el = el;
      this.type = type;
      this.unbind = __bind(this.unbind, this);
      this.bind = __bind(this.bind, this);
      this.locals = __bind(this.locals, this);
      this.component = this.view.components[this.type];
      this["static"] = {};
      this.observers = {};
      this.upstreamObservers = {};
      bindingRegExp = view.bindingRegExp();
      _ref1 = this.el.attributes || [];
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        attribute = _ref1[_i];
        if (!bindingRegExp.test(attribute.name)) {
          propertyName = this.camelCase(attribute.name);
          token = Rivets.TypeParser.parse(attribute.value);
          if (__indexOf.call((_ref2 = this.component["static"]) != null ? _ref2 : [], propertyName) >= 0) {
            this["static"][propertyName] = attribute.value;
          } else if (token.type === Rivets.TypeParser.types.primitive) {
            this["static"][propertyName] = token.value;
          } else {
            this.observers[propertyName] = attribute.value;
          }
        }
      }
    }

    ComponentBinding.prototype.sync = function() {};

    ComponentBinding.prototype.update = function() {};

    ComponentBinding.prototype.publish = function() {};

    ComponentBinding.prototype.locals = function() {
      var key, observer, result, value, _ref1, _ref2;
      result = {};
      _ref1 = this["static"];
      for (key in _ref1) {
        value = _ref1[key];
        result[key] = value;
      }
      _ref2 = this.observers;
      for (key in _ref2) {
        observer = _ref2[key];
        result[key] = observer.value();
      }
      return result;
    };

    ComponentBinding.prototype.camelCase = function(string) {
      return string.replace(/-([a-z])/g, function(grouped) {
        return grouped[1].toUpperCase();
      });
    };

    ComponentBinding.prototype.bind = function() {
      var k, key, keypath, observer, option, options, scope, v, _base, _i, _j, _len, _len1, _ref1, _ref2, _ref3, _ref4, _ref5, _ref6, _ref7;
      if (!this.bound) {
        _ref1 = this.observers;
        for (key in _ref1) {
          keypath = _ref1[key];
          this.observers[key] = this.observe(this.view.models, keypath, ((function(_this) {
            return function(key) {
              return function() {
                return _this.componentView.models[key] = _this.observers[key].value();
              };
            };
          })(this)).call(this, key));
        }
        this.bound = true;
      }
      if (this.componentView != null) {
        this.componentView.bind();
      } else {
        this.el.innerHTML = this.component.template.call(this);
        scope = this.component.initialize.call(this, this.el, this.locals());
        this.el._bound = true;
        options = {};
        _ref2 = Rivets.extensions;
        for (_i = 0, _len = _ref2.length; _i < _len; _i++) {
          option = _ref2[_i];
          options[option] = {};
          if (this.component[option]) {
            _ref3 = this.component[option];
            for (k in _ref3) {
              v = _ref3[k];
              options[option][k] = v;
            }
          }
          _ref4 = this.view[option];
          for (k in _ref4) {
            v = _ref4[k];
            if ((_base = options[option])[k] == null) {
              _base[k] = v;
            }
          }
        }
        _ref5 = Rivets.options;
        for (_j = 0, _len1 = _ref5.length; _j < _len1; _j++) {
          option = _ref5[_j];
          options[option] = (_ref6 = this.component[option]) != null ? _ref6 : this.view[option];
        }
        this.componentView = new Rivets.View(Array.prototype.slice.call(this.el.childNodes), scope, options);
        this.componentView.bind();
        _ref7 = this.observers;
        for (key in _ref7) {
          observer = _ref7[key];
          this.upstreamObservers[key] = this.observe(this.componentView.models, key, ((function(_this) {
            return function(key, observer) {
              return function() {
                return observer.setValue(_this.componentView.models[key]);
              };
            };
          })(this)).call(this, key, observer));
        }
      }
    };

    ComponentBinding.prototype.unbind = function() {
      var key, observer, _ref1, _ref2, _ref3;
      _ref1 = this.upstreamObservers;
      for (key in _ref1) {
        observer = _ref1[key];
        observer.unobserve();
      }
      _ref2 = this.observers;
      for (key in _ref2) {
        observer = _ref2[key];
        observer.unobserve();
      }
      return (_ref3 = this.componentView) != null ? _ref3.unbind.call(this) : void 0;
    };

    return ComponentBinding;

  })(Rivets.Binding);

  Rivets.TextBinding = (function(_super) {
    __extends(TextBinding, _super);

    function TextBinding(view, el, type, keypath, options) {
      this.view = view;
      this.el = el;
      this.type = type;
      this.keypath = keypath;
      this.options = options != null ? options : {};
      this.sync = __bind(this.sync, this);
      this.formatters = this.options.formatters || [];
      this.dependencies = [];
      this.formatterObservers = {};
    }

    TextBinding.prototype.binder = {
      routine: function(node, value) {
        return node.data = value != null ? value : '';
      }
    };

    TextBinding.prototype.sync = function() {
      return TextBinding.__super__.sync.apply(this, arguments);
    };

    return TextBinding;

  })(Rivets.Binding);

  Rivets["public"].binders.text = function(el, value) {
    if (el.textContent != null) {
      return el.textContent = value != null ? value : '';
    } else {
      return el.innerText = value != null ? value : '';
    }
  };

  Rivets["public"].binders.html = function(el, value) {
    return el.innerHTML = value != null ? value : '';
  };

  Rivets["public"].binders.show = function(el, value) {
    return el.style.display = value ? '' : 'none';
  };

  Rivets["public"].binders.hide = function(el, value) {
    return el.style.display = value ? 'none' : '';
  };

  Rivets["public"].binders.enabled = function(el, value) {
    return el.disabled = !value;
  };

  Rivets["public"].binders.disabled = function(el, value) {
    return el.disabled = !!value;
  };

  Rivets["public"].binders.checked = {
    publishes: true,
    priority: 2000,
    bind: function(el) {
      return Rivets.Util.bindEvent(el, 'change', this.publish);
    },
    unbind: function(el) {
      return Rivets.Util.unbindEvent(el, 'change', this.publish);
    },
    routine: function(el, value) {
      var _ref1;
      if (el.type === 'radio') {
        return el.checked = ((_ref1 = el.value) != null ? _ref1.toString() : void 0) === (value != null ? value.toString() : void 0);
      } else {
        return el.checked = !!value;
      }
    }
  };

  Rivets["public"].binders.unchecked = {
    publishes: true,
    priority: 2000,
    bind: function(el) {
      return Rivets.Util.bindEvent(el, 'change', this.publish);
    },
    unbind: function(el) {
      return Rivets.Util.unbindEvent(el, 'change', this.publish);
    },
    routine: function(el, value) {
      var _ref1;
      if (el.type === 'radio') {
        return el.checked = ((_ref1 = el.value) != null ? _ref1.toString() : void 0) !== (value != null ? value.toString() : void 0);
      } else {
        return el.checked = !value;
      }
    }
  };

  Rivets["public"].binders.value = {
    publishes: true,
    priority: 3000,
    bind: function(el) {
      if (!(el.tagName === 'INPUT' && el.type === 'radio')) {
        this.event = el.tagName === 'SELECT' ? 'change' : 'input';
        return Rivets.Util.bindEvent(el, this.event, this.publish);
      }
    },
    unbind: function(el) {
      if (!(el.tagName === 'INPUT' && el.type === 'radio')) {
        return Rivets.Util.unbindEvent(el, this.event, this.publish);
      }
    },
    routine: function(el, value) {
      var o, _i, _len, _ref1, _ref2, _ref3, _results;
      if (el.tagName === 'INPUT' && el.type === 'radio') {
        return el.setAttribute('value', value);
      } else if (window.jQuery != null) {
        el = jQuery(el);
        if ((value != null ? value.toString() : void 0) !== ((_ref1 = el.val()) != null ? _ref1.toString() : void 0)) {
          return el.val(value != null ? value : '');
        }
      } else {
        if (el.type === 'select-multiple') {
          if (value != null) {
            _results = [];
            for (_i = 0, _len = el.length; _i < _len; _i++) {
              o = el[_i];
              _results.push(o.selected = (_ref2 = o.value, __indexOf.call(value, _ref2) >= 0));
            }
            return _results;
          }
        } else if ((value != null ? value.toString() : void 0) !== ((_ref3 = el.value) != null ? _ref3.toString() : void 0)) {
          return el.value = value != null ? value : '';
        }
      }
    }
  };

  Rivets["public"].binders["if"] = {
    block: true,
    priority: 4000,
    bind: function(el) {
      var attr, declaration;
      if (this.marker == null) {
        attr = [this.view.prefix, this.type].join('-').replace('--', '-');
        declaration = el.getAttribute(attr);
        this.marker = document.createComment(" rivets: " + this.type + " " + declaration + " ");
        this.bound = false;
        el.removeAttribute(attr);
        el.parentNode.insertBefore(this.marker, el);
        return el.parentNode.removeChild(el);
      }
    },
    unbind: function() {
      if (this.nested) {
        this.nested.unbind();
        return this.bound = false;
      }
    },
    routine: function(el, value) {
      var key, model, models, _ref1;
      if (!!value === !this.bound) {
        if (value) {
          models = {};
          _ref1 = this.view.models;
          for (key in _ref1) {
            model = _ref1[key];
            models[key] = model;
          }
          (this.nested || (this.nested = new Rivets.View(el, models, this.view.options()))).bind();
          this.marker.parentNode.insertBefore(el, this.marker.nextSibling);
          return this.bound = true;
        } else {
          el.parentNode.removeChild(el);
          this.nested.unbind();
          return this.bound = false;
        }
      }
    },
    update: function(models) {
      var _ref1;
      return (_ref1 = this.nested) != null ? _ref1.update(models) : void 0;
    }
  };

  Rivets["public"].binders.unless = {
    block: true,
    priority: 4000,
    bind: function(el) {
      return Rivets["public"].binders["if"].bind.call(this, el);
    },
    unbind: function() {
      return Rivets["public"].binders["if"].unbind.call(this);
    },
    routine: function(el, value) {
      return Rivets["public"].binders["if"].routine.call(this, el, !value);
    },
    update: function(models) {
      return Rivets["public"].binders["if"].update.call(this, models);
    }
  };

  Rivets["public"].binders['on-*'] = {
    "function": true,
    priority: 1000,
    unbind: function(el) {
      if (this.handler) {
        return Rivets.Util.unbindEvent(el, this.args[0], this.handler);
      }
    },
    routine: function(el, value) {
      if (this.handler) {
        Rivets.Util.unbindEvent(el, this.args[0], this.handler);
      }
      return Rivets.Util.bindEvent(el, this.args[0], this.handler = this.eventHandler(value));
    }
  };

  Rivets["public"].binders['each-*'] = {
    block: true,
    priority: 4000,
    bind: function(el) {
      var attr, view, _i, _len, _ref1;
      if (this.marker == null) {
        attr = [this.view.prefix, this.type].join('-').replace('--', '-');
        this.marker = document.createComment(" rivets: " + this.type + " ");
        this.iterated = [];
        el.removeAttribute(attr);
        el.parentNode.insertBefore(this.marker, el);
        el.parentNode.removeChild(el);
      } else {
        _ref1 = this.iterated;
        for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
          view = _ref1[_i];
          view.bind();
        }
      }
    },
    unbind: function(el) {
      var view, _i, _len, _ref1;
      if (this.iterated != null) {
        _ref1 = this.iterated;
        for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
          view = _ref1[_i];
          view.unbind();
        }
      }
    },
    routine: function(el, collection) {
      var binding, data, i, index, key, model, modelName, options, previous, template, view, _i, _j, _k, _len, _len1, _len2, _ref1, _ref2, _ref3;
      modelName = this.args[0];
      collection = collection || [];
      if (this.iterated.length > collection.length) {
        _ref1 = Array(this.iterated.length - collection.length);
        for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
          i = _ref1[_i];
          view = this.iterated.pop();
          view.unbind();
          this.marker.parentNode.removeChild(view.els[0]);
        }
      }
      for (index = _j = 0, _len1 = collection.length; _j < _len1; index = ++_j) {
        model = collection[index];
        data = {
          index: index
        };
        data[Rivets["public"].iterationAlias(modelName)] = index;
        data[modelName] = model;
        if (this.iterated[index] == null) {
          _ref2 = this.view.models;
          for (key in _ref2) {
            model = _ref2[key];
            if (data[key] == null) {
              data[key] = model;
            }
          }
          previous = this.iterated.length ? this.iterated[this.iterated.length - 1].els[0] : this.marker;
          options = this.view.options();
          options.preloadData = true;
          template = el.cloneNode(true);
          view = new Rivets.View(template, data, options);
          view.bind();
          this.iterated.push(view);
          this.marker.parentNode.insertBefore(template, previous.nextSibling);
        } else if (this.iterated[index].models[modelName] !== model) {
          this.iterated[index].update(data);
        }
      }
      if (el.nodeName === 'OPTION') {
        _ref3 = this.view.bindings;
        for (_k = 0, _len2 = _ref3.length; _k < _len2; _k++) {
          binding = _ref3[_k];
          if (binding.el === this.marker.parentNode && binding.type === 'value') {
            binding.sync();
          }
        }
      }
    },
    update: function(models) {
      var data, key, model, view, _i, _len, _ref1;
      data = {};
      for (key in models) {
        model = models[key];
        if (key !== this.args[0]) {
          data[key] = model;
        }
      }
      _ref1 = this.iterated;
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        view = _ref1[_i];
        view.update(data);
      }
    }
  };

  Rivets["public"].binders['class-*'] = function(el, value) {
    var elClass;
    elClass = " " + el.className + " ";
    if (!value === (elClass.indexOf(" " + this.args[0] + " ") !== -1)) {
      return el.className = value ? "" + el.className + " " + this.args[0] : elClass.replace(" " + this.args[0] + " ", ' ').trim();
    }
  };

  Rivets["public"].binders['*'] = function(el, value) {
    if (value != null) {
      return el.setAttribute(this.type, value);
    } else {
      return el.removeAttribute(this.type);
    }
  };

  Rivets["public"].formatters['call'] = function() {
    var args, value;
    value = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    return value.call.apply(value, [this].concat(__slice.call(args)));
  };

  Rivets["public"].adapters['.'] = {
    id: '_rv',
    counter: 0,
    weakmap: {},
    weakReference: function(obj) {
      var id, _base, _name;
      if (!obj.hasOwnProperty(this.id)) {
        id = this.counter++;
        Object.defineProperty(obj, this.id, {
          value: id
        });
      }
      return (_base = this.weakmap)[_name = obj[this.id]] || (_base[_name] = {
        callbacks: {}
      });
    },
    cleanupWeakReference: function(ref, id) {
      if (!Object.keys(ref.callbacks).length) {
        if (!(ref.pointers && Object.keys(ref.pointers).length)) {
          return delete this.weakmap[id];
        }
      }
    },
    stubFunction: function(obj, fn) {
      var map, original, weakmap;
      original = obj[fn];
      map = this.weakReference(obj);
      weakmap = this.weakmap;
      return obj[fn] = function() {
        var callback, k, r, response, _i, _len, _ref1, _ref2, _ref3, _ref4;
        response = original.apply(obj, arguments);
        _ref1 = map.pointers;
        for (r in _ref1) {
          k = _ref1[r];
          _ref4 = (_ref2 = (_ref3 = weakmap[r]) != null ? _ref3.callbacks[k] : void 0) != null ? _ref2 : [];
          for (_i = 0, _len = _ref4.length; _i < _len; _i++) {
            callback = _ref4[_i];
            callback();
          }
        }
        return response;
      };
    },
    observeMutations: function(obj, ref, keypath) {
      var fn, functions, map, _base, _i, _len;
      if (Array.isArray(obj)) {
        map = this.weakReference(obj);
        if (map.pointers == null) {
          map.pointers = {};
          functions = ['push', 'pop', 'shift', 'unshift', 'sort', 'reverse', 'splice'];
          for (_i = 0, _len = functions.length; _i < _len; _i++) {
            fn = functions[_i];
            this.stubFunction(obj, fn);
          }
        }
        if ((_base = map.pointers)[ref] == null) {
          _base[ref] = [];
        }
        if (__indexOf.call(map.pointers[ref], keypath) < 0) {
          return map.pointers[ref].push(keypath);
        }
      }
    },
    unobserveMutations: function(obj, ref, keypath) {
      var idx, map, pointers;
      if (Array.isArray(obj) && (obj[this.id] != null)) {
        if (map = this.weakmap[obj[this.id]]) {
          if (pointers = map.pointers[ref]) {
            if ((idx = pointers.indexOf(keypath)) >= 0) {
              pointers.splice(idx, 1);
            }
            if (!pointers.length) {
              delete map.pointers[ref];
            }
            return this.cleanupWeakReference(map, obj[this.id]);
          }
        }
      }
    },
    observe: function(obj, keypath, callback) {
      var callbacks, desc, value;
      callbacks = this.weakReference(obj).callbacks;
      if (callbacks[keypath] == null) {
        callbacks[keypath] = [];
        desc = Object.getOwnPropertyDescriptor(obj, keypath);
        if (!((desc != null ? desc.get : void 0) || (desc != null ? desc.set : void 0))) {
          value = obj[keypath];
          Object.defineProperty(obj, keypath, {
            enumerable: true,
            get: function() {
              return value;
            },
            set: (function(_this) {
              return function(newValue) {
                var cb, map, _i, _len, _ref1;
                if (newValue !== value) {
                  _this.unobserveMutations(value, obj[_this.id], keypath);
                  value = newValue;
                  if (map = _this.weakmap[obj[_this.id]]) {
                    callbacks = map.callbacks;
                    if (callbacks[keypath]) {
                      _ref1 = callbacks[keypath].slice();
                      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
                        cb = _ref1[_i];
                        if (__indexOf.call(callbacks[keypath], cb) >= 0) {
                          cb();
                        }
                      }
                    }
                    return _this.observeMutations(newValue, obj[_this.id], keypath);
                  }
                }
              };
            })(this)
          });
        }
      }
      if (__indexOf.call(callbacks[keypath], callback) < 0) {
        callbacks[keypath].push(callback);
      }
      return this.observeMutations(obj[keypath], obj[this.id], keypath);
    },
    unobserve: function(obj, keypath, callback) {
      var callbacks, idx, map;
      if (map = this.weakmap[obj[this.id]]) {
        if (callbacks = map.callbacks[keypath]) {
          if ((idx = callbacks.indexOf(callback)) >= 0) {
            callbacks.splice(idx, 1);
            if (!callbacks.length) {
              delete map.callbacks[keypath];
              this.unobserveMutations(obj[keypath], obj[this.id], keypath);
            }
          }
          return this.cleanupWeakReference(map, obj[this.id]);
        }
      }
    },
    get: function(obj, keypath) {
      return obj[keypath];
    },
    set: function(obj, keypath, value) {
      return obj[keypath] = value;
    }
  };

  Rivets.factory = function(sightglass) {
    Rivets.sightglass = sightglass;
    Rivets["public"]._ = Rivets;
    return Rivets["public"];
  };

  if (typeof ( true && module !== null ? module.exports : void 0) === 'object') {
    module.exports = Rivets.factory(__webpack_require__(0));
  } else if (true) {
    !(__WEBPACK_AMD_DEFINE_ARRAY__ = [__webpack_require__(0)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(sightglass) {
      return this.rivets = Rivets.factory(sightglass);
    }).apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__),
				__WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));
  } else {}

}).call(this);

/* WEBPACK VAR INJECTION */}.call(this, __webpack_require__(6)(module)))

/***/ }),
/* 6 */
/***/ (function(module, exports) {

module.exports = function(module) {
	if (!module.webpackPolyfill) {
		module.deprecate = function() {};
		module.paths = [];
		// module.parent = undefined by default
		if (!module.children) module.children = [];
		Object.defineProperty(module, "loaded", {
			enumerable: true,
			get: function() {
				return module.l;
			}
		});
		Object.defineProperty(module, "id", {
			enumerable: true,
			get: function() {
				return module.i;
			}
		});
		module.webpackPolyfill = 1;
	}
	return module;
};


/***/ }),
/* 7 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
var Set = (function () {
    function Set(set) {
        this.elements = set || [];
    }
    Set.prototype.add = function (t) {
        if (!this.has(t)) {
            this.elements.push(t);
            return true;
        }
        return false;
    };
    Set.prototype.set = function (index, t) {
        var ex = this.elements[index];
        this.elements[index] = t;
        return ex;
    };
    Set.prototype.remove = function (t) {
        for (var i = 0; i < this.elements.length; i++) {
            if (this.elements[i].equals(t)) {
                var ex = this.elements[i];
                this.elements.splice(i, 1);
                return ex;
            }
        }
        return undefined;
    };
    Set.prototype.clear = function () {
        this.elements = [];
    };
    Set.prototype.has = function (t) {
        for (var _i = 0, _a = this.elements; _i < _a.length; _i++) {
            var elem = _a[_i];
            if (elem.equals(t)) {
                return true;
            }
        }
        return false;
    };
    Set.prototype.sort = function (comparator) {
        this.elements = this.elements.sort(comparator);
    };
    return Set;
}());
exports.Set = Set;
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2V0LmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsiLi4vc3JjL3NldC50cyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiOztBQUlBO0lBR0UsYUFBWSxHQUFTO1FBQ25CLElBQUksQ0FBQyxRQUFRLEdBQUcsR0FBRyxJQUFJLEVBQUUsQ0FBQztJQUM1QixDQUFDO0lBRUQsaUJBQUcsR0FBSCxVQUFJLENBQUk7UUFDTixJQUFJLENBQUMsSUFBSSxDQUFDLEdBQUcsQ0FBQyxDQUFDLENBQUMsRUFBRTtZQUNoQixJQUFJLENBQUMsUUFBUSxDQUFDLElBQUksQ0FBQyxDQUFDLENBQUMsQ0FBQztZQUN0QixPQUFPLElBQUksQ0FBQztTQUNiO1FBQ0QsT0FBTyxLQUFLLENBQUM7SUFDZixDQUFDO0lBRUQsaUJBQUcsR0FBSCxVQUFJLEtBQWEsRUFBRSxDQUFJO1FBQ3JCLElBQU0sRUFBRSxHQUFHLElBQUksQ0FBQyxRQUFRLENBQUMsS0FBSyxDQUFDLENBQUM7UUFDaEMsSUFBSSxDQUFDLFFBQVEsQ0FBQyxLQUFLLENBQUMsR0FBRyxDQUFDLENBQUM7UUFDekIsT0FBTyxFQUFFLENBQUM7SUFDWixDQUFDO0lBRUQsb0JBQU0sR0FBTixVQUFPLENBQUk7UUFDVCxLQUFLLElBQUksQ0FBQyxHQUFHLENBQUMsRUFBRSxDQUFDLEdBQUcsSUFBSSxDQUFDLFFBQVEsQ0FBQyxNQUFNLEVBQUUsQ0FBQyxFQUFFLEVBQUU7WUFDN0MsSUFBSSxJQUFJLENBQUMsUUFBUSxDQUFDLENBQUMsQ0FBQyxDQUFDLE1BQU0sQ0FBQyxDQUFDLENBQUMsRUFBRTtnQkFDOUIsSUFBTSxFQUFFLEdBQUcsSUFBSSxDQUFDLFFBQVEsQ0FBQyxDQUFDLENBQUMsQ0FBQztnQkFDNUIsSUFBSSxDQUFDLFFBQVEsQ0FBQyxNQUFNLENBQUMsQ0FBQyxFQUFFLENBQUMsQ0FBQyxDQUFDO2dCQUMzQixPQUFPLEVBQUUsQ0FBQzthQUNYO1NBQ0Y7UUFDRCxPQUFPLFNBQVMsQ0FBQztJQUNuQixDQUFDO0lBRUQsbUJBQUssR0FBTDtRQUNFLElBQUksQ0FBQyxRQUFRLEdBQUcsRUFBRSxDQUFDO0lBQ3JCLENBQUM7SUFFRCxpQkFBRyxHQUFILFVBQUksQ0FBSTtRQUNOLEtBQWlCLFVBQWEsRUFBYixLQUFBLElBQUksQ0FBQyxRQUFRLEVBQWIsY0FBYSxFQUFiLElBQWEsRUFBRTtZQUEzQixJQUFJLElBQUksU0FBQTtZQUNYLElBQUksSUFBSSxDQUFDLE1BQU0sQ0FBQyxDQUFDLENBQUMsRUFBRTtnQkFDbEIsT0FBTyxJQUFJLENBQUM7YUFDYjtTQUNGO1FBQ0QsT0FBTyxLQUFLLENBQUM7SUFDZixDQUFDO0lBRUQsa0JBQUksR0FBSixVQUFLLFVBQWtDO1FBQ3JDLElBQUksQ0FBQyxRQUFRLEdBQUcsSUFBSSxDQUFDLFFBQVEsQ0FBQyxJQUFJLENBQUMsVUFBVSxDQUFDLENBQUM7SUFDakQsQ0FBQztJQUNILFVBQUM7QUFBRCxDQUFDLEFBaERELElBZ0RDO0FBaERZLGtCQUFHIiwic291cmNlc0NvbnRlbnQiOlsiZXhwb3J0IGludGVyZmFjZSBFcXVhbHM8VD4ge1xuICBlcXVhbHMob3RoZXI6IFQpOiBib29sZWFuO1xufVxuXG5leHBvcnQgY2xhc3MgU2V0PFQgZXh0ZW5kcyBFcXVhbHM8VD4+IHtcbiAgZWxlbWVudHM6IFRbXTtcblxuICBjb25zdHJ1Y3RvcihzZXQ/OiBUW10pIHtcbiAgICB0aGlzLmVsZW1lbnRzID0gc2V0IHx8IFtdO1xuICB9XG5cbiAgYWRkKHQ6IFQpOiBib29sZWFuIHtcbiAgICBpZiAoIXRoaXMuaGFzKHQpKSB7XG4gICAgICB0aGlzLmVsZW1lbnRzLnB1c2godCk7XG4gICAgICByZXR1cm4gdHJ1ZTtcbiAgICB9XG4gICAgcmV0dXJuIGZhbHNlO1xuICB9XG5cbiAgc2V0KGluZGV4OiBudW1iZXIsIHQ6IFQpOiBUIHtcbiAgICBjb25zdCBleCA9IHRoaXMuZWxlbWVudHNbaW5kZXhdO1xuICAgIHRoaXMuZWxlbWVudHNbaW5kZXhdID0gdDtcbiAgICByZXR1cm4gZXg7XG4gIH1cblxuICByZW1vdmUodDogVCk6IFQgfCB1bmRlZmluZWQge1xuICAgIGZvciAobGV0IGkgPSAwOyBpIDwgdGhpcy5lbGVtZW50cy5sZW5ndGg7IGkrKykge1xuICAgICAgaWYgKHRoaXMuZWxlbWVudHNbaV0uZXF1YWxzKHQpKSB7XG4gICAgICAgIGNvbnN0IGV4ID0gdGhpcy5lbGVtZW50c1tpXTtcbiAgICAgICAgdGhpcy5lbGVtZW50cy5zcGxpY2UoaSwgMSk7XG4gICAgICAgIHJldHVybiBleDtcbiAgICAgIH1cbiAgICB9XG4gICAgcmV0dXJuIHVuZGVmaW5lZDtcbiAgfVxuXG4gIGNsZWFyKCk6IHZvaWQge1xuICAgIHRoaXMuZWxlbWVudHMgPSBbXTtcbiAgfVxuXG4gIGhhcyh0OiBUKTogYm9vbGVhbiB7XG4gICAgZm9yIChsZXQgZWxlbSBvZiB0aGlzLmVsZW1lbnRzKSB7XG4gICAgICBpZiAoZWxlbS5lcXVhbHModCkpIHtcbiAgICAgICAgcmV0dXJuIHRydWU7XG4gICAgICB9XG4gICAgfVxuICAgIHJldHVybiBmYWxzZTtcbiAgfVxuXG4gIHNvcnQoY29tcGFyYXRvcjogKGE6IFQsIGI6IFQpID0+IG51bWJlcik6IHZvaWQge1xuICAgIHRoaXMuZWxlbWVudHMgPSB0aGlzLmVsZW1lbnRzLnNvcnQoY29tcGFyYXRvcik7XG4gIH1cbn1cbiJdfQ==

/***/ }),
/* 8 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (_) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
Object.defineProperty(exports, "__esModule", { value: true });
var page_1 = __webpack_require__(1);
function fetchExtract(name, lang) {
    return __awaiter(this, void 0, void 0, function () {
        var query;
        return __generator(this, function (_a) {
            query = constructQuery(name, lang);
            return [2, fetch(query.url)
                    .then(function (res) {
                    if (res.status !== 200) {
                        return;
                    }
                    return res;
                })
                    .then(function (res) { var _a; return (_a = res) === null || _a === void 0 ? void 0 : _a.json(); })
                    .then(function (data) { return data.query; })
                    .then(function (data) {
                    if (Object.keys(data.pages).indexOf("-1") !== -1 &&
                        Object.keys(data.pages).length === 1) {
                        return null;
                    }
                    var page = new page_1.Page();
                    var entry = data.pages[Object.keys(data.pages)[0]];
                    if (data.normalized) {
                        data.normalized.forEach(function (norm) {
                            page.redirects.push(norm);
                        });
                    }
                    if (entry.categories) {
                        entry.categories.forEach(function (c) {
                            page.categories.push(c.title);
                        });
                    }
                    if (entry.extlinks) {
                        entry.extlinks.forEach(function (link) {
                            page.extlinks.push(link["*"]);
                        });
                    }
                    if (entry.terms.alias) {
                        entry.terms.alias.forEach(function (alias) {
                            page.aliases.push(alias);
                        });
                    }
                    page.id = entry.pageid;
                    page.title = entry.title;
                    page.url = entry.fullurl;
                    page.editUrl = entry.editurl;
                    page.description = entry.description;
                    page.summary = entry.extract;
                    page.lang = lang;
                    page.searchPhrase = name;
                    return page;
                })];
        });
    });
}
exports.fetchExtract = fetchExtract;
function constructQuery(article, lang) {
    var endpoint = "https://" + lang.id.toLowerCase() + ".wikipedia.org/w/api.php?";
    var query = new WikiQuery(endpoint);
    query
        .addParam("action", "query")
        .addParam("prop", "info|description|categories|extlinks|pageterms|extracts&exintro")
        .addParam("inprop", "url")
        .addParam("redirects", "1")
        .addParam("titles", article);
    return query;
}
var WikiQuery = (function () {
    function WikiQuery(endpoint) {
        this.endpoint = endpoint;
        this.params = new Array();
        this.addParam("origin", "*").addParam("format", "json");
    }
    WikiQuery.prototype.addParam = function (key, value) {
        var param = new WikiQueryParams(key, value);
        this.params.push(param);
        return this;
    };
    Object.defineProperty(WikiQuery.prototype, "url", {
        get: function () {
            var query = this.endpoint;
            this.params.forEach(function (p) {
                query += p.join() + "&";
            });
            return query;
        },
        enumerable: true,
        configurable: true
    });
    return WikiQuery;
}());
var WikiQueryParams = (function () {
    function WikiQueryParams(key, value) {
        this.key = key;
        this.value = value;
    }
    WikiQueryParams.prototype.join = function () {
        return this.key + "=" + this.value;
    };
    return WikiQueryParams;
}());
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoicXVlcnkuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi9zcmMvcXVlcnkudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6Ijs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7QUFBQSwrQkFBa0Q7QUFFbEQsU0FBc0IsWUFBWSxDQUFDLElBQVksRUFBRSxJQUFjOzs7O1lBQ3ZELEtBQUssR0FBRyxjQUFjLENBQUMsSUFBSSxFQUFFLElBQUksQ0FBQyxDQUFDO1lBRXpDLFdBQU8sS0FBSyxDQUFDLEtBQUssQ0FBQyxHQUFHLENBQUM7cUJBQ3BCLElBQUksQ0FBQyxVQUFBLEdBQUc7b0JBQ1AsSUFBSSxHQUFHLENBQUMsTUFBTSxLQUFLLEdBQUcsRUFBRTt3QkFDdEIsT0FBTztxQkFDUjtvQkFFRCxPQUFPLEdBQUcsQ0FBQztnQkFDYixDQUFDLENBQUM7cUJBQ0QsSUFBSSxDQUFDLFVBQUEsR0FBRyx5QkFBSSxHQUFHLDBDQUFFLElBQUksS0FBRSxDQUFDO3FCQUN4QixJQUFJLENBQUMsVUFBQyxJQUEyQyxJQUFLLE9BQUEsSUFBSSxDQUFDLEtBQUssRUFBVixDQUFVLENBQUM7cUJBQ2pFLElBQUksQ0FBQyxVQUFDLElBQWdFO29CQUNyRSxJQUNFLE1BQU0sQ0FBQyxJQUFJLENBQUMsSUFBSSxDQUFDLEtBQUssQ0FBQyxDQUFDLE9BQU8sQ0FBQyxJQUFJLENBQUMsS0FBSyxDQUFDLENBQUM7d0JBQzVDLE1BQU0sQ0FBQyxJQUFJLENBQUMsSUFBSSxDQUFDLEtBQUssQ0FBQyxDQUFDLE1BQU0sS0FBSyxDQUFDLEVBQ3BDO3dCQUNBLE9BQU8sSUFBSSxDQUFDO3FCQUNiO29CQUVELElBQU0sSUFBSSxHQUFHLElBQUksV0FBSSxFQUFFLENBQUM7b0JBQ3hCLElBQU0sS0FBSyxHQUFrQixJQUFJLENBQUMsS0FBSyxDQUFDLE1BQU0sQ0FBQyxJQUFJLENBQUMsSUFBSSxDQUFDLEtBQUssQ0FBQyxDQUFDLENBQUMsQ0FBQyxDQUFDLENBQUM7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QUMsTUFBTSxDQUFDLElBQUksQ0FBQyxLQUFLLENBQUMsQ0FBQztRQUN4QixPQUFPLElBQUksQ0FBQztJQUNkLENBQUM7SUFFRCxzQkFBSSwwQkFBRzthQUFQO1lBQ0UsSUFBSSxLQUFLLEdBQVcsSUFBSSxDQUFDLFFBQVEsQ0FBQztZQUNsQyxJQUFJLENBQUMsTUFBTSxDQUFDLE9BQU8sQ0FBQyxVQUFBLENBQUM7Z0JBQ25CLEtBQUssSUFBSSxDQUFDLENBQUMsSUFBSSxFQUFFLEdBQUcsR0FBRyxDQUFDO1lBQzFCLENBQUMsQ0FBQyxDQUFDO1lBQ0gsT0FBTyxLQUFLLENBQUM7UUFDZixDQUFDOzs7T0FBQTtJQUNILGdCQUFDO0FBQUQsQ0FBQyxBQXhCRCxJQXdCQztBQUVEO0lBSUUseUJBQVksR0FBVyxFQUFFLEtBQWE7UUFDcEMsSUFBSSxDQUFDLEdBQUcsR0FBRyxHQUFHLENBQUM7UUFDZixJQUFJLENBQUMsS0FBSyxHQUFHLEtBQUssQ0FBQztJQUNyQixDQUFDO0lBRUQsOEJBQUksR0FBSjtRQUNFLE9BQU8sSUFBSSxDQUFDLEdBQUcsR0FBRyxHQUFHLEdBQUcsSUFBSSxDQUFDLEtBQUssQ0FBQztJQUNyQyxDQUFDO0lBQ0gsc0JBQUM7QUFBRCxDQUFDLEFBWkQsSUFZQyIsInNvdXJjZXNDb250ZW50IjpbImltcG9ydCB7IExhbmd1YWdlLCBQYWdlLCBSZWRpcmVjdCB9IGZyb20gXCIuL3BhZ2VcIjtcblxuZXhwb3J0IGFzeW5jIGZ1bmN0aW9uIGZldGNoRXh0cmFjdChuYW1lOiBzdHJpbmcsIGxhbmc6IExhbmd1YWdlKTogUHJvbWlzZTxQYWdlIHwgbnVsbD4ge1xuICBjb25zdCBxdWVyeSA9IGNvbnN0cnVjdFF1ZXJ5KG5hbWUsIGxhbmcpO1xuXG4gIHJldHVybiBmZXRjaChxdWVyeS51cmwpXG4gICAgLnRoZW4ocmVzID0+IHtcbiAgICAgIGlmIChyZXMuc3RhdHVzICE9PSAyMDApIHtcbiAgICAgICAgcmV0dXJuO1xuICAgICAgfVxuXG4gICAgICByZXR1cm4gcmVzO1xuICAgIH0pXG4gICAgLnRoZW4ocmVzID0+IHJlcz8uanNvbigpKVxuICAgIC50aGVuKChkYXRhOiB7IGJhdGNoY29tcGxldGU6IHN0cmluZzsgcXVlcnk6IGFueSB9KSA9PiBkYXRhLnF1ZXJ5KVxuICAgIC50aGVuKChkYXRhOiB7IG5vcm1hbGl6ZWQ6IHsgZnJvbTogc3RyaW5nOyB0bzogc3RyaW5nIH1bXTsgcGFnZXM6IGFueSB9KSA9PiB7XG4gICAgICBpZiAoXG4gICAgICAgIE9iamVjdC5rZXlzKGRhdGEucGFnZXMpLmluZGV4T2YoXCItMVwiKSAhPT0gLTEgJiZcbiAgICAgICAgT2JqZWN0LmtleXMoZGF0YS5wYWdlcykubGVuZ3RoID09PSAxXG4gICAgICApIHtcbiAgICAgICAgcmV0dXJuIG51bGw7XG4gICAgICB9XG5cbiAgICAgIGNvbnN0IHBhZ2UgPSBuZXcgUGFnZSgpO1xuICAgICAgY29uc3QgZW50cnk6IE1lZGlhV2lraVBhZ2UgPSBkYXRhLnBhZ2VzW09iamVjdC5rZXlzKGRhdGEucGFnZXMpWzBdXTtcblxuICAgICAgaWYgKGRhdGEubm9ybWFsaXplZCkge1xuICAgICAgICBkYXRhLm5vcm1hbGl6ZWQuZm9yRWFjaChub3JtID0+IHtcbiAgICAgICAgICBwYWdlLnJlZGlyZWN0cy5wdXNoKDxSZWRpcmVjdD5ub3JtKTtcbiAgICAgICAgfSk7XG4gICAgICB9XG4gICAgICBpZiAoZW50cnkuY2F0ZWdvcmllcykge1xuICAgICAgICBlbnRyeS5jYXRlZ29yaWVzLmZvckVhY2goYyA9PiB7XG4gICAgICAgICAgcGFnZS5jYXRlZ29yaWVzLnB1c2goYy50aXRsZSk7XG4gICAgICAgIH0pO1xuICAgICAgfVxuICAgICAgaWYgKGVudHJ5LmV4dGxpbmtzKSB7XG4gICAgICAgIGVudHJ5LmV4dGxpbmtzLmZvckVhY2gobGluayA9PiB7XG4gICAgICAgICAgcGFnZS5leHRsaW5rcy5wdXNoKGxpbmtbXCIqXCJdKTtcbiAgICAgICAgfSk7XG4gICAgICB9XG4gICAgICBpZiAoZW50cnkudGVybXMuYWxpYXMpIHtcbiAgICAgICAgZW50cnkudGVybXMuYWxpYXMuZm9yRWFjaChhbGlhcyA9PiB7XG4gICAgICAgICAgcGFnZS5hbGlhc2VzLnB1c2goYWxpYXMpO1xuICAgICAgICB9KTtcbiAgICAgIH1cblxuICAgICAgcGFnZS5pZCA9IGVudHJ5LnBhZ2VpZDtcbiAgICAgIHBhZ2UudGl0bGUgPSBlbnRyeS50aXRsZTtcbiAgICAgIHBhZ2UudXJsID0gZW50cnkuZnVsbHVybDtcbiAgICAgIHBhZ2UuZWRpdFVybCA9IGVudHJ5LmVkaXR1cmw7XG4gICAgICBwYWdlLmRlc2NyaXB0aW9uID0gZW50cnkuZGVzY3JpcHRpb247XG4gICAgICBwYWdlLnN1bW1hcnkgPSBlbnRyeS5leHRyYWN0O1xuICAgICAgcGFnZS5sYW5nID0gbGFuZztcbiAgICAgIHBhZ2Uuc2VhcmNoUGhyYXNlID0gbmFtZTtcbiAgICAgIHJldHVybiBwYWdlO1xuICAgIH0pO1xufVxuXG5mdW5jdGlvbiBjb25zdHJ1Y3RRdWVyeShhcnRpY2xlOiBzdHJpbmcsIGxhbmc6IExhbmd1YWdlKTogV2lraVF1ZXJ5IHtcbiAgY29uc3QgZW5kcG9pbnQ6IHN0cmluZyA9XG4gICAgXCJodHRwczovL1wiICsgbGFuZy5pZC50b0xvd2VyQ2FzZSgpICsgXCIud2lraXBlZGlhLm9yZy93L2FwaS5waHA/XCI7XG4gIGxldCBxdWVyeSA9IG5ldyBXaWtpUXVlcnkoZW5kcG9pbnQpO1xuICBxdWVyeVxuICAgIC5hZGRQYXJhbShcImFjdGlvblwiLCBcInF1ZXJ5XCIpXG4gICAgLmFkZFBhcmFtKFwicHJvcFwiLCBcImluZm98ZGVzY3JpcHRpb258Y2F0ZWdvcmllc3xleHRsaW5rc3xwYWdldGVybXN8ZXh0cmFjdHMmZXhpbnRyb1wiKVxuICAgIC5hZGRQYXJhbShcImlucHJvcFwiLCBcInVybFwiKVxuICAgIC5hZGRQYXJhbShcInJlZGlyZWN0c1wiLCBcIjFcIilcbiAgICAuYWRkUGFyYW0oXCJ0aXRsZXNcIiwgYXJ0aWNsZSk7XG4gIHJldHVybiBxdWVyeTtcbn1cblxuY2xhc3MgV2lraVF1ZXJ5IHtcbiAgcHJpdmF0ZSBlbmRwb2ludDogc3RyaW5nO1xuICBwcml2YXRlIHBhcmFtczogV2lraVF1ZXJ5UGFyYW1zW107XG5cbiAgY29uc3RydWN0b3IoZW5kcG9pbnQ6IHN0cmluZykge1xuICAgIHRoaXMuZW5kcG9pbnQgPSBlbmRwb2ludDtcbiAgICB0aGlzLnBhcmFtcyA9IG5ldyBBcnJheTxXaWtpUXVlcnlQYXJhbXM+KCk7XG5cbiAgICB0aGlzLmFkZFBhcmFtKFwib3JpZ2luXCIsIFwiKlwiKS5hZGRQYXJhbShcImZvcm1hdFwiLCBcImpzb25cIik7XG4gIH1cblxuICBhZGRQYXJhbShrZXk6IHN0cmluZywgdmFsdWU6IHN0cmluZyk6IFdpa2lRdWVyeSB7XG4gICAgY29uc3QgcGFyYW0gPSBuZXcgV2lraVF1ZXJ5UGFyYW1zKGtleSwgdmFsdWUpO1xuICAgIHRoaXMucGFyYW1zLnB1c2gocGFyYW0pO1xuICAgIHJldHVybiB0aGlzO1xuICB9XG5cbiAgZ2V0IHVybCgpOiBzdHJpbmcge1xuICAgIGxldCBxdWVyeTogc3RyaW5nID0gdGhpcy5lbmRwb2ludDtcbiAgICB0aGlzLnBhcmFtcy5mb3JFYWNoKHAgPT4ge1xuICAgICAgcXVlcnkgKz0gcC5qb2luKCkgKyBcIiZcIjtcbiAgICB9KTtcbiAgICByZXR1cm4gcXVlcnk7XG4gIH1cbn1cblxuY2xhc3MgV2lraVF1ZXJ5UGFyYW1zIHtcbiAga2V5OiBzdHJpbmc7XG4gIHZhbHVlOiBzdHJpbmc7XG5cbiAgY29uc3RydWN0b3Ioa2V5OiBzdHJpbmcsIHZhbHVlOiBzdHJpbmcpIHtcbiAgICB0aGlzLmtleSA9IGtleTtcbiAgICB0aGlzLnZhbHVlID0gdmFsdWU7XG4gIH1cblxuICBqb2luKCk6IHN0cmluZyB7XG4gICAgcmV0dXJuIHRoaXMua2V5ICsgXCI9XCIgKyB0aGlzLnZhbHVlO1xuICB9XG59XG5cbnR5cGUgTWVkaWFXaWtpUGFnZSA9IHtcbiAgY2Fub25pY2FsdXJsOiBzdHJpbmc7XG4gIGNhdGVnb3JpZXM6IHsgbnM6IG51bWJlcjsgdGl0bGU6IHN0cmluZyB9W107XG4gIGNvbnRlbnRtb2RlbDogc3RyaW5nO1xuICBkZXNjcmlwdGlvbjogc3RyaW5nO1xuICBkZXNjcmlwdGlvbnNvdXJjZTogc3RyaW5nO1xuICBlZGl0dXJsOiBzdHJpbmc7XG4gIGV4dGxpbmtzOiB7IFwiKlwiOiBzdHJpbmcgfVtdO1xuICBleHRyYWN0OiBzdHJpbmc7XG4gIGZ1bGx1cmw6IHN0cmluZztcbiAgbGFzdHJldmlkOiBudW1iZXI7XG4gIGxlbmd0aDogbnVtYmVyO1xuICBuczogbnVtYmVyO1xuICBwYWdlaWQ6IG51bWJlcjtcbiAgcGFnZWxhbmd1YWdlOiBzdHJpbmc7XG4gIHBhZ2VsYW5ndWFnZWRpcjogc3RyaW5nO1xuICBwYWdlbGFuZ3VhZ2VodG1sY29kZTogc3RyaW5nO1xuICB0ZXJtczoge1xuICAgIGFsaWFzOiBzdHJpbmdbXTtcbiAgICBkZXNjcmlwdGlvbjogc3RyaW5nW107XG4gICAgbGFiZWw6IHN0cmluZ1tdO1xuICB9O1xuICB0aXRsZTogc3RyaW5nO1xuICB0b3VjaGVkOiBzdHJpbmc7XG59O1xuIl19

/***/ }),
/* 9 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
function getSourceUnderCursor(event) {
    var textNode;
    var offset;
    if (document.caretPositionFromPoint) {
        var range = document.caretPositionFromPoint(event.clientX, event.clientY);
        if (!range) {
            return null;
        }
        textNode = range.offsetNode;
        offset = range.offset;
    }
    else if (document.caretRangeFromPoint) {
        var range = document.caretRangeFromPoint(event.clientX, event.clientY);
        if (!range) {
            return null;
        }
        textNode = range.startContainer;
        offset = range.startOffset;
    }
    else {
        return null;
    }
    var source = new TextSource(textNode, offset);
    return source;
}
exports.getSourceUnderCursor = getSourceUnderCursor;
var TextSource = (function () {
    function TextSource(node, offset) {
        this._leftNode = node;
        this._rightNode = node;
        this._text = node.textContent ? node.textContent : "";
        this._offset = offset;
    }
    TextSource.prototype.phrase = function (before, after) {
        var _this = this;
        var begin = 0;
        var end = 0;
        if (isChar(this.text.charAt(this.offset))) {
            begin = this.offset - before;
            end = this.offset + after + 1;
        }
        else {
            if (matchBreak(this.text[this.offset])) {
                return "";
            }
            var k = this.offset;
            for (var i = 0; i <= after; i++) {
                while (matchBreak(this.text[k]) === false) {
                    if (k >= this.text.length - 1) {
                        if (!getNextNode(this.rightNode)) {
                            break;
                        }
                        this.joinAfter();
                        k--;
                    }
                    k++;
                }
                k++;
            }
            end = k;
            var oldOffset_1 = this.offset.valueOf();
            k = this.offset;
            for (var i = 0; i <= before; i++) {
                while (matchBreak(this.text[k]) === false) {
                    if (k <= 0) {
                        if (!getPreviousNode(this.leftNode)) {
                            break;
                        }
                        var adjustOffset = function (v) { return v + _this.offset - oldOffset_1; };
                        this.joinBefore();
                        k = adjustOffset(k);
                        end = adjustOffset(end);
                        oldOffset_1 = this.offset;
                        k++;
                    }
                    k--;
                }
                k--;
            }
            k += 2;
            begin = k;
        }
        var segment = this.text.substring(begin, end);
        segment = clean(segment);
        return segment;
    };
    TextSource.prototype.joinAfter = function () {
        var nextNode = getNextNode(this.rightNode);
        if (!nextNode) {
            return;
        }
        this.rightNode = nextNode;
        this.addAfter(this.rightNode.textContent ? this.rightNode.textContent : "");
    };
    TextSource.prototype.joinBefore = function () {
        var prevNode = getPreviousNode(this.leftNode);
        if (!prevNode) {
            return;
        }
        this.leftNode = prevNode;
        this.addBefore(this.leftNode.textContent ? this.leftNode.textContent : "");
    };
    TextSource.prototype.addAfter = function (text) {
        this.text += text;
    };
    TextSource.prototype.addBefore = function (text) {
        this.text = text + this.text;
        this.offset += text.length;
    };
    Object.defineProperty(TextSource.prototype, "text", {
        get: function () {
            return this._text;
        },
        set: function (value) {
            this._text = value;
        },
        enumerable: true,
        configurable: true
    });
    Object.defineProperty(TextSource.prototype, "offset", {
        get: function () {
            return this._offset;
        },
        set: function (value) {
            this._offset = value;
        },
        enumerable: true,
        configurable: true
    });
    Object.defineProperty(TextSource.prototype, "leftNode", {
        get: function () {
            return this._leftNode;
        },
        set: function (value) {
            this._leftNode = value;
        },
        enumerable: true,
        configurable: true
    });
    Object.defineProperty(TextSource.prototype, "rightNode", {
        get: function () {
            return this._rightNode;
        },
        set: function (value) {
            this._rightNode = value;
        },
        enumerable: true,
        configurable: true
    });
    return TextSource;
}());
exports.TextSource = TextSource;
function getNextNode(node) {
    var sibling = node.nextSibling;
    if (!sibling) {
        var parentNode = node.parentNode;
        if (!parentNode) {
            return null;
        }
        sibling = parentNode.nextSibling;
    }
    return sibling;
}
function getPreviousNode(node) {
    var sibling = node.previousSibling;
    if (!sibling) {
        var parentNode = node.parentNode;
        if (!parentNode) {
            return null;
        }
        sibling = parentNode.previousSibling;
    }
    return sibling;
}
function matchBreak(c) {
    return c === " " || /(\\n)/.test(JSON.stringify(c));
}
function clean(s) {
    return s.replace(/([.,\'\"\/#!$%\^&\*;:{}=\-_`~()、。])/, "").trim();
}
function isChar(s) {
    var code = s.charCodeAt(0);
    return ((code >= 12288 && code <= 12543) ||
        (code >= 65280 && code <= 65519) ||
        (code >= 19968 && code <= 40879) ||
        (code >= 13312 && code <= 19903));
}
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2VsZWN0b3IuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi9zcmMvc2VsZWN0b3IudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6Ijs7QUFBQSxTQUFnQixvQkFBb0IsQ0FBQyxLQUFpQjtJQUNwRCxJQUFJLFFBQTJCLENBQUM7SUFDaEMsSUFBSSxNQUFjLENBQUM7SUFFbkIsSUFBSSxRQUFRLENBQUMsc0JBQXNCLEVBQUU7UUFDbkMsSUFBSSxLQUFLLEdBQUcsUUFBUSxDQUFDLHNCQUFzQixDQUFDLEtBQUssQ0FBQyxPQUFPLEVBQUUsS0FBSyxDQUFDLE9BQU8sQ0FBQyxDQUFDO1FBQzFFLElBQUksQ0FBQyxLQUFLLEVBQUU7WUFDVixPQUFPLElBQUksQ0FBQztTQUNiO1FBRUQsUUFBUSxHQUFzQixLQUFLLENBQUMsVUFBVSxDQUFDO1FBQy9DLE1BQU0sR0FBRyxLQUFLLENBQUMsTUFBTSxDQUFDO0tBQ3ZCO1NBQU0sSUFBSSxRQUFRLENBQUMsbUJBQW1CLEVBQUU7UUFDdkMsSUFBTSxLQUFLLEdBQVUsUUFBUSxDQUFDLG1CQUFtQixDQUFDLEtBQUssQ0FBQyxPQUFPLEVBQUUsS0FBSyxDQUFDLE9BQU8sQ0FBQyxDQUFDO1FBQ2hGLElBQUksQ0FBQyxLQUFLLEVBQUU7WUFDVixPQUFPLElBQUksQ0FBQztTQUNiO1FBRUQsUUFBUSxHQUFzQixLQUFLLENBQUMsY0FBYyxDQUFDO1FBQ25ELE1BQU0sR0FBRyxLQUFLLENBQUMsV0FBVyxDQUFDO0tBQzVCO1NBQU07UUFDTCxPQUFPLElBQUksQ0FBQztLQUNiO0lBRUQsSUFBTSxNQUFNLEdBQUcsSUFBSSxVQUFVLENBQUMsUUFBUSxFQUFFLE1BQU0sQ0FBQyxDQUFDO0lBQ2hELE9BQU8sTUFBTSxDQUFDO0FBQ2hCLENBQUM7QUExQkQsb0RBMEJDO0FBRUQ7SUFNRSxvQkFBWSxJQUFVLEVBQUUsTUFBYztRQUNwQyxJQUFJLENBQUMsU0FBUyxHQUFHLElBQUksQ0FBQztRQUN0QixJQUFJLENBQUMsVUFB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SSxDQUFDLFVBQVUsQ0FBQztRQUNuQyxJQUFJLENBQUMsVUFBVSxFQUFFO1lBQ2YsT0FBTyxJQUFJLENBQUM7U0FDYjtRQUNELE9BQU8sR0FBRyxVQUFVLENBQUMsZUFBZSxDQUFDO0tBQ3RDO0lBRUQsT0FBTyxPQUFPLENBQUM7QUFDakIsQ0FBQztBQUVELFNBQVMsVUFBVSxDQUFDLENBQVM7SUFDM0IsT0FBTyxDQUFDLEtBQUssR0FBRyxJQUFJLE9BQU8sQ0FBQyxJQUFJLENBQUMsSUFBSSxDQUFDLFNBQVMsQ0FBQyxDQUFDLENBQUMsQ0FBQyxDQUFDO0FBQ3RELENBQUM7QUFFRCxTQUFTLEtBQUssQ0FBQyxDQUFTO0lBQ3RCLE9BQU8sQ0FBQyxDQUFDLE9BQU8sQ0FBQyxxQ0FBcUMsRUFBRSxFQUFFLENBQUMsQ0FBQyxJQUFJLEVBQUUsQ0FBQztBQUNyRSxDQUFDO0FBRUQsU0FBUyxNQUFNLENBQUMsQ0FBUztJQUN2QixJQUFNLElBQUksR0FBVyxDQUFDLENBQUMsVUFBVSxDQUFDLENBQUMsQ0FBQyxDQUFDO0lBQ3JDLE9BQU8sQ0FDTCxDQUFDLElBQUksSUFBSSxLQUFLLElBQUksSUFBSSxJQUFJLEtBQUssQ0FBQztRQUNoQyxDQUFDLElBQUksSUFBSSxLQUFLLElBQUksSUFBSSxJQUFJLEtBQUssQ0FBQztRQUNoQyxDQUFDLElBQUksSUFBSSxLQUFLLElBQUksSUFBSSxJQUFJLEtBQUssQ0FBQztRQUNoQyxDQUFDLElBQUksSUFBSSxLQUFLLElBQUksSUFBSSxJQUFJLEtBQUssQ0FBQyxDQUNqQyxDQUFDO0FBQ0osQ0FBQyIsInNvdXJjZXNDb250ZW50IjpbImV4cG9ydCBmdW5jdGlvbiBnZXRTb3VyY2VVbmRlckN1cnNvcihldmVudDogTW91c2VFdmVudCk6IFRleHRTb3VyY2UgfCBudWxsIHtcbiAgbGV0IHRleHROb2RlOiBIVE1MT2JqZWN0RWxlbWVudDtcbiAgbGV0IG9mZnNldDogbnVtYmVyO1xuXG4gIGlmIChkb2N1bWVudC5jYXJldFBvc2l0aW9uRnJvbVBvaW50KSB7XG4gICAgbGV0IHJhbmdlID0gZG9jdW1lbnQuY2FyZXRQb3NpdGlvbkZyb21Qb2ludChldmVudC5jbGllbnRYLCBldmVudC5jbGllbnRZKTtcbiAgICBpZiAoIXJhbmdlKSB7XG4gICAgICByZXR1cm4gbnVsbDtcbiAgICB9XG5cbiAgICB0ZXh0Tm9kZSA9IDxIVE1MT2JqZWN0RWxlbWVudD5yYW5nZS5vZmZzZXROb2RlO1xuICAgIG9mZnNldCA9IHJhbmdlLm9mZnNldDtcbiAgfSBlbHNlIGlmIChkb2N1bWVudC5jYXJldFJhbmdlRnJvbVBvaW50KSB7XG4gICAgY29uc3QgcmFuZ2U6IFJhbmdlID0gZG9jdW1lbnQuY2FyZXRSYW5nZUZyb21Qb2ludChldmVudC5jbGllbnRYLCBldmVudC5jbGllbnRZKTtcbiAgICBpZiAoIXJhbmdlKSB7XG4gICAgICByZXR1cm4gbnVsbDtcbiAgICB9XG5cbiAgICB0ZXh0Tm9kZSA9IDxIVE1MT2JqZWN0RWxlbWVudD5yYW5nZS5zdGFydENvbnRhaW5lcjtcbiAgICBvZmZzZXQgPSByYW5nZS5zdGFydE9mZnNldDtcbiAgfSBlbHNlIHtcbiAgICByZXR1cm4gbnVsbDtcbiAgfVxuXG4gIGNvbnN0IHNvdXJjZSA9IG5ldyBUZXh0U291cmNlKHRleHROb2RlLCBvZmZzZXQpO1xuICByZXR1cm4gc291cmNlO1xufVxuXG5leHBvcnQgY2xhc3MgVGV4dFNvdXJjZSB7XG4gIHByaXZhdGUgX2xlZnROb2RlOiBOb2RlO1xuICBwcml2YXRlIF9yaWdodE5vZGU6IE5vZGU7XG4gIHByaXZhdGUgX3RleHQ6IHN0cmluZztcbiAgcHJpdmF0ZSBfb2Zmc2V0OiBudW1iZXI7XG5cbiAgY29uc3RydWN0b3Iobm9kZTogTm9kZSwgb2Zmc2V0OiBudW1iZXIpIHtcbiAgICB0aGlzLl9sZWZ0Tm9kZSA9IG5vZGU7XG4gICAgdGhpcy5fcmlnaHROb2RlID0gbm9kZTtcbiAgICB0aGlzLl90ZXh0ID0gbm9kZS50ZXh0Q29udGVudCA/IG5vZGUudGV4dENvbnRlbnQgOiBcIlwiO1xuICAgIHRoaXMuX29mZnNldCA9IG9mZnNldDtcbiAgfVxuXG4gIHBocmFzZShiZWZvcmU6IG51bWJlciwgYWZ0ZXI6IG51bWJlcik6IHN0cmluZyB7XG4gICAgbGV0IGJlZ2luOiBudW1iZXIgPSAwO1xuICAgIGxldCBlbmQ6IG51bWJlciA9IDA7XG5cbiAgICBpZiAoaXNDaGFyKHRoaXMudGV4dC5jaGFyQXQodGhpcy5vZmZzZXQpKSkge1xuICAgICAgYmVnaW4gPSB0aGlzLm9mZnNldCAtIGJlZm9yZTtcbiAgICAgIGVuZCA9IHRoaXMub2Zmc2V0ICsgYWZ0ZXIgKyAxO1xuICAgIH0gZWxzZSB7XG4gICAgICBpZiAobWF0Y2hCcmVhayh0aGlzLnRleHRbdGhpcy5vZmZzZXRdKSkge1xuICAgICAgICByZXR1cm4gXCJcIjtcbiAgICAgIH1cblxuICAgICAgLy8gRmluZCB0aGUgaW5kZXggb2YgdGhlIGVuZCBvZiB0aGUgcGhyYXNlXG4gICAgICBsZXQgazogbnVtYmVyID0gdGhpcy5vZmZzZXQ7XG4gICAgICBmb3IgKGxldCBpID0gMDsgaSA8PSBhZnRlcjsgaSsrKSB7XG4gICAgICAgIC8vIEZpbmQgdGhlIGVuZCBvZiB0aGUgd29yZFxuICAgICAgICB3aGlsZSAobWF0Y2hCcmVhayh0aGlzLnRleHRba10pID09PSBmYWxzZSkge1xuICAgICAgICAgIGlmIChrID49IHRoaXMudGV4dC5sZW5ndGggLSAxKSB7XG4gICAgICAgICAgICBpZiAoIWdldE5leHROb2RlKHRoaXMucmlnaHROb2RlKSkge1xuICAgICAgICAgICAgICBicmVhaztcbiAgICAgICAgICAgIH1cbiAgICAgICAgICAgIHRoaXMuam9pbkFmdGVyKCk7XG4gICAgICAgICAgICBrLS07XG4gICAgICAgICAgfVxuICAgICAgICAgIGsrKztcbiAgICAgICAgfVxuICAgICAgICBrKys7XG4gICAgICB9XG4gICAgICBlbmQgPSBrO1xuXG4gICAgICBsZXQgb2xkT2Zmc2V0OiBudW1iZXIgPSB0aGlzLm9mZnNldC52YWx1ZU9mKCk7XG4gICAgICBrID0gdGhpcy5vZmZzZXQ7XG4gICAgICBmb3IgKGxldCBpID0gMDsgaSA8PSBiZWZvcmU7IGkrKykge1xuICAgICAgICB3aGlsZSAobWF0Y2hCcmVhayh0aGlzLnRleHRba10pID09PSBmYWxzZSkge1xuICAgICAgICAgIGlmIChrIDw9IDApIHtcbiAgICAgICAgICAgIGlmICghZ2V0UHJldmlvdXNOb2RlKHRoaXMubGVmdE5vZGUpKSB7XG4gICAgICAgICAgICAgIGJyZWFrO1xuICAgICAgICAgICAgfVxuICAgICAgICAgICAgY29uc3QgYWRqdXN0T2Zmc2V0ID0gKHY6IG51bWJlcikgPT4gdiArIHRoaXMub2Zmc2V0IC0gb2xkT2Zmc2V0O1xuICAgICAgICAgICAgdGhpcy5qb2luQmVmb3JlKCk7XG4gICAgICAgICAgICBrID0gYWRqdXN0T2Zmc2V0KGspO1xuICAgICAgICAgICAgZW5kID0gYWRqdXN0T2Zmc2V0KGVuZCk7XG4gICAgICAgICAgICBvbGRPZmZzZXQgPSB0aGlzLm9mZnNldDtcbiAgICAgICAgICAgIGsrKztcbiAgICAgICAgICB9XG4gICAgICAgICAgay0tO1xuICAgICAgICB9XG4gICAgICAgIGstLTtcbiAgICAgIH1cbiAgICAgIGsgKz0gMjtcbiAgICAgIGJlZ2luID0gaztcbiAgICB9XG5cbiAgICBsZXQgc2VnbWVudCA9IHRoaXMudGV4dC5zdWJzdHJpbmcoYmVnaW4sIGVuZCk7XG4gICAgc2VnbWVudCA9IGNsZWFuKHNlZ21lbnQpO1xuICAgIHJldHVybiBzZWdtZW50O1xuICB9XG5cbiAgcHJpdmF0ZSBqb2luQWZ0ZXIoKTogdm9pZCB7XG4gICAgY29uc3QgbmV4dE5vZGUgPSBnZXROZXh0Tm9kZSh0aGlzLnJpZ2h0Tm9kZSk7XG4gICAgaWYgKCFuZXh0Tm9kZSkge1xuICAgICAgcmV0dXJuO1xuICAgIH1cbiAgICB0aGlzLnJpZ2h0Tm9kZSA9IG5leHROb2RlO1xuICAgIHRoaXMuYWRkQWZ0ZXIodGhpcy5yaWdodE5vZGUudGV4dENvbnRlbnQgPyB0aGlzLnJpZ2h0Tm9kZS50ZXh0Q29udGVudCA6IFwiXCIpO1xuICB9XG5cbiAgcHJpdmF0ZSBqb2luQmVmb3JlKCk6IHZvaWQge1xuICAgIGNvbnN0IHByZXZOb2RlID0gZ2V0UHJldmlvdXNOb2RlKHRoaXMubGVmdE5vZGUpO1xuICAgIGlmICghcHJldk5vZGUpIHtcbiAgICAgIHJldHVybjtcbiAgICB9XG4gICAgdGhpcy5sZWZ0Tm9kZSA9IHByZXZOb2RlO1xuICAgIHRoaXMuYWRkQmVmb3JlKHRoaXMubGVmdE5vZGUudGV4dENvbnRlbnQgPyB0aGlzLmxlZnROb2RlLnRleHRDb250ZW50IDogXCJcIik7XG4gIH1cblxuICBwcml2YXRlIGFkZEFmdGVyKHRleHQ6IHN0cmluZyk6IHZvaWQge1xuICAgIHRoaXMudGV4dCArPSB0ZXh0O1xuICB9XG5cbiAgcHJpdmF0ZSBhZGRCZWZvcmUodGV4dDogc3RyaW5nKTogdm9pZCB7XG4gICAgdGhpcy50ZXh0ID0gdGV4dCArIHRoaXMudGV4dDtcbiAgICB0aGlzLm9mZnNldCArPSB0ZXh0Lmxlbmd0aDtcbiAgfVxuXG4gIGdldCB0ZXh0KCk6IHN0cmluZyB7XG4gICAgcmV0dXJuIHRoaXMuX3RleHQ7XG4gIH1cblxuICBzZXQgdGV4dCh2YWx1ZTogc3RyaW5nKSB7XG4gICAgdGhpcy5fdGV4dCA9IHZhbHVlO1xuICB9XG5cbiAgZ2V0IG9mZnNldCgpOiBudW1iZXIge1xuICAgIHJldHVybiB0aGlzLl9vZmZzZXQ7XG4gIH1cblxuICBzZXQgb2Zmc2V0KHZhbHVlOiBudW1iZXIpIHtcbiAgICB0aGlzLl9vZmZzZXQgPSB2YWx1ZTtcbiAgfVxuXG4gIGdldCBsZWZ0Tm9kZSgpOiBOb2RlIHtcbiAgICByZXR1cm4gdGhpcy5fbGVmdE5vZGU7XG4gIH1cblxuICBzZXQgbGVmdE5vZGUodmFsdWU6IE5vZGUpIHtcbiAgICB0aGlzLl9sZWZ0Tm9kZSA9IHZhbHVlO1xuICB9XG5cbiAgZ2V0IHJpZ2h0Tm9kZSgpOiBOb2RlIHtcbiAgICByZXR1cm4gdGhpcy5fcmlnaHROb2RlO1xuICB9XG5cbiAgc2V0IHJpZ2h0Tm9kZSh2YWx1ZTogTm9kZSkge1xuICAgIHRoaXMuX3JpZ2h0Tm9kZSA9IHZhbHVlO1xuICB9XG59XG5cbmZ1bmN0aW9uIGdldE5leHROb2RlKG5vZGU6IE5vZGUpOiBOb2RlIHwgbnVsbCB7XG4gIGxldCBzaWJsaW5nID0gbm9kZS5uZXh0U2libGluZztcbiAgaWYgKCFzaWJsaW5nKSB7XG4gICAgY29uc3QgcGFyZW50Tm9kZSA9IG5vZGUucGFyZW50Tm9kZTtcbiAgICBpZiAoIXBhcmVudE5vZGUpIHtcbiAgICAgIHJldHVybiBudWxsO1xuICAgIH1cbiAgICBzaWJsaW5nID0gcGFyZW50Tm9kZS5uZXh0U2libGluZztcbiAgfVxuXG4gIHJldHVybiBzaWJsaW5nO1xufVxuXG5mdW5jdGlvbiBnZXRQcmV2aW91c05vZGUobm9kZTogTm9kZSk6IE5vZGUgfCBudWxsIHtcbiAgbGV0IHNpYmxpbmcgPSBub2RlLnByZXZpb3VzU2libGluZztcbiAgaWYgKCFzaWJsaW5nKSB7XG4gICAgY29uc3QgcGFyZW50Tm9kZSA9IG5vZGUucGFyZW50Tm9kZTtcbiAgICBpZiAoIXBhcmVudE5vZGUpIHtcbiAgICAgIHJldHVybiBudWxsO1xuICAgIH1cbiAgICBzaWJsaW5nID0gcGFyZW50Tm9kZS5wcmV2aW91c1NpYmxpbmc7XG4gIH1cblxuICByZXR1cm4gc2libGluZztcbn1cblxuZnVuY3Rpb24gbWF0Y2hCcmVhayhjOiBzdHJpbmcpOiBib29sZWFuIHtcbiAgcmV0dXJuIGMgPT09IFwiIFwiIHx8IC8oXFxcXG4pLy50ZXN0KEpTT04uc3RyaW5naWZ5KGMpKTtcbn1cblxuZnVuY3Rpb24gY2xlYW4oczogc3RyaW5nKTogc3RyaW5nIHtcbiAgcmV0dXJuIHMucmVwbGFjZSgvKFsuLFxcJ1xcXCJcXC8jISQlXFxeJlxcKjs6e309XFwtX2B+KCnjgIHjgIJdKS8sIFwiXCIpLnRyaW0oKTtcbn1cblxuZnVuY3Rpb24gaXNDaGFyKHM6IHN0cmluZyk6IGJvb2xlYW4ge1xuICBjb25zdCBjb2RlOiBudW1iZXIgPSBzLmNoYXJDb2RlQXQoMCk7XG4gIHJldHVybiAoXG4gICAgKGNvZGUgPj0gMTIyODggJiYgY29kZSA8PSAxMjU0MykgfHxcbiAgICAoY29kZSA+PSA2NTI4MCAmJiBjb2RlIDw9IDY1NTE5KSB8fFxuICAgIChjb2RlID49IDE5OTY4ICYmIGNvZGUgPD0gNDA4NzkpIHx8XG4gICAgKGNvZGUgPj0gMTMzMTIgJiYgY29kZSA8PSAxOTkwMylcbiAgKTtcbn1cbiJdfQ==

/***/ }),
/* 10 */
/***/ (function(module, exports) {

module.exports = "<!DOCTYPE html>\n<html>\n  <head>\n    <meta charset=\"utf-8\" />\n    <title>Wikichan</title>\n    <link rel=\"stylesheet\" type=\"text/css\" media=\"screen\" href=\"css/frame.css\" />\n  </head>\n  <body>\n    <!-- search -->\n    <div id=\"search\">\n      <input type=\"text\" placeholder=\"Search Wikipedia\" id=\"search-box\" />\n    </div>\n\n    <!-- results -->\n    <div id=\"results\">\n      <!-- disambiguations -->\n      <div id=\"disambiguations\">\n        <div rv-each-element=\"pages.elements\" rv-show=\"element.isDisambiguation\" class=\"disambiguation\">\n          <a target=\"_blank\" rv-href=\"element.url\" class=\"title\" rv-href=\"element.url\">{element.title}</a>\n          <div class=\"labels\">\n            <a target=\"_blank\" rv-href=\"element.lang.url\" class=\"lang\">{element.lang.id | lowercase}</a>\n            <span class=\"edit-url\">\n              <a target=\"_blank\" rv-href=\"element.editUrl\">edit url</a>\n            </span>\n          </div>\n        </div>\n      </div>\n      <hr />\n\n      <div rv-each-element=\"pages.elements\" rv-hide=\"element.isDisambiguation\" class=\"result\">\n        <div class=\"header\">\n          <div class=\"top\">\n            <a target=\"_blank\" rv-href=\"element.url\" class=\"title\">\n              {element.title}\n            </a>\n            <div class=\"labels\">\n              <span class=\"lang\" rv-title=\"element.lang.name\">\n                <a target=\"_blank\" rv-href=\"element.lang.url\" class=\"lang\">\n                  {element.lang.id}\n                </a>\n              </span>\n              <span class=\"id\">{element.id}</span>\n              <span class=\"edit-url\">\n                <a target=\"_blank\" rv-href=\"element.editUrl\">edit url</a>\n              </span>\n              <button class=\"hide-button\" rv-on-click=\"callbacks.hide\">\n                –\n              </button>\n            </div>\n          </div>\n          <span class=\"search\">\n            <span>result of:</span>\n            <span class=\"search-term\">\n              <a target=\"_blank\" rv-href=\"element.searchLink\">\n                {element.searchPhrase}\n              </a>\n            </span>\n          </span>\n        </div>\n\n        <div class=\"content\">\n          <div class=\"description\">\n            <span>{element.description}</span>\n          </div>\n          <div class=\"extract\">\n            <span rv-if=\"element.summary\" rv-html=\"element.summary\"></span>\n            <span rv-unless=\"element.summary\">No summary available.</span>\n          </div>\n\n          <div class=\"extras-section\">\n            <details class=\"extra\" rv-enabled=\"element.aliases\">\n              <summary class=\"extra-summary\">aliases</summary>\n              <ul class=\"extras-list\">\n                <li class=\"extras-item\" rv-each-alias=\"element.aliases\">\n                  <span rv-title=\"alias\">{alias}</span>\n                </li>\n              </ul>\n            </details>\n\n            <details class=\"extra\" rv-enabled=\"element.extlinks\">\n              <summary class=\"extra-summary\">external links</summary>\n              <ul class=\"extras-list\">\n                <li class=\"extras-item link\" rv-each-link=\"element.extlinks\">\n                  <a target=\"_blank\" rv-href=\"link\" rv-title=\"link\">{link}</a>\n                </li>\n              </ul>\n            </details>\n          </div>\n        </div>\n        <hr />\n      </div>\n    </div>\n    <p id=\"end-message\">no more results</p>\n  </body>\n</html>\n";

/***/ }),
/* 11 */
/***/ (function(module, exports, __webpack_require__) {


        var result = __webpack_require__(12);

        if (typeof result === "string") {
            module.exports = result;
        } else {
            module.exports = result.toString();
        }
    

/***/ }),
/* 12 */
/***/ (function(module, exports, __webpack_require__) {

// Imports
var ___CSS_LOADER_API_IMPORT___ = __webpack_require__(2);
exports = ___CSS_LOADER_API_IMPORT___(false);
// Module
exports.push([module.i, ":root{background:#fdfdfd;font-size:13px;font-family:\"Segoe UI\",sans-serif;box-sizing:border-box}#results .edit-url,#results .lang,#results .id,#results .hide-button,#results .search .search-term{text-align:center;font-size:0.9rem;font-weight:bold;padding:3px;background-color:#eeeeee;border-radius:5px;border:none;cursor:context-menu}#results .edit-url a{text-decoration:none}#results .header{margin:7px 5px;position:sticky;top:0px;padding-top:5px;background-color:rgba(255,255,255,0.93)}#results .top{display:flex;justify-content:space-between;margin-bottom:3px}#results .title{width:45%;overflow:auto;font-size:1.4rem;font-weight:bold;text-decoration:none;color:#000000}#results .lang{margin-right:2px;background:#ececec;color:#3d3d3d;font-weight:bold;font-stretch:normal;text-decoration:none;cursor:pointer}#results .id{background-color:#ebebeb;font-weight:normal;font-style:italic;color:#888888}#results .edit-url{background-color:#ffd6be}#results .hide-button{background:#e0e0e0;width:16px;padding:auto auto;margin-left:7px}#results .hide-button:hover{background:#c2c2c2;cursor:pointer}#results .search .search-term{font-weight:normal;font-style:italic}#results .content{margin:15px 30px;display:block}#results .content .description{font-size:1em;font-style:italic}#results .content .extract{font-size:1em}#results .content .extras-section .extra{background-color:#f1f1f1;padding:5px;border-radius:5px}#results .content .extras-section .extra .extra-summary{font-weight:bold;cursor:pointer}#results .content .extras-section .extra .extras-list{padding-left:15px;list-style-type:none}#results .content .extras-section .extra .extras-list .extras-item{display:block;margin-bottom:3px;width:25em;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}#results .content .extras-section .extra .extras-list .link{color:#5eb1e9}#results .content .extras-section .extra .extras-list .link a{color:#5eb1e9}#results .disambiguation{margin-bottom:3px;display:flex;justify-content:space-between}#results .disambiguation .title{font-size:1rem}#results .disambiguation .edit-url,#results .disambiguation .lang,#results .disambiguation .id,#results .disambiguation .hide-button,#results .disambiguation .search .search-term,#results .search .disambiguation .search-term{font-size:0.8rem;padding:1.5px;border-radius:3px}#results .disambiguation .edit-url a,#results .disambiguation .lang a,#results .disambiguation .id a,#results .disambiguation .hide-button a,#results .disambiguation .search .search-term a,#results .search .disambiguation .search-term a{color:#505050}#results hr{padding:0px;margin:0px;border:0px;border-top:1px solid #eeeeee}#search{margin-bottom:5px;font-size:0.9rem;text-align:right}#search #search-box{width:70%;height:23px;padding-left:5px;border-radius:3px;border:1px solid darkgray}#end-message{font-size:0.9rem;text-align:center;color:#818181;padding:0px}\n", ""]);
// Exports
module.exports = exports;


/***/ }),
/* 13 */
/***/ (function(module, exports, __webpack_require__) {


        var result = __webpack_require__(14);

        if (typeof result === "string") {
            module.exports = result;
        } else {
            module.exports = result.toString();
        }
    

/***/ }),
/* 14 */
/***/ (function(module, exports, __webpack_require__) {

// Imports
var ___CSS_LOADER_API_IMPORT___ = __webpack_require__(2);
exports = ___CSS_LOADER_API_IMPORT___(false);
// Module
exports.push([module.i, "#wikichan{border:1px solid #999999;box-shadow:0px 0px 10px rgba(0,0,0,0.5);z-index:9999;position:fixed;visibility:hidden}\n", ""]);
// Exports
module.exports = exports;


/***/ })
/******/ ]);