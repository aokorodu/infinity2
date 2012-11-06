﻿////  Opens connection to sqlite dbd, gets data, handles errors////  Created by Matthew on 2012-10-19.//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.//	//package com.mhl.data{		import com.mhl.*;		import com.mhl.views.entity;		import app.model.AppModel;		import com.mhl.libs.recentActivity;		import flash.display.MovieClip;		import flash.display.Sprite;		import flash.utils.Dictionary; 		import fl.data.DataProvider;		import flash.data.SQLResult;		import flash.data.SQLConnection;		import flash.filesystem.File;		import flash.data.SQLStatement;		import flash.data.SQLConnection;		import flash.events.*;		import flash.events.EventDispatcher;		import flash.events.Event;			 public class database extends Object{				public var conn:SQLConnection;		private var selectStmt:SQLStatement;						private var _origin:MovieClip;		private var model:AppModel;		public function database(model:AppModel) {			conn = new SQLConnection();			conn.addEventListener(SQLEvent.OPEN, openSuccess);			conn.addEventListener(SQLErrorEvent.ERROR, openFailure);			trace("Creating and opening database");			var embededSessionDB:File = File.applicationDirectory.resolvePath("data/entity.sqlite");			conn.openAsync(embededSessionDB);						this.model = model;							}		public function openSuccess(event:SQLEvent):void		{			conn.removeEventListener(SQLEvent.OPEN, openSuccess);			conn.removeEventListener(SQLErrorEvent.ERROR, openFailure);			//createTable();		}		public function openFailure(event:SQLErrorEvent):void		{			conn.removeEventListener(SQLEvent.OPEN, openSuccess);			conn.removeEventListener(SQLErrorEvent.ERROR, openFailure);			trace("Error opening database");			trace("event.error.message:", event.error.message);			trace("event.error.details:", event.error.details);		}				public function getData(query:String, myClass:Class):void		{			trace("Loading data");			selectStmt = new SQLStatement();			selectStmt.sqlConnection = conn;			var sql:String = query;			selectStmt.text = sql;			selectStmt.itemClass = myClass;			selectStmt.addEventListener(SQLEvent.RESULT, selectResult);			selectStmt.addEventListener(SQLErrorEvent.ERROR, selectError);			selectStmt.execute();		}	public 	function selectResult(event:SQLEvent):void		{			trace("Result Ready: Notify");			selectStmt.removeEventListener(SQLEvent.RESULT, selectResult);			selectStmt.removeEventListener(SQLErrorEvent.ERROR, selectError);			this.model.dbResult = selectStmt.getResult();									}	public function selectError(event:SQLErrorEvent):void		{			trace("Error loading data");			selectStmt.removeEventListener(SQLEvent.RESULT, selectResult);			selectStmt.removeEventListener(SQLErrorEvent.ERROR, selectError);			trace("SELECT error:", event.error);			trace("event.error.message:", event.error.message);			trace("event.error.details:", event.error.details);		}	}};