(function(){var t=function(t,o){function n(){this.constructor=t}for(var r in o)e.call(o,r)&&(t[r]=o[r]);return n.prototype=o.prototype,t.prototype=new n,t.__super__=o.prototype,t},e={}.hasOwnProperty;this.Gmaps.Google.Objects.Marker=function(e){function o(t){this.serviceObject=t}return t(o,e),o.include(Gmaps.Google.Objects.Common),o.prototype.updateBounds=function(t){return t.extend(this.getServiceObject().position)},o.prototype.panTo=function(){return this.getServiceObject().getMap().panTo(this.getServiceObject().getPosition())},o}(Gmaps.Base)}).call(this);