//
//  Mobile UI
//
//  Created by Matthew on 2012-10-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//
package mobile.view {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.SimpleButton;
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.events.*;
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	import com.greensock.loading.*;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.display.*;
	import mobile.model.*;
	 public class mobileUI  extends MovieClip{
		
			public var _model:mobileModel;
			public var _primaryNav:MenuCollapse;
			public var _secondaryNav:MovieClip;
			public var _close:SimpleButton;
			public var _guide:SimpleButton;
			public var _saved:SimpleButton;
			public var _search:SimpleButton;
			public var _subGuide:MovieClip;
			public var _subSaved:MovieClip;
			public var _subSearch:MovieClip;
			
			public var _recentActivity:SimpleButton;
			public var _recordings:SimpleButton;
			public var _downloads:SimpleButton;
			
			public var _recentActivityOn:SimpleButton;
			public var _recordingsOn:SimpleButton;
			public var _downloadsOn:SimpleButton;
			
			public var _fullListing:SimpleButton;
			public var _fullListingOn:SimpleButton;
		
		
		public function mobileUI(model:mobileModel) {
			
			//  link model and create  'Menu Collapse' (from library)
			this._model = model;
			this._primaryNav = new MenuCollapse();
			addChild(_primaryNav);
			
			// get and set all instances witin element
			this._guide = _primaryNav._guide;
			this._saved = _primaryNav._saved;
			this._search = _primaryNav._search;
			
			this._secondaryNav = _primaryNav._secondaryNav;
			this._close = _secondaryNav._close;
			this._subGuide = _primaryNav._secondaryNav._subGuide;
			this._subSaved = _primaryNav._secondaryNav._subSaved;
			this._subSearch = _primaryNav._secondaryNav._subSearch;
			
			this._recentActivity = _subSaved._recentActivity;
			this._recordings = _subSaved._recordings;
			this._downloads = _subSaved._downloads;
			this._fullListing = _subGuide._fullListing;
			
			this._recentActivityOn = _subSaved._recentActivityOn;
			this._recordingsOn = _subSaved._recordingsOn;
			this._downloadsOn = _subSaved._downloadsOn;
			this._fullListingOn = _subGuide._fullListingOn;

			// set defaults
			_primaryNav.x = 8;
			_primaryNav.y = 8;
			_primaryNav.visible= false;
			_primaryNav._collapseOn.visible = false;
		
			
		}
	 public function resetNavigation():void{
			
			this._close.visible = false;
			_primaryNav._collapse.txt.text = "Menu";
	
	}
	public function navigationOnOff(navigationOnOff:Boolean){
		
		// show and hide primary navigation
		if(navigationOnOff== true ){
			_primaryNav.visible= true;
			TweenLite.to(_primaryNav, 1.2, { autoAlpha:1, ease:Expo.easeOut});	
	
		}else{
			TweenLite.to(_primaryNav, 0.2, {autoAlpha:0,  ease:Expo.easeOut});
			_primaryNav.visible= false;
			
		}

		
	}
	
	public function setNavigation():void{
		
		// get from updates from model
		var availbleSections = this._model.sections;
		var nextSection = this._model.openSection;
		var closeOnOff = this._model.closeOnOff;
		
		// loop sections array and find tmobileed primary nav element
		var i:uint
		for(i= 0; i< availbleSections.length; i++){
			
			if(availbleSections[i].clip==nextSection){
			
			// set button highlight and exchange 'menue' txt with primary title
			buttonOn(nextSection);
			_primaryNav._collapse.txt.text = availbleSections[i].title
			
			// show seconary navigation options in chrome
			var sub = "_sub"+availbleSections[i].title
			this[sub].visible = true;
			this._close.visible = true;
			
	
			}else{
			
			// set other primarys and secondarys to deselect
			buttonOff(availbleSections[i].clip);
			var resetSub = "_sub"+availbleSections[i].title
			this[resetSub].visible = false;


			}
		}
		
	
		
	}
	
	public function setSubNavigation():void{

		var subArray = this._model._subSections
		var whatPrimaryIsOpen = this._model._whatPrimaryIsOpen;
		var nextSub = this._model._openSubSection;
		
		
		if(whatPrimaryIsOpen == "Search"){return;}
		
		var i:uint
		for(i= 0; i< subArray.length; i++){
			
			if(subArray[i]==nextSub){
			
			this[nextSub].visible = false;
			this[nextSub+"On"].visible = true;
	
			}else{
				
			this[subArray[i]].visible = true;
			this[subArray[i]+"On"].visible = false;

			}
		}
		
	}	

	
	public function buttonOn(_button:String){
			
			_primaryNav[_button].visible = false;
			_primaryNav[_button+"On"].visible = true;
		
	}
	public function buttonOff(_button:String){
	
			_primaryNav[_button].visible = true;
			_primaryNav[_button+"On"].visible = false;
		
	}
	



	}

};

