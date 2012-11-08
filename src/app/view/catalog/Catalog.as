//
//  Grid
//
//  Created by Matthew on 2012-11-03.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//
package app.view.catalog {
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
	 public class Catalog extends MovieClip{
		protected var sets:Dictionary;
		protected var catalog:Array;
		protected var clip:MovieClip;
		protected var rowMap:Dictionary;
		public function Catalog(sets:Dictionary, catalog:Array, clip:MovieClip) {
	 		this.sets = sets;
			this.catalog = catalog;
			this.clip = clip;
			rowMap = new Dictionary();
		}
		///ABSTRACT METHOD FOR OVERRIDE
		public function init():void{};

	}

};