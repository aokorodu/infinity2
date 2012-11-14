﻿////  Grid////  Created by Matthew on 2012-11-03.//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.////package app.view {	import app.*;	import app.model.*;	import app.view.*;	import app.view.grid.catalog.*;		import app.view.grid.single.*;		import app.control.*;	import flash.utils.Dictionary; 	import fl.controls.Button;	import flash.display.MovieClip;	import flash.geom.ColorTransform;	import flash.events.MouseEvent	import flash.events.TouchEvent;	import flash.events.Event	import com.greensock.*;	import com.greensock.easing.*;	import com.greensock.plugins.*;	import com.greensock.loading.*;	import com.greensock.events.LoaderEvent;	import com.greensock.loading.display.*;	 public class Grid extends AppView{		private var _viewState:Boolean;		public function Grid(model:AppModel, controller:AppControl, holder:MovieClip) {		super(model, controller, holder);				}		override public function update(e:Event):void {			var sets = this.model.dataSets;			var episodes = this.model.episodeSets			var catArray = this.model.catalog;			var destinationEntity = this.model.destinationEntity;						//clear view			while (this.numChildren > 0) {			    this.removeChildAt(0);			}			// Set View State 'catalog' or single'  			if(catArray.length == 1 ){				switch(catArray[0]){ case "Featured Movies": _single = new Movie(model, controller, destinationEntity); break;				case "Get Episodes":_single = new Tv(model, controller, destinationEntity); break;}				addChild(_single);				_current = _single				_viewState = false;			}else{				_catalog = new Browse(model, controller);				addChild(_catalog)				_current = _catalog;				_viewState = true;			}					}						// get public acess to clips'		public function get current():MovieClip{			return _current;		}		public function get catalog():Catalog{			return _catalog;		}		public function get single():Single{			return _single;		}		// get view state 		public function get viewState():Boolean{			return _viewState;		}	}};