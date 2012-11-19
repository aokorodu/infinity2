﻿package app.view {	import flash.display.MovieClip;	import app.model.*;	import app.view.*;	import app.view.grid.catalog.Catalog;	import app.control.*;		import flash.utils.Dictionary; 	import flash.events.Event	import com.greensock.*;	import com.greensock.easing.*;	import com.greensock.plugins.*;	import com.greensock.loading.*;	import com.greensock.events.LoaderEvent;	import com.greensock.loading.display.*;		public class AppView extends MovieClip{		protected var model:AppModel;		protected var controller:AppControl;		protected var holder:MovieClip;		protected var _catalog:Object;		protected var _single:Object;		protected var _map:Dictionary;		// ABSTRACT Class (should be subclassed and not instantiated)		public function AppView(model:AppModel, controller:AppControl, holder:MovieClip) {			this.model = model;			this.controller = controller;			this.holder = holder;			this._map = new Dictionary(true);			this._catalog = new Object();			this._single = new Object();			model.addEventListener(AppModel.UPDATE, update);		}				// ABSTRACT Method (must be overridden in a subclass)		public function update(event:Event):void {}				public function nudge():void{						var nudge = this.model.drawerIsOpen;				if(nudge){					TweenLite.to(this, .8, {x:300, ease:Expo.easeOut});				}else{ TweenLite.to(this, .6, {x:0, ease:Expo.easeOut}); }		}			}}