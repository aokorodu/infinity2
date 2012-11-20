﻿////  Grid////  Created by Matthew on 2012-11-03.//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.////package app.view.grid.catalog {	import app.*;	import app.model.*;	import app.view.*;	import app.view.grid.visual_li.*;	import app.control.*;	import flash.utils.Dictionary; 	import fl.controls.Button;	import flash.display.MovieClip;	import flash.geom.ColorTransform;	import flash.events.KeyboardEvent;	import flash.events.MouseEvent	import flash.events.TouchEvent;	import flash.events.Event;	import flash.utils.Timer;	import flash.utils.getTimer;	import flash.events.TimerEvent;	import com.greensock.*;	import com.greensock.easing.*;	import com.greensock.plugins.*;	import com.greensock.loading.*;	import com.greensock.events.LoaderEvent;	import com.greensock.loading.display.*;	 public class Catalog extends MovieClip{		protected var model:AppModel		protected var controller:AppControl;		protected var sets:Dictionary;		protected var catalog:Array;		protected var clip:MovieClip;		protected var rowMap:Dictionary;		protected var _entitymap:Dictionary;		protected var _controlMap:Dictionary;			protected var _focus:AppButton;		protected var sy:Number;		protected var rowheight:Number;		protected var sel:Array;		protected var _sel_row:MovieClip = null;		protected var _sel_item:MovieClip = null;		protected var _entity:Entity;		protected var timer:Timer;		protected var timelock:Boolean = false;		protected var dragging:Boolean;		protected var touchx:Number;		protected var touchy:Number;		protected var velocity:Number;		protected var dy:Number;		protected var destinationEntity:Entity		protected var episodeSets:Dictionary;		protected var movieSets:Dictionary;		protected var single_catalog:Array;				protected var selfirst:Boolean = true;						public function Catalog(model:AppModel, controller:AppControl, destinationEntity:Entity) {			this.model = model	 		this.sets = model.dataSets;	 		this.episodeSets = this.model.episodeSets;			this.movieSets = this.model.dataSets;			this.catalog = model.catalog;			this.clip = this;			this.controller = controller;			this._focus = null;			this.rowMap = new Dictionary();			this._entitymap = new Dictionary();			this._controlMap = new Dictionary();			this.destinationEntity = destinationEntity;			this.rowheight = 503;			model.holder.stage.addEventListener(KeyboardEvent.KEY_DOWN, controller.keyPressedDown);		}		///ABSTRACT METHOD FOR OVERRIDE		public function init():void{};				public function set focusmem(value:AppButton){			this._focus = value;		}		public function get focusmem():AppButton{			return _focus		}		public function Select(arr:Array, absolute:Boolean=false):void {			if (_sel_item!=null && _sel_item.actionbar!=null && _sel_item.actionbar.focused){								if (arr[0]==0){					// horizontal					_sel_item.actionbar.ActionSelect(arr[1], absolute);				} else {					// vertical					DeselActions();				}								return;			}						// Reached end of the catalog			if (catalog[sel[0]+arr[0]]==undefined){ return; }						// Reached end of the row			if (arr[1]!=0 && _controlMap[rowMap[catalog[ sel[0]+arr[0] ]]].length <= sel[1]+arr[1] ){ return; }						sel[0] = sel[0]+arr[0];			sel[1] = sel[1]+arr[1];						if (absolute){	sel = arr;	}						//  Negative detected, set to 0			if (sel[0]<0) { sel[0] = 0; }			if (sel[1]<0) { sel[1] = 0; }												// Row change						if (arr[0]!=0){ 				if (!absolute){										// Select closest x item in new row										var xmatch:Number = 0;					if (_sel_item!=null){	xmatch = _sel_row.x + _sel_item.x;	}										var tmp = _controlMap[rowMap[catalog[sel[0]]]];					var tmparr:Array = [0,100000];										for (var i:int = 0; i<tmp.length; i++){						var item = tmp[i];						var diff:Number = Math.abs(xmatch - (item.parent.x + item.x) );												if (Math.min(tmparr[1],diff)==diff){							trace("setting: "+ i);							tmparr = [i, diff];						}											}										sel[1] = tmparr[0];									}								TweenLite.to(this, 1, {y:this.sy - (rowheight*sel[0]), ease:Expo.easeOut});			}									// Selected row, Selected item objects						trace("sel: " + sel)						if (sel_item!=null){				Desel();			}						_sel_row = rowMap[catalog[sel[0]]];			_sel_item = _controlMap[_sel_row][ sel[1] ];							Sel();								// Scroll row after 600 position, reverse direction when < 100						var offset:Number = 0;						if (_sel_item.x+_sel_row.x > 500){				offset = 191*(sel[1]-2);				TweenLite.to(_sel_row, 1, {x:_sel_row.sx - offset, ease:Expo.easeOut});			}						if (_sel_item.x+_sel_row.x < 100){ 				offset = 191*sel[1];				TweenLite.to(_sel_row, 1, {x:_sel_row.sx - offset, ease:Expo.easeOut});			}										}								public function Sel():void {						// visualize selection			this._entity = entitymap[_sel_item]			//TweenLite.to(_sel_item, 0.8, {scaleX:1.1, scaleY:1.1, ease:Expo.easeOut});						_sel_item.Highlight(true);					}				public function Desel():void {						// visualize deselection			//TweenLite.to(_sel_item, 0.6, {scaleX:1, scaleY:1, ease:Expo.easeOut});						_sel_item.Highlight(false);					}								public function SelActions():void {			_sel_item.Actions(true);						// loop through rows and push them down						//for (var i:int=sel[0]+1; i<catalog.length; i++){			for (var i:int=0; i<catalog.length; i++){				var row:MovieClip = rowMap[catalog[i]];								var ty:Number = 0;				if (i>= sel[0]+1){ ty = 84; }								TweenLite.to(row, 0.8, {y:row.sy+ty, ease:Expo.easeOut});				TweenLite.to(row.title, 0.8, {y:row.title.sy+ty, ease:Expo.easeOut});			}								}				public function DeselActions():void {			_sel_item.Actions(false);						for (var i:int=0; i<catalog.length; i++){				var row:MovieClip = rowMap[catalog[i]];								TweenLite.to(row, 0.8, {y:row.sy, ease:Expo.easeOut});				TweenLite.to(row.title, 0.8, {y:row.title.sy, ease:Expo.easeOut});							}					}												public function TouchSelect(e:TouchEvent){			if (timelock){ return; }						var item = e.target.parent;						if (item is Native_li){								var row = item.parent;				_sel_row = row;								if (_sel_item!=null){					Desel();					DeselActions();				}								_sel_item = item;								Sel();				SelActions();							}		}						public function TouchBegin(e:TouchEvent){			//trace("begin, " + e.stageX, e.stageY);						TweenLite.killTweensOf(_sel_row);			TweenLite.killTweensOf(this);						touchx = e.stageX;			touchy = e.stageY;						dragging = true;			velocity = 0;			this.dy = this.y;						_sel_row.dragging = true;			_sel_row.velocity = 0;			_sel_row.dx = _sel_row.x;												var item = e.target.parent;			if (item is Native_li){				var row = item.parent;				_sel_row = row;			}					}				public function TouchMove(e:TouchEvent){			var speed:Number;									if (dragging){				dy += (e.stageY-touchy);				touchy = e.stageY;				speed = 1.5;				velocity = (this.y-this.dy);				this.y -= (this.y-this.dy) / speed;				if (this.dy > this.sy){ 	this.dy = this.sy; 	}				if (this.dy < -(this.height-700) ){  this.dy = -(this.height-700); }			}			if (_sel_row.dragging){									_sel_row.dx += (e.stageX-touchx);				touchx = e.stageX;				speed = 1.5;							_sel_row.velocity = (_sel_row.x-_sel_row.dx);				_sel_row.x -= (_sel_row.x-_sel_row.dx) / speed;							if (_sel_row.dx > _sel_row.sx){ 	_sel_row.dx = _sel_row.sx; 	}				if (_sel_row.dx < -(_sel_row.width-1000) ){  _sel_row.dx = -(_sel_row.width-1000); }			}					if (dragging && _sel_row.dragging){				if (Math.abs(velocity) > Math.abs(_sel_row.velocity) ){ 					_sel_row.dragging = false;				} else { 					dragging = false; 					DeselActions();					Desel();				}			}				timer.reset();			timer.start();			timelock = true;					}				public function TouchEnd(e:TouchEvent){								if (dragging){				dragging = false;				this.dy -= velocity*10;						if (this.dy > this.sy){ 	this.dy = this.sy; 	}				if (this.dy < -(this.height-700) ){  this.dy = -(this.height-700); }							TweenLite.to(this, 1.4, {y:this.dy, ease:Expo.easeOut});			}			if (_sel_row.dragging){ 				_sel_row.dragging = false;				_sel_row.dx -= _sel_row.velocity*10;							if (_sel_row.dx > _sel_row.sx){ 	_sel_row.dx = _sel_row.sx; 	}				if (_sel_row.dx < -(_sel_row.width-1000) ){  _sel_row.dx = -(_sel_row.width-1000); }							TweenLite.to(_sel_row, 1.4, {x:_sel_row.dx, ease:Expo.easeOut});			}		}								public function TouchTimer(event:TimerEvent):void {			timelock = false;		}				public function set sel_row(value:MovieClip):void{		 this._sel_row = value;		}				public function get sel_row():MovieClip{			return _sel_row		}				public function set sel_item(value:MovieClip):void{		 this._sel_item = value;		}				public function get sel_item():MovieClip{			return _sel_item		}				public function get controlMap():Dictionary{			return _controlMap;		}		public function get entitymap():Dictionary{			return _entitymap		}		public function get entity():Entity{			return _entity;		}	}};