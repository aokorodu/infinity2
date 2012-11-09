//
//  Grid
//
//  Created by Matthew on 2012-11-03.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//
package app.view.single {
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
	 public class Single extends MovieClip{
		protected var sets:Dictionary;
		protected var rowMap:Dictionary;
		protected var clip:MovieClip;
		protected var destinationEntity:Entity
		
		public function Single(sets:Dictionary, destinationEntity:Entity) {
	 		this.sets = sets;
			this.clip = this;
			this.destinationEntity = destinationEntity;
			rowMap = new Dictionary();
		}
		///ABSTRACT METHOD FOR OVERRIDE
		public function init():void{};

	}

};