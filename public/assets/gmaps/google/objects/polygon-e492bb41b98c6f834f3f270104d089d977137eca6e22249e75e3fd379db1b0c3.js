(function(){var t=function(t,e){function n(){this.constructor=t}for(var r in e)o.call(e,r)&&(t[r]=e[r]);return n.prototype=e.prototype,t.prototype=new n,t.__super__=e.prototype,t},o={}.hasOwnProperty;this.Gmaps.Google.Objects.Polygon=function(o){function e(t){this.serviceObject=t}return t(e,o),e.include(Gmaps.Google.Objects.Common),e.prototype.updateBounds=function(t){var o,e,n,r,s;for(s=[],o=0,e=(r=this.serviceObject.getPath().getArray()).length;o<e;o++)n=r[o],s.push(t.extend(n));return s},e}(Gmaps.Base)}).call(this);