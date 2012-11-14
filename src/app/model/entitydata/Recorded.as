//
//  Featured Movies
//
//  Created by Matthew on 2012-11-04.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//
package app.model.entitydata {
	import com.mhl.*;
	import app.model.*;	
	import com.mhl.libs.recentActivity;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.Dictionary; 
	import fl.data.DataProvider;
	import flash.data.SQLResult;
	import flash.data.SQLConnection;
	import flash.filesystem.File;
	import flash.data.SQLStatement;
	import flash.data.SQLConnection;
	import flash.events.*;
	import flash.events.EventDispatcher;
	import flash.events.Event
	 public class Recorded extends EntityData{
		public function Recorded(model:AppModel) {
		 super(model);
		init();
		}
		override public function init():void{
			var query:String = "SELECT parentTitle, entityType, title, p, description FROM movies WHERE recorded='true' ";
			this.title = "Recordings";	
			this.getData(query, Entity, 6);			
		}
		
		override public function createMap():void {
			pageCount++
			for(var movie:* in result.data) {
				this._entitymap.push(result.data[movie]);
			}
			this.model.addData(this);

		};

	}

};
