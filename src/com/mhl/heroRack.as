//
//  heroRack
//
//  Created by Matthew on 2012-10-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//
package com.mhl{
	import flash.display.MovieClip;	
	import flash.display.Sprite;
	import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;	
	import flash.events.GestureEvent;
	import flash.events.PressAndTapGestureEvent;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.geom.*;
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	import com.greensock.loading.*;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.display.*;
	
	 public class heroRack extends MovieClip{
		private var _heroRack:MovieClip; 
		private var _holder:MovieClip
		private var _library:MovieClip
		
		public function heroRack(holder:MovieClip, library:MovieClip) {
		
		this._holder = holder;	
		this._library = library
		this._heroRack = new MovieClip();
		addChild(_heroRack);
		
		
		
		//Create Posters 	
		var i:uint;
		var xpos = 0;
		for(i=0; i< 7; i++){
		 var _poster = new 	PosterFPO();
		_poster.name = "_poster"+i;
		_poster.scaleY = 1.15;
		_poster.scaleX = 1.15;
		
		_heroRack.addChild(_poster);
		_poster.x = xpos;
		xpos = xpos + _poster.width + 10;
			
		}

		
		_heroRack.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
		
		var touchMoveID:int = 0; 
		
		function onTouchBegin(event:TouchEvent) { 
	
				
			if(touchMoveID != 0) { 
		        trace ("already moving. ignoring new touch");     
		        return; 
		    }
		 touchMoveID = event.touchPointID; 
		 _holder.stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove); 
		 _holder.stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);

/*		mc.dragging = true;
		mc.mouse = mouseY;
		mc.dy = mc.y;
		mc.velocity = 0;*/
		_heroRack._rightBound = 1024 -_heroRack.width ;
		_heroRack._leftBound = 8;
		_heroRack._inMotion = true;
		_heroRack._finger_x = event.stageX
		_heroRack._destination_x = _heroRack.x;
		_heroRack._velocity = 0;


		} 
		function onTouchMove(event:TouchEvent) { 
			var omc = null;
		    if(event.touchPointID != touchMoveID) { 
		       trace("ignoring unrelated touch"); 
		        return; 
		    } 
					if(_library.inMotion == true){

 							return;
					}
			if (_heroRack._inMotion){
			_heroRack._destination_x += (event.stageX-_heroRack._finger_x);
			_heroRack._finger_x = event.stageX;
			_heroRack.speed = 1.5;

			} else {
				_heroRack.speed = 6;

			}

			_heroRack.velocity = (_heroRack.y-_heroRack._destination_x);
			_heroRack.x -= (_heroRack.x-_heroRack._destination_x) / _heroRack.speed;

			// stop horizontal scroll if vertical velocity is high

			if (_heroRack.velocity>4 && omc!=null){ 
				_heroRack._inMotion=false;
			}





		} 
		function onTouchEnd(event:TouchEvent) { 
			if(event.touchPointID != touchMoveID) { 
		        trace("ignoring unrelated touch end"); 
		        return; 
		    } 

			_heroRack._inMotion = false;
			_heroRack._destination_x -= _heroRack.velocity*10;

					if (_heroRack.x > _heroRack._leftBound){ 
						TweenLite.to(_heroRack, .5, { x:_heroRack._leftBound, ease:Expo.easeOut});
					}

				if (_heroRack.x < _heroRack._rightBound){ 
					TweenLite.to(_heroRack, .5, { x:_heroRack._rightBound, ease:Expo.easeOut});
				}



		    touchMoveID = 0; 
		    _holder.stage.removeEventListener(TouchEvent.TOUCH_MOVE, onTouchMove); 
		   _holder.stage.removeEventListener(TouchEvent.TOUCH_END, onTouchEnd);
		   trace("touch end" + event.touchPointID); 
		}

		
		}
		// Do my thing

	}

};

