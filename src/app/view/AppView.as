﻿package app.view {	import flash.display.MovieClip;	import app.model.*;	import app.view.*;	import app.view.catalog.Catalog;	import app.view.single.Single;	import app.control.*;	import flash.events.Event		public class AppView extends MovieClip{		protected var model:AppModel;		protected var controller:AppControl;		protected var holder:MovieClip;		protected var _catalog:Catalog;		protected var _single:Single;		// ABSTRACT Class (should be subclassed and not instantiated)		public function AppView(model:AppModel, controller:AppControl, holder:MovieClip) {			this.model = model;			this.controller = controller;			this.holder = holder;											model.addEventListener(AppModel.UPDATE, update);		}				// ABSTRACT Method (must be overridden in a subclass)		public function update(event:Event):void {}					}}