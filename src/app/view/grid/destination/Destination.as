//
//  Destination
//
//  Created by Matthew on 2012-11-03.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//
package app.view.grid.destination {
	import app.*;
	import app.model.*;
	import app.view.*;
	import app.control.*;
	import flash.utils.Dictionary; 
	import fl.controls.Button;
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	import flash.events.MouseEvent
	import flash.events.TouchEvent;
	import flash.events.Event
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	import com.greensock.loading.*;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.display.*;
	 public class Destination extends MovieClip{
		protected var model:AppModel
		protected var controller:AppControl;
		protected var data:Entity;
		protected var _canvas:AppButton;
		public function Destination(model:AppModel, controller:AppControl, data:Entity ) {
			this.model = model
			this.controller = controller;
			this.data = data;

		}
		///ABSTRACT METHOD FOR OVERRIDE
		public function init():void{};
		public function get entity():Entity{
			return data
		}
		public function get canvas():AppButton{
			return _canvas;
		}
};
}