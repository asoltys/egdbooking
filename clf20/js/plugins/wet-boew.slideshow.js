/* Web Experience Toolkit (WET) / Boîte à outils de l'expérience Web (BOEW)
Terms and conditions of use: http://tbs-sct.ircan.gc.ca/projects/gcwwwtemplates/wiki/Terms
Conditions régissant l'utilisation : http://tbs-sct.ircan.gc.ca/projects/gcwwwtemplates/wiki/Conditions
*/
window.gc = {
    prop: new Map(),
    web: new Object()
};
function Map(){
    this.array = new Array();
}
function KeyValue(_1, _2){
    this.key = _1;
    this.value = _2;
}
Map.prototype.put = function(_3, _4){
    if ((typeof _3 != "undefined") && (typeof _4 != "undefined")) {
        this.array[this.array.length] = new KeyValue(_3, _4);
    }
};
Map.prototype.get = function(_5){
    for (var k = 0; k < this.array.length; k++) {
        if (this.array[k].key == _5) {
            return this.array[k].value;
        }
    }
    return "";
};
Map.prototype.length = function(){
    return this.array.length;
};
 
var DomHelper = {
 
        $P: function(_1c, _1d){
                if (typeof _1d == "undefined") {
                        return window.gc.prop.get(_1c);
                }
                else {
                        window.gc.prop.put(_1c, _1d);
                }
        },
        createTag: function(_2b, sId, _2d, _2e, _2f, _30){
        var tag = document.createElement(_2b);
        tag.setAttribute("tabindex", 0);
        if (sId) {
            tag.setAttribute("id", sId);
        }
        if (_2d) {
            tag.setAttribute("height", _2d);
        }
        if (_2e) {
            tag.setAttribute("width", _2e);
        }
        if (_2f) {
            tag.setAttribute("style", _2f);
        }
        if (_30) {
            tag.style.cursor = "pointer";
        }
        return tag;
    },
        addEventListener: function(e, eT, eL, cap){
        eT = eT.toLowerCase();
        if (e.addEventListener) {
            e.addEventListener(eT, eL, cap || false);
        }
        else {
            if (e.attachEvent) {
                e.attachEvent("on" + eT, eL);
            }
            else {
                var o = e["on" + eT];
                e["on" + eT] = typeof o == "function" ? function(v){
                    o(v);
                    eL(v);
                }
: eL;
            }
        }
    },
        getElementsByTagName: function(t, p){
        var _34 = null;
        t = t || "*";
        p = p || document;
        if (typeof p.getElementsByTagName != "undefined") {
            _34 = p.getElementsByTagName(t);
            if (t == "*" && (!_34 || !_34.length)) {
                _34 = p.all;
            }
        }
        else {
            if (t == "*") {
                _34 = p.all;
            }
            else {
                if (p.all && p.all.tags) {
                    _34 = p.all.tags(t);
                }
            }
        }
        return _34 || [];
    },
        readAttribute: function(_4b, _4c){
        if (typeof _4b == "undefined") {
            alert("Undefined Object >> " + _4c);
        }
        else {
            return _4b.getAttribute(_4c, 2);
        }
    }
};
 
