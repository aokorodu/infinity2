﻿package app.control{	import app.*;	import app.model.*;	import app.view.*;	import app.control.*;	import fl.controls.Button;	import flash.display.MovieClip;	import flash.events.Event	import flash.events.MouseEvent;	import flash.events.KeyboardEvent;	import flash.ui.Keyboard;	import flash.events.GestureEvent;	import flash.events.PressAndTapGestureEvent;	import flash.events.TouchEvent;	import flash.ui.Multitouch;	import flash.ui.MultitouchInputMode;	import flash.events.FocusEvent;	import com.greensock.*;	import com.greensock.easing.*;	import com.greensock.plugins.*;	import com.greensock.loading.*;	import com.greensock.events.LoaderEvent;	import com.greensock.loading.display.*;			public class AppControl extends MovieClip{		private var model:AppModel;		private var _viewIndex:int;		private var _views:Array;		private var _uiarr:Array;		private var _ui:MovieClip;		private var _content:MovieClip;		private var _entity:Entity;/*		Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;*/		public function AppControl(model:AppModel) {			this.model = model;			this._views = new Array();			this._content = new MovieClip();			addChild(_content);			/*this.model.holder = this._content;*/			var stage = model.holder.stage;			_uiarr = new Array();						var _grid:AppView = new Grid(model, this, this._content);			addView(_grid);									// fake user request for 'downloads' would be object listening for user input 			_ui = new MovieClip(); addChild(_ui);			var _shows = new ButtonTv(); _ui.addChild(_shows);			var _movies = new ButtonMovies(); _ui.addChild(_movies);			var _downloads = new ButtonDownloaded(); _ui.addChild(_downloads);			_movies.x = _shows.x+ _shows.width+10; _downloads.x = _movies.x+ _downloads.width+10;_ui.x = 1024/2-_ui.width/2;_ui.y = 25;			_uiarr = [_shows, _movies, _downloads];			_shows.addEventListener(MouseEvent.MOUSE_DOWN, onTv);			_movies.addEventListener(MouseEvent.MOUSE_DOWN, onMovies);			_downloads.addEventListener(MouseEvent.MOUSE_DOWN, onDownloads);			_content.addEventListener(MouseEvent.MOUSE_DOWN, entity);									}		public function keyPressedDown(e:KeyboardEvent):void {						var key:uint = e.keyCode;			trace("keypress");			switch (key) {			  	case Keyboard.LEFT :		_views[_viewIndex].current.Select([0,-1]);		break;				case Keyboard.RIGHT :		_views[_viewIndex].current.Select([0,1]); 		break;				case Keyboard.UP :			_views[_viewIndex].current.Select([-1,0]); 		break;				case Keyboard.DOWN :		_views[_viewIndex].current.Select([1,0]);		break;				case Keyboard.SPACE: _entity = _views[_viewIndex].current.entity; this.model.destinationEntity = _entity; destination(_entity); break;			}			/*	_entity = e.target.parent.entity*/		/*			if(e.keyCode== 32){ 				this.model.destinationEntity = _entity;				switch(_entity.entityType){					case"Series":					trace("I am a Series");					this.model.episodes = "'"+_entity.parentTitle+"'";					break;					case "Episode":					trace("I am a Episode");					break;					case "Movie":					trace("I am a Movie");									break;				}							}*/		}	 private function destination(_entity:Entity):void{						switch(_entity.entityType){				case"Series":				trace("I am a Series");				this.model.episodes = "'"+_entity.parentTitle+"'";				break;				case "Episode":				trace("I am a Episode");				break;				case "Movie":				trace("I am a Movie");							break;			}	}				public function addView(view:AppView):void{			_views.push(view);			if(_views.length == 1){ _content.addChild(view); _viewIndex = 0; }			} 		private function toggleViews():void{				_content.removeChild(_views[_viewIndex]);				_content.addChild(_views[_viewIndex]);		}		// add touch, mouse, and keyboard controls 		private function entity(e:MouseEvent):void{				_entity = e.target.parent.entity			this.model.destinationEntity = _entity;						switch(_entity.entityType){				case"Series":				trace("I am a Series");				this.model.episodes = "'"+_entity.parentTitle+"'";				break;				case "Episode":				trace("I am a Episode");				break;				case "Movie":				trace("I am a Movie");					toggleViews();					this.model.catalog = ["Featured Movies"];				break;			}			/*if(_entity.entityType =="Series"){ this.model.episodes = "'"+_entity.parentTitle+"'"; }*/					}		private function onTv(e:MouseEvent):void{			toggleViews();			this.model.catalog = [ "Featured Tv", "Top Drama", "Top Watched", "Kids Tv"];		}					private function onMovies(e:MouseEvent):void{			toggleViews();			this.model.catalog = [ "Featured Movies","Premium Movies", "New Releases", "Free Movies"];		}			private function onDownloads(e:MouseEvent):void{			toggleViews();			this.model.catalog = [ "Featured Movies","Premium Movies", "New Releases", "Free Movies"];		}		public function update(e:Event):void {		trace("Update UI")		}			}}