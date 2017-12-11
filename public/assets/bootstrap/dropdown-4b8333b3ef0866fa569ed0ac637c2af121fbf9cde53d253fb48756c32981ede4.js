function _classCallCheck(e,t){if(!(e instanceof t))throw new TypeError("Cannot call a class as a function")}var _createClass=function(){function e(e,t){for(var n=0;n<t.length;n++){var r=t[n];r.enumerable=r.enumerable||!1,r.configurable=!0,"value"in r&&(r.writable=!0),Object.defineProperty(e,r.key,r)}}return function(t,n,r){return n&&e(t.prototype,n),r&&e(t,r),t}}(),Dropdown=function(e){var t="dropdown",n="4.0.0-alpha.6",r="bs.dropdown",a="."+r,o=".data-api",i=e.fn[t],s=27,l=38,c=40,d=3,u={HIDE:"hide"+a,HIDDEN:"hidden"+a,SHOW:"show"+a,SHOWN:"shown"+a,CLICK:"click"+a,CLICK_DATA_API:"click"+a+o,FOCUSIN_DATA_API:"focusin"+a+o,KEYDOWN_DATA_API:"keydown"+a+o},f={BACKDROP:"dropdown-backdrop",DISABLED:"disabled",SHOW:"show"},h={BACKDROP:".dropdown-backdrop",DATA_TOGGLE:'[data-toggle="dropdown"]',FORM_CHILD:".dropdown form",ROLE_MENU:'[role="menu"]',ROLE_LISTBOX:'[role="listbox"]',NAVBAR_NAV:".navbar-nav",VISIBLE_ITEMS:'[role="menu"] li:not(.disabled) a, [role="listbox"] li:not(.disabled) a'},_=function(){function t(e){_classCallCheck(this,t),this._element=e,this._addEventListeners()}return t.prototype.toggle=function(){if(this.disabled||e(this).hasClass(f.DISABLED))return!1;var n=t._getParentFromElement(this),r=e(n).hasClass(f.SHOW);if(t._clearMenus(),r)return!1;if("ontouchstart"in document.documentElement&&!e(n).closest(h.NAVBAR_NAV).length){var a=document.createElement("div");a.className=f.BACKDROP,e(a).insertBefore(this),e(a).on("click",t._clearMenus)}var o={relatedTarget:this},i=e.Event(u.SHOW,o);return e(n).trigger(i),!i.isDefaultPrevented()&&(this.focus(),this.setAttribute("aria-expanded",!0),e(n).toggleClass(f.SHOW),e(n).trigger(e.Event(u.SHOWN,o)),!1)},t.prototype.dispose=function(){e.removeData(this._element,r),e(this._element).off(a),this._element=null},t.prototype._addEventListeners=function(){e(this._element).on(u.CLICK,this.toggle)},t._jQueryInterface=function(n){return this.each(function(){var a=e(this).data(r);if(a||(a=new t(this),e(this).data(r,a)),"string"==typeof n){if(a[n]===undefined)throw new Error('No method named "'+n+'"');a[n].call(this)}})},t._clearMenus=function(n){if(!n||n.which!==d){var r=e(h.BACKDROP)[0];r&&r.parentNode.removeChild(r);for(var a=e.makeArray(e(h.DATA_TOGGLE)),o=0;o<a.length;o++){var i=t._getParentFromElement(a[o]),s={relatedTarget:a[o]};if(e(i).hasClass(f.SHOW)&&!(n&&("click"===n.type&&/input|textarea/i.test(n.target.tagName)||"focusin"===n.type)&&e.contains(i,n.target))){var l=e.Event(u.HIDE,s);e(i).trigger(l),l.isDefaultPrevented()||(a[o].setAttribute("aria-expanded","false"),e(i).removeClass(f.SHOW).trigger(e.Event(u.HIDDEN,s)))}}}},t._getParentFromElement=function(t){var n=void 0,r=Util.getSelectorFromElement(t);return r&&(n=e(r)[0]),n||t.parentNode},t._dataApiKeydownHandler=function(n){if(/(38|40|27|32)/.test(n.which)&&!/input|textarea/i.test(n.target.tagName)&&(n.preventDefault(),n.stopPropagation(),!this.disabled&&!e(this).hasClass(f.DISABLED))){var r=t._getParentFromElement(this),a=e(r).hasClass(f.SHOW);if(!a&&n.which!==s||a&&n.which===s){if(n.which===s){var o=e(r).find(h.DATA_TOGGLE)[0];e(o).trigger("focus")}e(this).trigger("click")}else{var i=e(r).find(h.VISIBLE_ITEMS).get();if(i.length){var d=i.indexOf(n.target);n.which===l&&d>0&&d--,n.which===c&&d<i.length-1&&d++,d<0&&(d=0),i[d].focus()}}}},_createClass(t,null,[{key:"VERSION",get:function(){return n}}]),t}();return e(document).on(u.KEYDOWN_DATA_API,h.DATA_TOGGLE,_._dataApiKeydownHandler).on(u.KEYDOWN_DATA_API,h.ROLE_MENU,_._dataApiKeydownHandler).on(u.KEYDOWN_DATA_API,h.ROLE_LISTBOX,_._dataApiKeydownHandler).on(u.CLICK_DATA_API+" "+u.FOCUSIN_DATA_API,_._clearMenus).on(u.CLICK_DATA_API,h.DATA_TOGGLE,_.prototype.toggle).on(u.CLICK_DATA_API,h.FORM_CHILD,function(e){e.stopPropagation()}),e.fn[t]=_._jQueryInterface,e.fn[t].Constructor=_,e.fn[t].noConflict=function(){return e.fn[t]=i,_._jQueryInterface},_}(jQuery);