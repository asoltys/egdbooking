/*  Web Experience Toolkit (WET) / Boîte à outils de l'expérience Web (BOEW)
	Terms and conditions of use: http://tbs-sct.ircan.gc.ca/projects/gcwwwtemplates/wiki/Terms
	Conditions régissant l'utilisation : http://tbs-sct.ircan.gc.ca/projects/gcwwwtemplates/wiki/Conditions
*/

/**
 * @name : Multimedia Player Plugin
 * @author : Government of Canada 
 */
 
 /*
  * Load helper libraries
  */
PE.load('jquery.plugin.js');
PE.load('jquery.template.js');

/**
 * Load Default Theme
 * TODO: This function should be extended to allow intelligent style sheet additions so that plugins can have various stylesheets
 */
Utils.addCSSSupportFile(Utils.getSupportPath() + '/multimedia/themes/default/style.css');
// Preload Images for smoother interface
Utils.preLoadImages(
	Utils.getSupportPath() + '/multimedia/themes/default/images/fastforward-control.png',
	Utils.getSupportPath() + '/multimedia/themes/default/images/background-toolbar.png',
	Utils.getSupportPath() + '/multimedia/themes/default/images/pause-control.png',
	Utils.getSupportPath() + '/multimedia/themes/default/images/play-control.png',
	Utils.getSupportPath() + '/multimedia/themes/default/images/cc-off-control.png',
	Utils.getSupportPath() + '/multimedia/themes/default/images/cc-on-control.png',
	Utils.getSupportPath() + '/multimedia/themes/default/images/rewind-control.png',
	Utils.getSupportPath() + '/multimedia/themes/default/images/sound-control.png',
	Utils.getSupportPath() + '/multimedia/themes/default/images/mute-control.png',
	Utils.getSupportPath() + '/multimedia/themes/default/images/play-button-overlay.png'
);



/*
 *  Multimedia Controller
 */
