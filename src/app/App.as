﻿package app {	import app.model.*;	import app.model.entitydata.*;		import app.view.*;	import app.control.*;	import flash.display.MovieClip;	import flash.display.StageScaleMode;	import flash.display.StageAlign;	public class App extends MovieClip{		private var app_model:AppModel;		private var app_controller:AppControl;		public function App() {			//app defaults			this.stage.scaleMode= StageScaleMode.NO_SCALE;			this.stage.align = StageAlign.TOP_LEFT;						// Data			app_model = new AppModel();						// Catalog Queries			var _featuredMovies:EntityData = new FeaturedMovies(app_model);			var _newReleases:EntityData = new NewReleases(app_model);			var _premiumMovies:EntityData = new PremiumMovies(app_model);			var _freeMovies:EntityData = new FreeMovies(app_model);						var _featuredTv:EntityData = new FeaturedTv(app_model);			var _topWatched:EntityData = new TopWatched(app_model);			var _topDrama:EntityData = new TopDrama(app_model);			var _kidsTv:EntityData = new KidsTv(app_model);											// Controller			app_controller = new AppControl(app_model); 			addChild(app_controller);					}	}}