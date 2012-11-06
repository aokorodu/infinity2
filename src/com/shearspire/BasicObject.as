package com.shearspire {
	import caurina.transitions.*;
	import caurina.transitions.properties.ColorShortcuts;
	import caurina.transitions.properties.FilterShortcuts;
	
	import flash.display.*;
	import flash.errors.*;
	import flash.events.*;
	import flash.net.*;
	import flash.text.*;
	import flash.ui.Keyboard;
	import flash.utils.*;

	public class BasicObject extends MovieClip {
		public var adopted:Boolean = false;
		public var theParent:MovieClip;
		public var ready:Boolean = false;
		public var defaultEasing:String = "easeOutExpo";
		public var timerID:int=0;
		
		public function BasicObject() {
			theParent = this.parent as MovieClip;
		}
		public function isReady():Boolean{
			return ready;
		}
		public function setParent(p:Object):void{
			theParent = p as MovieClip;
			adopted = true;
		}
		public function isShowing():Boolean{
			return this.visible;
		}
		public function go2(e:MouseEvent):void{
			e.target.gotoAndStop(2);
		}
		public function go1(e:MouseEvent):void{
			e.target.gotoAndStop(1);
		}
	}
}