﻿////  Grid////  Created by Matthew on 2012-11-03.//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.////package app.view.grid.catalog {	import app.*;	import app.model.*;	import app.view.*;	import app.view.grid.catalog.*;	import app.control.*;	import flash.utils.Dictionary; 	import fl.controls.Button;	import flash.display.MovieClip;	import flash.geom.ColorTransform;	import flash.events.MouseEvent	import flash.events.TouchEvent;	import flash.events.Event	import flash.events.FocusEvent;	import flash.events.KeyboardEvent;	import com.greensock.*;	import com.greensock.easing.*;	import com.greensock.plugins.*;	import com.greensock.loading.*;	import com.greensock.events.LoaderEvent;	import com.greensock.loading.display.*;	import flash.geom.Point;	 public class Browse extends Catalog{		private var _entitymap:Dictionary;		private var _controlMap:Dictionary		private var _currentpoint:int		public function Browse(model:AppModel, controller:AppControl) {			super(model, controller);			this._entitymap = new Dictionary();			this._controlMap = new Dictionary();			this._currentpoint = 0;			init();		}				override public function init():void {					var xpos = 1024/2					var ypos = 100;					var row_ypos = 0;					var count = 0					for each (var cat:String in catalog){						count++						var _entityrow:MovieClip = new MovieClip(); 						_entityrow.y = row_ypos						row_ypos = row_ypos+300						_entityrow.name = cat						_entityrow.id = "row"+count						_entityrow.state = false						addChild(_entityrow)						rowMap[cat] = _entityrow						_controlMap[rowMap[cat]] = new Array();						var rowPoint:Point = new Point(_entityrow.x, _entityrow.y);					}					for ( var row:* in rowMap){						var btn_xpos = 0						for each (var entity:* in sets[row]){							var button:AppButton = new AppButton(entity.title, 220, 280, controller );							button.x =	btn_xpos							btn_xpos = btn_xpos+button.width+30							button.name = entity.parentTitle							rowMap[row].addChild(button);							_entitymap[button] = entity; 							_controlMap[rowMap[row]].push(button);							button.addEventListener(FocusEvent.FOCUS_OUT, controller.notinfocus);							button.addEventListener(FocusEvent.FOCUS_IN, controller.infocus);							button.addEventListener(FocusEvent.KEY_FOCUS_CHANGE, controller.changefocus);							button.addEventListener(KeyboardEvent.KEY_DOWN, controller.selectfocus);						}											}										this.x = xpos/clip.width/2 +35					this.y = ypos				/*	this.focusmem = this.rowMap[catalog[0]].button*/				var select = catalog[0]				var selectFocus = _controlMap[rowMap[select]][0]				this.focusmem = selectFocus;				/*	trace(this._controlMap[select][0].button)*/		}		public function get controlMap():Dictionary{			return _controlMap;		}		public function get currentpoint():int{			return _currentpoint;		}		public function set currentpoint(value:int){			this._currentpoint = value;		}		public function get entitymap():Dictionary{			return _entitymap		}	}};