var mPlayerRemote = {
	// this singleton only wants one plugin so create a private property
	_plugin : null,
            
	getPluginInstance : function(options) {   
		if (this._plugin === null)
		{
			// lets set the default
			this._plugin = false;
			// lets check to make sure flash and/or silverlight is available
			if ($.browser.plugin.flash.isAvailable || $.browser.plugin.silverlight.isAvailable )
			{ 
                 
				if ($.browser.plugin.flash.isAvailable && $.browser.plugin.flash.isVersionSupported(options.flash.required) && ( options.force.length === 0 || options.force.toLowerCase() === 'flash' )) 
				{
					// check to see if flash version is supported
					this._plugin  = $.browser.plugin.flash;
					$.extend( true, this._plugin, options.flash );               
				}
				else if ($.browser.plugin.silverlight.isAvailable && $.browser.plugin.silverlight.isVersionSupported(options.silverlight.required) && ( options.force.length === 0 || options.force.toLowerCase() === 'silverlight' )) 
				{
					// check to see if flash version is supported
					this._plugin = $.browser.plugin.silverlight;
					$.extend ( true, this._plugin, options.silverlight )
				}
			}
		}
		// like all Singletons we return the reference to the object
		return this._plugin;
	},
         
	exec : function( pid, fname, api, args) {               
		var playerObject = (navigator.appName.indexOf("Microsoft Internet")!=-1) ?  document.getElementById(pid) : $('#' + pid+ '')[0];
		// Execute command
               PlayerLib[this._plugin.namespace].objectRef(playerObject)[api](args);
          
		// Call the interface Update
		this.update( pid, fname );
	},

	addListener: function(obj, evt, handler, captures)
	{
		if ( document.addEventListener )
			obj.addEventListener(evt, handler, captures);
		else
			obj.attachEvent('on' + evt, handler);// IE
	},
    
	registerListener : function(eventName, objID, listenerFcn)
	{
		var obj = document.getElementById(objID);
		if ( obj )
			this.addListener(obj, eventName, listenerFcn, false);
	},
    
	update : function(pid, fname, prm1, prm2)
	{
		// Update Interface
		switch (fname)
		{
			case "play":
				$("#"+pid+"PlayStopButton").children('span.ui-icon-control-play').removeClass('ui-icon-control-play').addClass('ui-icon-control-pause');
				$("#"+pid+"PlayStopButton").children('span.cn-invisible').text(PlayerLib.dictionary.txt_pause);
				$("#"+pid+"PlayStopButton").attr('title', PlayerLib.dictionary.txt_pause);
				break;
			case "pause":
				$("#"+pid+"PlayStopButton").children('span.ui-icon-control-pause').removeClass('ui-icon-control-pause').addClass('ui-icon-control-play');
				$("#"+pid+"PlayStopButton").children('span.cn-invisible').text(PlayerLib.dictionary.txt_play);
				$("#"+pid+"PlayStopButton").attr('title', PlayerLib.dictionary.txt_play);

				break;
			case "captions":
				$("#"+pid+"CaptionOnOffButton").children('span.ui-icon-control-closed-caption-off').removeClass('ui-icon-control-closed-caption-off').addClass('ui-icon-control-closed-caption-on');
				$("#"+pid+"CaptionOnOffButton").children('span.cn-invisible').text(PlayerLib.dictionary.txt_closedcaptions_on);
				$("#"+pid+"CaptionOnOffButton").attr('title', PlayerLib.dictionary.txt_closedcaptions_on);
				break;
			case "nocaptions":
				$("#"+pid+"CaptionOnOffButton").children('span.ui-icon-control-closed-caption-on').removeClass('ui-icon-control-closed-caption-on').addClass('ui-icon-control-closed-caption-off');
				$("#"+pid+"CaptionOnOffButton").children('span.cn-invisible').text(PlayerLib.dictionary.txt_closedcaptions_off);
				$("#"+pid+"CaptionOnOffButton").attr('title', PlayerLib.dictionary.txt_closedcaptions_off);
				break;
			case "mute":
				$("#"+pid+"MuteUnmuteButton").children('span.ui-icon-control-sound').removeClass('ui-icon-control-sound').addClass('ui-icon-control-mute');
				$("#"+pid+"MuteUnmuteButton").children('span.cn-invisible').text(PlayerLib.dictionary.txt_unmute);
				$("#"+pid+"MuteUnmuteButton").attr('title',PlayerLib.dictionary.txt_unmute);
				break;
			case "unmute":
				$("#"+pid+"MuteUnmuteButton").children('span.ui-icon-control-mute').removeClass('ui-icon-control-mute').addClass('ui-icon-control-sound');
				$("#"+pid+"MuteUnmuteButton").children('span.cn-invisible').text(PlayerLib.dictionary.txt_mute);
				$("#"+pid+"MuteUnmuteButton").attr('title',PlayerLib.dictionary.txt_mute);
				break;
			case "totalTime":
				$("#"+pid+"Duration").text(prm1);
				$("#"+pid+"Position").text("00:00");				
				
				break;
			case "currentTime" :
				$("#"+pid+"Position").text(prm1);
				break;
			case "loaded" :
				if (!isNaN(prm1))
				{
					$("#"+pid+"Buffered").text("["+ prm1 + "%]");
				}
				break;
		}
	}
};

/**
 *  Player Library of apicalls 
 *  TODO: We could modularize this alot more
 */
var PlayerLib = {
	// Dictonary Terms
	dictionary : {
		txt_play : (PE.language === 'eng') ? "Play " : "Démarrer ",
		txt_pause : "Pause ",
		txt_closewindow : (PE.language === 'eng') ? "Close" : "Fermer",
		txt_rewind : (PE.language === 'eng') ? "Rewind " : "Reculer ",
		txt_fastforward : (PE.language === 'eng') ? "Fast forward " : "Avancer ",
		txt_mute: (PE.language === 'eng') ? "Mute" : "Activer le mode muet",
		txt_unmute: (PE.language === 'eng') ? "Unmute" : "Désactiver le mode muet",
		txt_closedcaptions_on: (PE.language === 'eng') ? "Hide Closed captioning " : "Masquer le sous-titrage ",
		txt_closedcaptions_off: (PE.language === 'eng') ? "Show Closed captioning" : "Afficher le sous-titrage ",
		txt_novideo : (PE.language === 'eng') ? "Your browser does not appear to have the capabilities to play this video, please download the video below":
							      "Votre navigateur ne semble pas avoir les capacité nécessaires pour lire cette vidéo, s'il vous plaît télécharger la vidéo ci-dessous",
		txt_position: (PE.language === 'eng') ? "Current Position: " : "Position actuelle : ",
		txt_duration: (PE.language === 'eng') ? "Total Time: " : "Temps total : ",
		txt_buffered: (PE.language === 'eng') ? "Buffered: " : "Mis en mémoire-tampon : "
	},
	
	'flash' : {
		objectRef : function(ref) {  return ref  },
		play : 'togglePlay',
		pause : 'togglePlay',
		captions : { on : 'toggleCaptions', off : 'toggleCaptions' },
		mute : { on : 'toggleMute', off : 'toggleMute' } ,
		fastforward : 'seek',
		rewind : 'seek'
	},
    
	'silverlight' : {
		objectRef : function(ref) {  return ref.Content.Player  },
		play : 'play',
		pause : 'pause',
		captions : { on : 'toggleCaptions', off : 'toggleCaptions' },
		mute : { on : 'toggleMute', off : 'toggleMute' } ,
		fastforward : 'fastForward',
		rewind : 'rewind'
	}
};

