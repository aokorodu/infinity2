﻿////  Grid////  Created by Matthew on 2012-11-03.//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.////package app.view.grid.single {	import app.*;	import app.model.*;	import app.view.*;	import app.view.grid.catalog.*;	import app.view.grid.visual_li.*;	import app.view.grid.destination.*;	import app.control.*;	import flash.utils.Dictionary; 	import fl.controls.Button;	import flash.display.MovieClip;	import flash.geom.ColorTransform;	import flash.events.MouseEvent	import flash.events.TouchEvent;	import flash.events.Event	import flash.events.FocusEvent;	import flash.events.KeyboardEvent;	import flash.ui.Keyboard;	import flash.ui.Keyboard;	import com.greensock.*;	import com.greensock.easing.*;	import com.greensock.plugins.*;	import com.greensock.loading.*;	import com.greensock.events.LoaderEvent;	import com.greensock.loading.display.*;	 public class Tv extends Single{		private var _entitymap:Dictionary;		private var _controlMap:Dictionary;				public var sy:Number;		public var rowheight:Number;		public var sel:Array;		public var sel_row:MovieClip;		public var sel_item:MovieClip;		private var single_catalog:Array;				public function Tv(model:AppModel, controller:AppControl, destinationEntity:Entity  ) {			super(model, controller, destinationEntity);			this._entitymap = new Dictionary();				this._controlMap = new Dictionary();			init();		}			override public function init():void {								this.rowheight = 300;								var destination:Destination = new FullView( model, controller, destinationEntity );				addChild(destination)				_entitymap[destination] = destinationEntity;				destination.y = 100				var _episodes = new MovieClip()				addChild(_episodes)				single_catalog = new Array();				var xpos = 1024/2				var ypos = 600;				var row_ypos = 0;				for(var row:* in episodeSets ){					var _entityrow:MovieClip = new MovieClip(); 					_entityrow.sx = 0;					_entityrow.y = row_ypos					row_ypos = row_ypos+rowheight;					_entityrow.name = row					_episodes.addChild(_entityrow);					rowMap[row] = _entityrow					_controlMap[rowMap[row]] = new Array();					single_catalog.push(row);					var btn_xpos = 0					for each (var entity:* in episodeSets[row] ){						var button:Visual_li = new Native_li(model, controller, entity);						button.x =	btn_xpos						btn_xpos = btn_xpos+button.width+30						button.name = entity.TITLE						rowMap[row].addChild(button);						_entitymap[button] = entity;						_controlMap[rowMap[row]].push(button);					}				}				destination.x = xpos/clip.width/2 +35				_episodes.x = xpos/clip.width/2 +35				_episodes.y = ypos								this.sy = this.y;				// initialize selection 				this.sel = [0,0];				this.sel_row = rowMap[single_catalog[0]];				this.sel_item = _controlMap[rowMap[single_catalog[0]]][0];				Select([0,0]);				model.holder.stage.addEventListener(KeyboardEvent.KEY_DOWN, controller.keyPressedDown);		}				public function Select(arr:Array, absolute:Boolean=false):void {						trace("Keyboard")			// Reached end of the catalog			if (single_catalog[sel[0]+arr[0]]==undefined){ return; }						// Reached end of the row			if (arr[1]!=0 && _controlMap[rowMap[single_catalog[ sel[0]+arr[0] ]]].length <= sel[1]+arr[1] ){ return; }						sel[0] = sel[0]+arr[0];			sel[1] = sel[1]+arr[1];						if (absolute){	sel = arr;	}						//  Negative detected, set to 0			if (sel[0]<0) { sel[0] = 0; }			if (sel[1]<0) { sel[1] = 0; }												// Row change						if (arr[0]!=0){ 				if (!absolute){										// Select closest x item in new row										var xmatch:Number = sel_row.x + sel_item.x;					var tmp = _controlMap[rowMap[single_catalog[sel[0]]]];					var tmparr:Array = [0,100000];										for (var i:int = 0; i<tmp.length; i++){						var item = tmp[i];						var diff:Number = Math.abs(xmatch - (item.parent.x + item.x) );												if (Math.min(tmparr[1],diff)==diff){							trace("setting: "+ i);							tmparr = [i, diff];						}											}										sel[1] = tmparr[0];									}								TweenLite.to(this, 1, {y:this.sy - (rowheight*sel[0]), ease:Expo.easeOut});			}									// Selected row, Selected item objects						trace("sel: " + sel)						Desel();						sel_row = rowMap[single_catalog[sel[0]]];			sel_item = _controlMap[sel_row][ sel[1] ];							Sel();			trace("Control Map: " + _controlMap[sel_row][ sel[1]])									// Scroll row after 600 position, reverse direction when < 100						var offset:Number = 0;						if (sel_item.x+sel_row.x > 600){							offset = 250*(sel[1]-2);				TweenLite.to(sel_row, 1, {x:sel_row.sx - offset, ease:Expo.easeOut});					}						if (sel_item.x+sel_row.x < 100){ 				offset = 250*sel[1];				TweenLite.to(sel_row, 1, {x:sel_row.sx - offset, ease:Expo.easeOut});			}										}				public function Sel():void {						// visualize selection			TweenLite.to(sel_item, 0.8, {scaleX:1.1, scaleY:1.1, ease:Expo.easeOut});		}				public function Desel():void {						// visualize deselection			TweenLite.to(sel_item, 0.6, {scaleX:1, scaleY:1, ease:Expo.easeOut});					}				public function get controlMap():Dictionary{			return _controlMap;		}		public function get entitymap():Dictionary{			return _entitymap		}	}};