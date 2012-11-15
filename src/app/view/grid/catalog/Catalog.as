﻿////  Grid////  Created by Matthew on 2012-11-03.//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.////package app.view.grid.catalog {	import app.*;	import app.model.*;	import app.view.*;	import app.view.grid.visual_li.*;	import app.control.*;	import flash.utils.Dictionary; 	import fl.controls.Button;	import flash.display.MovieClip;	import flash.geom.ColorTransform;	import flash.events.KeyboardEvent;	import flash.events.MouseEvent	import flash.events.TouchEvent;	import flash.events.Event	import com.greensock.*;	import com.greensock.easing.*;	import com.greensock.plugins.*;	import com.greensock.loading.*;	import com.greensock.events.LoaderEvent;	import com.greensock.loading.display.*;	 public class Catalog extends MovieClip{		protected var model:AppModel		protected var controller:AppControl;		protected var sets:Dictionary;		protected var catalog:Array;		protected var clip:MovieClip;		protected var rowMap:Dictionary;		protected var _entitymap:Dictionary;		protected var _controlMap:Dictionary;			protected var _focus:AppButton;		protected var sy:Number;		protected var rowheight:Number;		protected var sel:Array;		protected var sel_row:MovieClip;		protected var sel_item:MovieClip;		protected var _entity:Entity;				public function Catalog(model:AppModel, controller:AppControl) {			this.model = model	 		this.sets = model.dataSets;			this.catalog = model.catalog;			this.clip = this;			this.controller = controller;			this._focus = null;			this.rowMap = new Dictionary();			this._entitymap = new Dictionary();			this._controlMap = new Dictionary();			model.holder.stage.addEventListener(KeyboardEvent.KEY_DOWN, controller.keyPressedDown);		}		///ABSTRACT METHOD FOR OVERRIDE		public function init():void{};				public function set focusmem(value:AppButton){			this._focus = value;		}		public function get focusmem():AppButton{			return _focus		}		public function Select(arr:Array, absolute:Boolean=false):void {									// Reached end of the catalog			if (catalog[sel[0]+arr[0]]==undefined){ return; }						// Reached end of the row			if (arr[1]!=0 && _controlMap[rowMap[catalog[ sel[0]+arr[0] ]]].length <= sel[1]+arr[1] ){ return; }						sel[0] = sel[0]+arr[0];			sel[1] = sel[1]+arr[1];						if (absolute){	sel = arr;	}						//  Negative detected, set to 0			if (sel[0]<0) { sel[0] = 0; }			if (sel[1]<0) { sel[1] = 0; }												// Row change						if (arr[0]!=0){ 				if (!absolute){										// Select closest x item in new row										var xmatch:Number = sel_row.x + sel_item.x;					var tmp = _controlMap[rowMap[catalog[sel[0]]]];					var tmparr:Array = [0,100000];										for (var i:int = 0; i<tmp.length; i++){						var item = tmp[i];						var diff:Number = Math.abs(xmatch - (item.parent.x + item.x) );												if (Math.min(tmparr[1],diff)==diff){							trace("setting: "+ i);							tmparr = [i, diff];						}											}										sel[1] = tmparr[0];									}								TweenLite.to(this, 1, {y:this.sy - (rowheight*sel[0]), ease:Expo.easeOut});			}									// Selected row, Selected item objects						trace("sel: " + sel)						Desel();						sel_row = rowMap[catalog[sel[0]]];			sel_item = _controlMap[sel_row][ sel[1] ];							Sel();									// Scroll row after 600 position, reverse direction when < 100						var offset:Number = 0;						if (sel_item.x+sel_row.x > 600){				offset = 250*(sel[1]-2);				TweenLite.to(sel_row, 1, {x:sel_row.sx - offset, ease:Expo.easeOut});			}						if (sel_item.x+sel_row.x < 100){ 				offset = 250*sel[1];				TweenLite.to(sel_row, 1, {x:sel_row.sx - offset, ease:Expo.easeOut});			}										}								public function Sel():void {						// visualize selection			this._entity = entitymap[sel_item]			TweenLite.to(sel_item, 0.8, {scaleX:1.1, scaleY:1.1, ease:Expo.easeOut});		}				public function Desel():void {						// visualize deselection			TweenLite.to(sel_item, 0.6, {scaleX:1, scaleY:1, ease:Expo.easeOut});					}				public function get controlMap():Dictionary{			return _controlMap;		}		public function get entitymap():Dictionary{			return _entitymap		}		public function get entity():Entity{			return _entity;		}	}};