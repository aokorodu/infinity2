﻿package mobile.controller{	import mobile.*;	import mobile.model.*;	import mobile.view.*;	import mobile.controller.*;	import flash.events.MouseEvent;	import flash.events.GestureEvent;	import flash.events.PressAndTapGestureEvent;	import flash.events.TouchEvent;	import flash.ui.Multitouch;	import flash.ui.MultitouchInputMode;		public class mobileController {		var model:mobileModel;		Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;		public function mobileController(model:mobileModel) {			this.model = model;		}				public function tapOpenSection(e:TouchEvent):void {			var section = e.target.name			this.model.openSection = section;			this.model.drawerIsOpen = false;		}				public function tapClose(e:TouchEvent):void {			this.model.closeOnOff = !this.model.closeOnOff;			this.model.transportIsVisible = false;					}				public function tapSubSection(e:TouchEvent):void {				 var subSection = e.target.name				switch(e.target.name){					case "_recentActivity":					this.model.openSubSection = subSection;						break;					case "_recordings":					this.model.openSubSection = subSection;						break;					case "_downloads":					this.model.openSubSection = subSection;						break;					case "_fullisting":					this.model.openSubSection = subSection;						break;								}						}				public function tapOpenClose(e:TouchEvent):void {			trace(e.target.name)			switch(e.target.name){				case "txt":				this.model.drawerIsOpen = !this.model.drawerIsOpen;				break;				case "_icon":				this.model.drawerIsOpen = !this.model.drawerIsOpen;				break;				case "_collapse":				this.model.drawerIsOpen = !this.model.drawerIsOpen;				break;				case "_collapseOn":				this.model.drawerIsOpen = !this.model.drawerIsOpen;				break;				case "_backdrop":				this.model.drawerIsOpen = !this.model.drawerIsOpen;				break							}					}		public function tapNavOnOff(e:TouchEvent):void {			this.model.transportIsVisible = !this.model.transportIsVisible;			}				public function tapPlayPause(e:TouchEvent):void {			this.model.videoIsPlaying = !this.model.videoIsPlaying;			}						}}