/*
 * Extend jQuery to include function for media player
 */

 (function($){
	$.fn.mediaPlayer = function(options) {
		// there's no need to do $(this) because
		// "this" is already a jquery object
    
		// get a unique id for the object tag
		var _registerPlayer = function() { var now = new Date(); var num = (now.getMilliseconds()); return 'mp'+num }
    
		var _createPlayer = function(elm){
			// Create the parameters for the source code
			var _id = _registerPlayer();
			// Section where we will initiate properties for the mediaplayer
			var node = $(elm);
      
			// now get the xml for parsing
			//var docNode = (node.find('.mp-alternative').attr('href').match())
			// Create a properties file
			var properties = {
				//height : (node.hasClass('force-dimensions')) ? node.find('img.posterimg').attr('height') : Math.round( node.find('img.posterimg').attr('width')*900 / 1600 ),
				//width : node.find('img.posterimg').attr('width'),
				height : "480",
				width : "655",
				id : _id,
				//scale : (node.is('.scale-fill, .scale-zoom') ) ? node.hasClass('scale-fill') ? 'fill' : 'zoom' : '', 
				posterimg : node.find('img.posterimg').get(0).src,
				title : node.find('img.posterimg').attr('alt'),
				arialabel: node.find('img.posterimg').attr('alt'),
				//media : (mPlayerRemote.getPluginInstance().namespace != 'flash') ? node.find('.mp-wmv a').get(0).href : node.find('.mp-mp4 a').get(0).href,
				media : node.find('.mp-flv a').get(0).href,
				captions : node.find(".mp-tt a").get(0).href
			};
         
			var ht_ml = "\n<!-- Autogenerated code by mediaplayer plugin -->\n\n";
			// Use the Plugins Plugin to give us the object text required for the browser
			ht_ml += mPlayerRemote.getPluginInstance().embed( properties );
			// Add the tool bar
			ht_ml += '<div class="wet-boew-toolbar">'
			+ '<div class="wet-boew-controls-start">'
			+ '<a id="${jsId}RewindButton" href="javascript:;" class="wet-boew-button rewind" title="${txt_rewind}" aria-controls="${jsId}"><span class="ui-icon ui-icon-control-rewind"></span><span class="wet-boew-ui-state-hidden">${txt_rewind}</span></a>'
			+ '<a id="${jsId}PlayStopButton" href="javascript:;" class="wet-boew-button ui-button-first" title="${txt_play}" aria-controls="${jsId}"><span class="ui-icon ui-icon-control-play"></span><span class="cn-invisible">${txt_play}</span></a>'
			+ '<a id="${jsId}FastForwardButton" href="javascript:;" class="wet-boew-button fastforward" title="${txt_fastforward}" aria-controls="${jsId}"><span class="ui-icon ui-icon-control-fastforward"></span><span class="cn-invisible">${txt_fastforward}</span></a>'
			+ '</div><div class="wet-boew-controls-end">'
			+ '<a id="${jsId}CaptionOnOffButton" href="javascript:;" class="wet-boew-button cc" title="${txt_closedcaptions_off}" aria-controls="${jsId}"><span class="ui-icon ui-icon-control-closed-caption-off"></span><span class="cn-invisible">${txt_closedcaptions_off}</span></a>'
			+ '<a id="${jsId}MuteUnmuteButton" href="javascript:;" class="wet-boew-button ui-button-last mute" title="${txt_mute}" aria-controls="${jsId}"><span class="ui-icon ui-icon-control-sound"></span><span class="cn-invisible">${txt_mute}</span></a>'
			+ '</div><div class="wet-boew-controls-middle">'
			+ '<span class="cn-invisible" id="lbl${jsId}Position">${txt_position}</span><span id="${jsId}Position" class="ui-display-position" aria-role="timer" aria-labelledby="lbl${jsId}Position">--:--</span><span>/</span>'
			+ '<span class="cn-invisible" id="lbl${jsId}Duration">${txt_duration}</span><span id="${jsId}Duration" class="ui-display-duration" aria-role="status" aria-labelledby="lbl${jsId}Duration">--:--</span>'
			+ '<span class="cn-invisible" id="lbl${jsId}Buffered"> ${txt_buffered}</span><span>&nbsp;</span><span id="${jsId}Buffered" class="ui-display-buffered" aria-role="status" aria-labelledby="lbl${jsId}Buffered">[--]</span><span></span>'
			+ '</div></div>'
      
			ht_ml = ht_ml + "\n\n<!-- End of Autogenerated code by mediaplayer plugin -->\n";
			// Cache the complete object code and into the Template
			$.template("mpmarkup", ht_ml);
      
			// Load the vars that will populate the object code
      
			var template = $.extend( 
				{
					jsId : _id
				}, 
				PlayerLib.dictionary 
			);
      
			// Create the element to bind events to
			var _mediaplyr = $.tmpl('mpmarkup', template);
			$(elm).prepend(_mediaplyr);
			$(elm).children("img").remove();
			// now tweak toolbar width and some restrictions
			$(elm).find('.wet-boew-toolbar').width(properties.width - 2); // minus 2 px for 1px border on each side
			if ( $(elm).find('.wet-boew-toolbar').width()  < 200 ) {
				$(elm).find('.ui-display-buffered').addClass('cn-invisible');
			}
	       
			//Initialize the event handlers
			$('#' + _id + 'RewindButton').click(
				function(){
					mPlayerRemote.exec(_id,'rewind', PlayerLib[mPlayerRemote.getPluginInstance().namespace].rewind, -5);
				}
			);
			
			$('#' + _id + 'PlayStopButton').click(
				function(){
					if ($(this).children("span.ui-icon-control-play").length > 0)
					{
						mPlayerRemote.exec(_id,'play', PlayerLib[mPlayerRemote.getPluginInstance().namespace].play);
					}else{
						mPlayerRemote.exec(_id,'pause', PlayerLib[mPlayerRemote.getPluginInstance().namespace].pause);
					}
				}
			);
				
			$('#' + _id + 'FastForwardButton').click(
				function(){
					mPlayerRemote.exec(_id,'fastforward', PlayerLib[mPlayerRemote.getPluginInstance().namespace].fastforward, 5);
				}
			);
				
			$('#' + _id + 'CaptionOnOffButton').click(
				function(){
					if ($(this).children("span.ui-icon-control-closed-caption-off").length > 0)
					{
						mPlayerRemote.exec(_id,'caption', PlayerLib[mPlayerRemote.getPluginInstance().namespace].captions.on);
					}else{
						mPlayerRemote.exec(_id,'nocaption', PlayerLib[mPlayerRemote.getPluginInstance().namespace].captions.off);
					}
				}
			);
				
			$('#' + _id + 'MuteUnmuteButton').click(
				function(){
					if ($(this).children("span.ui-icon-control-sound").length > 0)
					{
						mPlayerRemote.exec(_id,'mute', PlayerLib[mPlayerRemote.getPluginInstance().namespace].mute.on);
					}else{
						mPlayerRemote.exec(_id,'unmute', PlayerLib[mPlayerRemote.getPluginInstance().namespace].mute.off);
					}
				}
			);

		}
     
		if (mPlayerRemote.getPluginInstance())
		this.each( function(){ _createPlayer($(this)); } )
	};
})( jQuery );

 /*
  *  Runtime Hook to document.ready()
  */
 
$(document).ready( function(){
  
  // Default settings
  var config_settings = {
       flash  : { required : '10.1', data : Utils.getSupportPath() + '/multimedia/mp-jm.swf' },
       silverlight : { required : '3.0',  parameters : { source : Utils.getSupportPath() + '/multimedia/mp-jm.xap' } },
       force : ( Utils.loadParamsFromScriptID('multimedia').force ) ? Utils.loadParamsFromScriptID('multimedia').force : '' 
   };
   
   // Lets init the player instance for the mediaplayer to use 
   mPlayerRemote.getPluginInstance( config_settings );
  // Load the mediaplayer
  $('.mediaplayer').mediaPlayer( config_settings );
  
});
