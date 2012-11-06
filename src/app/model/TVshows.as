//
//  TV Shows
//
//  Created by Matthew on 2012-11-04.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//
package app.model {
	import com.mhl.*;
	import app.model.Entity
	import app.model.AppModel;
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
	 public class TVshows extends EntityData{
		public function TVshows(model:AppModel, name:String) {
		 super(model, name);
		}
		override public function init():void{
			querynum = 4;
			var Featured:String = "SELECT parentTitle, entityType, title, p, description  FROM tv WHERE newforRelevance='true' AND originalAirDate='2012-02-16' OR originalAirDate='2012-02-14'";
			var TopWatched:String = "SELECT parentTitle, entityType, title, p, description  FROM tv";
			var TopDrama:String = "SELECT  parentTitle, entityType, title, p, description  FROM tv WHERE genre='Drama'";
			var Kids:String = "SELECT parentTitle, entityType, title, p, description  FROM tv WHERE rating='TVG'";
			
			
			query("Featured", Featured, Entity, 12);
			query("TopWatched", TopWatched, Entity, 12);
			query("TopDrama", TopDrama, Entity, 12);
			query("Kids", Kids, Entity, 12);
												
				
		}

	}

};

