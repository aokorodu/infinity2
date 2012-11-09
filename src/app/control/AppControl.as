﻿package app.control{	import app.*;	import app.model.*;	import app.view.*;	import app.control.*;	import fl.controls.Button;	import flash.display.MovieClip;	import flash.events.Event	import flash.events.MouseEvent;	import flash.events.GestureEvent;	import flash.events.PressAndTapGestureEvent;	import flash.events.TouchEvent;	import flash.ui.Multitouch;	import flash.ui.MultitouchInputMode;		public class AppControl extends MovieClip{		private var model:AppModel;		private var _viewIndex:int;		private var _views:Array;		private var _ui:MovieClip;		private var _content:MovieClip;		Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;		public function AppControl(model:AppModel) {			this.model = model;			this._views = new Array();			this._content = new MovieClip();			addChild(_content);						var _grid:AppView = new Grid(model, this, this._content);			addView(_grid);						// fake user request for 'downloads' would be object listening for user input 			_ui = new MovieClip(); addChild(_ui);			var _shows= new ButtonTv(); _ui.addChild(_shows);			var _movies= new ButtonMovies(); _ui.addChild(_movies);			_movies.x = _shows.x+ _shows.width+20; _ui.x = 1024/2-_ui.width/2;_ui.y = 25;						_shows.addEventListener(MouseEvent.MOUSE_DOWN, onTv);			_movies.addEventListener(MouseEvent.MOUSE_DOWN, onMovies);			_content.addEventListener(MouseEvent.MOUSE_DOWN, entity);			}				public function addView(view:AppView):void{			_views.push(view);			if(_views.length == 1){ _content.addChild(view); _viewIndex = 0; }			} 		private function toggleViews():void{								_content.removeChild(_views[_viewIndex]);			/*			while (_views[_viewIndex].numChildren > 0) {			    _views[_viewIndex].removeChildAt(0);			}*/			_content.addChild(_views[_viewIndex]);		}		// add touch, mouse, and keyboard controls 		private function entity(e:MouseEvent):void{			var _entity:Entity;			if(_views[_viewIndex].viewState){				_entity	 = _views[_viewIndex].catalog.entitymap[e.target] }else{_entity = _views[_viewIndex].single.entitymap[e.target]}			this.model.destinationEntity = _entity;			switch(_entity.entityType){				case"Series":				trace("I am a Series");				this.model.episodes = "'"+_entity.parentTitle+"'";				break;				case "Episode":				trace("I am a Episode");				break;				case "Movie":				trace("I am a Movie");				break;			}			/*if(_entity.entityType =="Series"){ this.model.episodes = "'"+_entity.parentTitle+"'"; }*/					}		private function onTv(e:MouseEvent):void{			toggleViews();			this.model.catalog = [ "Featured Tv", "Top Drama", "Top Watched", "Kids Tv"];		}					private function onMovies(e:MouseEvent):void{			toggleViews();			this.model.catalog = [ "Featured Movies","Premium Movies", "New Releases", "Free Movies"];		}			public function update(e:Event):void {		trace("Update UI")		}			}}