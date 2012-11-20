﻿package app.control{	import app.*;	import app.model.*;	import app.view.*;	import app.control.*;	import mobile.mobile;	import mobile.model.mobileModel;	import fl.controls.Button;	import flash.display.MovieClip;	import flash.events.Event	import flash.events.MouseEvent;	import flash.events.KeyboardEvent;	import flash.ui.Keyboard;	import flash.events.GestureEvent;	import flash.events.PressAndTapGestureEvent;	import flash.events.TouchEvent;	import flash.ui.Multitouch;	import flash.ui.MultitouchInputMode;	import flash.events.FocusEvent;	import com.greensock.*;	import com.greensock.easing.*;	import com.greensock.plugins.*;	import com.greensock.loading.*;	import com.greensock.events.LoaderEvent;	import com.greensock.loading.display.*;			public class AppControl extends MovieClip{		private var model:AppModel;		private var _viewIndex:int;		private var _views:Array;		private var _uiarr:Array;		private var _ui:MovieClip;		private var _content:MovieClip;		private var _entity:Entity;		private var _mobileModel:mobileModel		private var _canvas:hitme_lg;		private var _mobilelock:String;		Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;		public function AppControl(model:AppModel) {			this.model = model;			this._views = new Array();			this._canvas = new hitme_lg();			addChild(_canvas);			this._content = new MovieClip();			addChild(_content);			/*this.model.holder = this._content;*/			var stage = model.holder.stage;			_uiarr = new Array();						var _grid:AppView = new Grid(model, this, this._content);			addView(_grid);									// fake user request for 'downloads' would be object listening for user input 			this._ui = new mobile();			this._mobileModel = _ui.model			addChild(_ui);						_mobileModel.addEventListener(mobileModel.UPDATE_APP, updateUI);			_mobilelock = '';				_canvas.addEventListener(TouchEvent.TOUCH_TAP, onTouchTap);			_canvas.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);			_canvas.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);			_canvas.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);						_content.addEventListener(TouchEvent.TOUCH_TAP, onTouchTap);			_content.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);			_content.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);			_content.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);		}									public function onTouchTap(e:TouchEvent):void {						if(e.target.parent.state){ _entity = _views[_viewIndex].current.entity;this.model.destinationEntity = _entity; destination(_entity); }			_views[_viewIndex].current.TouchSelect(e);							/*	_entity = _views[_viewIndex].current.entity;this.model.destinationEntity = _entity; destination(_entity);*/		}		public function onTouchBegin(e:TouchEvent):void {			_views[_viewIndex].current.TouchBegin(e);		}		public function onTouchMove(e:TouchEvent):void {						_views[_viewIndex].current.TouchMove(e);		}		public function onTouchEnd(e:TouchEvent):void {						_views[_viewIndex].current.TouchEnd(e);		}		public function keyPressedDown(e:KeyboardEvent):void {						var key:uint = e.keyCode;			trace("keypress");			switch (key) {			  	case Keyboard.LEFT :		_views[_viewIndex].current.Select([0,-1]);		break;				case Keyboard.RIGHT :		_views[_viewIndex].current.Select([0,1]); 		break;				case Keyboard.UP :			_views[_viewIndex].current.Select([-1,0]); 		break;				case Keyboard.DOWN :		_views[_viewIndex].current.Select([1,0]);		break;				//case Keyboard.SPACE:				// _entity = _views[_viewIndex].current.entity;this.model.destinationEntity = _entity; destination(_entity); break;												case Keyboard.SPACE:								if (_views[_viewIndex].current.sel_item.actionbar!=null && _views[_viewIndex].current.sel_item.actionbar.focused){ 					_entity = _views[_viewIndex].current.entity;this.model.destinationEntity = _entity; destination(_entity); 				} else { 					_views[_viewIndex].current.SelActions(); 				}					break;					}		}	 public function destination(_entity:Entity):void{						switch(_entity.TYPE){				case"Series":				trace("I am a Series");							break;				case "Episode":				this.model.episodes = "'"+_entity.TITLE+"'";				break;				case "Movie":				toggleViews();				this.model.catalog = ["Featured Movies"];							break;			}	}		public function updateUI(e:Event):void{		var mobileQuery = e.target._openSubSection		this.model.drawerIsOpen = e.target.drawerIsOpen;		trace(this.model.drawerIsOpen);		_views[_viewIndex].nudge();		if(_mobilelock == mobileQuery){ return }			switch(mobileQuery){				case "_recentActivity": 	toggleViews(); this.model.catalog = [ "Featured Movies","Premium Movies", "New Releases", "Free Movies"];break;				case "_recordings": 	toggleViews();this.model.catalog = [ "Featured Tv", "Top Drama", "Top Watched", "Kids Tv"];break;				case "_downloads": 	toggleViews();this.model.catalog = [ "Top Watched", "Kids Tv"];break;				case "_fullListing": 	toggleViews();this.model.catalog = [ "New Releases", "Free Movies"];break;			}			_mobilelock = mobileQuery;	}				public function addView(view:AppView):void{			_views.push(view);			if(_views.length == 1){ _content.addChild(view); _viewIndex = 0; }			} 		private function toggleViews():void{				_content.removeChild(_views[_viewIndex]);				_content.addChild(_views[_viewIndex]);		}		// add touch, mouse, and keyboard controls 		private function entity(e:Event):void{				_entity = e.target.parent.entity			this.model.destinationEntity = _entity;						switch(_entity.TYPE){				case"Series":				trace("I am a Series");				this.model.episodes = "'"+_entity.TITLE+"'";				break;				case "Episode":				trace("I am a Episode");				break;				case "Movie":				trace("I am a Movie");					toggleViews();					this.model.catalog = ["Featured Tv"];				break;			}			/*if(_entity.TYPE =="Series"){ this.model.episodes = "'"+_entity.TITLE+"'"; }*/					}		private function onTv(e:Event):void{			toggleViews();			/*	this.model.catalog = ["Featured Tv", "Top Drama", "Top Watched"];*/			this.model.catalog = [ "Featured Tv", "Top Drama", "Top Watched", "Kids Tv"];		}					private function onMovies(e:Event):void{			toggleViews();			this.model.catalog = [ "Featured Movies","Premium Movies", "New Releases", "Free Movies"];		}			private function onDownloads(e:Event):void{			toggleViews();		/*	this.model.catalog = [ "Featured Movies","Premium Movies", "New Releases", "Free Movies"];*/		}		public function update(e:Event):void {		trace("Update UI")		}			}}