window.gc.web.slideshow = {
    sParent: null,
    timer: null,
    controls: null,
    slidecanvas: null,
    container: null,
    promotions: null,
    timer: null,
    active: true,
    slideindex: 0,
    ff: function(_11){
        var _12 = false;
        if (_11) {
            var _13 = _11.keyCode ? _11.keyCode : _11.which ? _11.which : _11.charCode;
            if ((_13 == 9) || (_13 == 16)) {
                _12 = true;
            }
        }
        if (_12 == false) {
                        if ( DomHelper.$P("slideshow.randomslide") )
                        {
                                window.gc.web.slideshow.slideindex = Math.floor(Math.random()*window.gc.web.slideshow.promotions.length);
                        }else {
                                window.gc.web.slideshow.slideindex++;
                        }
            if (!(window.gc.web.slideshow.slideindex < window.gc.web.slideshow.promotions.length)) {
                window.gc.web.slideshow.slideindex = 0;
            }
            window.gc.web.slideshow.addtocanvas(window.gc.web.slideshow.promotions[window.gc.web.slideshow.slideindex]);
        }
        return false;
    },
    rew: function(_14){
        var _15 = false;
        if (_14) {
            var _16 = _14.keyCode ? _14.keyCode : _14.which ? _14.which : _14.charCode;
            if ((_16 == 9) || (_16 == 16)) {
                _15 = true;
            }
        }
        if (_15 == false) {
            window.gc.web.slideshow.slideindex--;
            if (window.gc.web.slideshow.slideindex < 0) {
                window.gc.web.slideshow.slideindex = window.gc.web.slideshow.promotions.length - 1;
            }
            window.gc.web.slideshow.addtocanvas(window.gc.web.slideshow.promotions[window.gc.web.slideshow.slideindex]);
        }
        return false;
    },
    toggle: function(_17){
        var _18 = false;
        if (_17) {
            var _19 = _17.keyCode ? _17.keyCode : _17.which ? _17.which : _17.charCode;
            if ((_19 == 9) || (_19 == 16)) {
                _18 = true;
            }
        }
        if (_18 == false) {
            if (window.gc.web.slideshow.active) {
                window.gc.web.slideshow.active = false;
                window.gc.web.slideshow.controls.pp.firstChild.src = window.gc.web.slideshow.controls.playinfo.image;
                window.gc.web.slideshow.controls.pp.setAttribute("title", window.gc.web.slideshow.controls.playinfo.text);
            }
            else {
                window.gc.web.slideshow.active = true;
                window.gc.web.slideshow.controls.pp.firstChild.src = window.gc.web.slideshow.controls.pauseinfo.image;
                window.gc.web.slideshow.controls.pp.setAttribute("title", window.gc.web.slideshow.controls.pauseinfo.text);
            }
        }
        return false;
    },
    createplayer: function(_1a, _1b){
        this.active = (_1b) ? _1b : true;
        var _1c = {
            play: {
                id: "play",
                image: Utils.getSupportPath()  + "/slideshow/play-jouer.gif",
                text: (PE.language == "eng") ? "Play" : "Jouer"
            },
            pause: {
                id: "pause",
                image: Utils.getSupportPath()  + "/slideshow/pause.gif",
                text: "Pause"
            },
            fforward: {
                id: "fforward",
                image: Utils.getSupportPath()  + "/slideshow/next-suiv.gif",
                text: (PE.language == "eng") ? "Next" : "Suivant"
            },
            rewind: {
                id: "rewind",
                width: 34,
                image: Utils.getSupportPath()  + "/slideshow/prev-prec.gif",
                text: (PE.language == "eng") ? "Previous" : "Pr\xe9c\xe9dent"
            }
        };
        this.container = document.createElement("div");
        this.container.setAttribute("id", "slideshow-container");
        this.slidecanvas = {
            container: DomHelper.createTag("div", "slidecontainer"),
            image: DomHelper.createTag("img", "slidecontainer-image"),
            link: DomHelper.createTag("a", "slidecontainer-link")
        };
		this.slidecanvas.container.setAttribute("role","marquee");
        this.slidecanvas.link.appendChild(this.slidecanvas.image);
        Tltps.blessLink(this.slidecanvas.link);
        this.slidecanvas.container.appendChild(this.slidecanvas.link);
        var _1d = document.createElement("div");
		
        _1d.setAttribute("id", "slideinterface");
        jQuery(_1d).css({'background' : 'url('+Utils.getSupportPath()+'/slideshow/deco.gif)'});
        this.controls = {
            rewind: window.gc.web.slideshow.createButton(_1c.rewind, _1d, window.gc.web.slideshow.rew, this.slidecanvas.container),
            pp: window.gc.web.slideshow.createButton(_1c.pause, _1d, window.gc.web.slideshow.toggle, this.slidecanvas.container),
            fforward: window.gc.web.slideshow.createButton(_1c.fforward, _1d, window.gc.web.slideshow.ff, this.slidecanvas.container),
            playinfo: _1c.play,
            pauseinfo: _1c.pause
        };
        this.container.appendChild(this.slidecanvas.container);
        this.container.appendChild(_1d);
                
        window.gc.web.slideshow.loadimagesequence(_1a);
                var pNode = $("#"+_1a);
        pNode.before(this.container);
    },
    addtocanvas: function(_1e){
       // alert('Debug :: src -> '+_1e.imgsrc+' | alt -> '+_1e.text+' | href -> '+_1e.href );
        this.slidecanvas.image.setAttribute("src", _1e.imgsrc);
        this.slidecanvas.image.setAttribute("alt", _1e.text);
        this.slidecanvas.image.setAttribute("title", _1e.text);
        this.slidecanvas.link.setAttribute("href", _1e.href);
        this.slidecanvas.link.setAttribute("title", _1e.text);
    },
    createButton: function(_1f, _20, _21, _22){
        var tag = document.createElement("a");
        tag.setAttribute("id", _1f.id + "-id");
        tag.setAttribute("title", _1f.text);
        tag.setAttribute("tabindex", "0");
		tag.setAttribute("aria-controls", _22.id);
        tag.style.cursor = (jQuery.browser.msie && !(window.XMLHttpRequest)) ? "hand" : "pointer";
        tag.setAttribute("href", "javascript://");
        DomHelper.addEventListener(tag, "click", _21, false);
        Tltps.blessLink(tag);
        var _23 = document.createElement("img");
        _23.setAttribute("src", _1f.image);
        _23.setAttribute("alt", _1f.text);
        _23.setAttribute("height", "19px");
        if (_1f.width) {
      _23.setAttribute("width", _1f.width);
}else {
    _23.setAttribute("width", "20px");
};
 
        tag.appendChild(_23);
        _20.appendChild(tag);
        return tag;
    },
    promotionweight: function(_24){
        if (_24.indexOf("ss-double") > -1) {
            return 2;
        }
        if (_24.indexOf("ss-triple") > -1) {
            return 3;
        }
        if (_24.indexOf("ss-quadruple") > -1) {
            return 4;
        }
        return 1;
    },
    addtopromotions: function(_25, _26){
        var _27 = true;
        for (var i = 0; i < _25.length; i++) {
            var _29 = (i > 0) ? (i - 1) : i;
            if ((_25[_29].imgsrc != _26.imgsrc) && (_25[i].imgsrc != _26.imgsrc) && _27) {
                _25.splice(i, 0, _26);
                _27 = false;
            }
        }
    },
    loadimagesequence: function(_2a){
        var _2b = $("#" + _2a + " > li");
        this.promotions = new Array();
        for (var i = 0; i < _2b.length; i++) {
        if ($('#' + _2a + ' > li:eq('+i+') > a > img').length != 0 ) {
        
            var _2d = {
                imgsrc: $('#' + _2a + ' > li:eq('+i+') > a > img:eq(0)').attr('src'),
                href: $('#' + _2a + ' > li:eq('+i+') > a:eq(0)').attr("href"),
                wieght: window.gc.web.slideshow.promotionweight(_2b[i].className)
            };
            $('#' + _2a + ' > li:eq('+i+') > a > img:eq(0) ').remove();           
            $('#' + _2a + ' > li:eq('+i+') > a > br').remove();
            
            // Hot Fix 1.1 - Firefox 3.5+ needs a more vanilla DOM model to find appropriate element
            _2d.text = jQuery.trim($('#' + _2a + ' > li:eq('+i+') > a').text());
 
            this.promotions.push(_2d);
            if (_2d.wieght > 1) {
                for (var w = 0; w < _2d.wieght - 1; w++) {
                    window.gc.web.slideshow.addtopromotions(this.promotions, _2d);
                }
           }
           }
        }
        window.gc.web.slideshow.addtocanvas(this.promotions[0]);
        this.slideindex = 0;
    },
    rotateslide: function(){
        if (window.gc.web.slideshow.active) {
            window.gc.web.slideshow.ff();
        }
        return false;
    },
    execute: function(){
           /** New Parameter System
            *  TODO: Recode Slideshow to remove deprecated dependencies on DomHelper, and Map Object
            */ 
            var sParams = Utils.loadParamsFromScriptID("slideshow");
            DomHelper.$P("slideshow.speed", (sParams.speed) ? sParams.speed : "8");
                        DomHelper.$P("slideshow.randomslide", (sParams.randomslide) ? true : false );
        
                        if ( jQuery("#"+sParams.id).length != 0 ) { 
                                window.gc.web.slideshow.createplayer(sParams.id, DomHelper.$P("slideshow.active"));
                                window.gc.web.slideshow.timer = setInterval("window.gc.web.slideshow.rotateslide()", (DomHelper.$P("slideshow.speed") * 1000));
                        }       
    }
};
// Add the stylesheet for this plugin
Utils.addCSSSupportFile( Utils.getSupportPath()+"/slideshow/style.css");
// Bind the execute function to the page instance
$("document").ready(function(){   
	 window.gc.web.slideshow.execute();
	 $('#slideshow').remove();
																  
 });
