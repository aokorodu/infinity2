﻿package app.model {	import app.*;	import app.model.*;	import app.model.entitydata.*;	import app.view.*;	import app.control.*;	import com.mhl.data.database;	import flash.display.MovieClip;	import flash.utils.Dictionary; 	import flash.data.SQLResult;	import flash.data.SQLStatement;	import com.mhl.views.entity;	import flash.events.EventDispatcher;	import flash.events.Event;		public class AppModel extends EventDispatcher {		public static const UPDATE:String='update';		private var _holder:MovieClip;		private var _dataConn:DataConn;		private var _dbResult:SQLResult;		private var _dataSets:Dictionary;		private var _episodeSets:Dictionary;		private var _catalog:Array;		private var _episodes:String;		private var _movies:String;		private var _query_episodes:EntityData;		private var _destinationEntity:Entity;				//mobile		public var _drawerIsOpen:Boolean;			public function AppModel() {		this._dataConn = new DataConn(this);		this._dataSets = new Dictionary();		this._episodeSets = new Dictionary();		this._catalog = new Array();		// User Genrated Queries 		_query_episodes = new Episodes(this);		this._drawerIsOpen = false	}	public function addData(_set:EntityData):void{		trace(_set.title)		trace(_set.entitymap)		_dataSets[_set.title] = _set.entitymap;	}	public function get dataSets():Dictionary{		return _dataSets	}	public function set catalog(value:Array){		this._catalog = value;			notifyObservers();	}	public function get catalog():Array{		return _catalog;	}	public function set episodeSets(value:Dictionary):void{		_episodeSets = value;		this.catalog = ["Get Episodes"];	}	public function get episodeSets():Dictionary{		return _episodeSets;	}	public function get dataConn():DataConn{		return _dataConn	}	public function set episodes(value:String):void{		this._episodes = value;		_query_episodes.init();	}	public function get episodes():String{	return _episodes	}	public function set destinationEntity(entity:Entity){		_destinationEntity = entity;			}	public function get destinationEntity():Entity{		return _destinationEntity;	}	public function set holder(value:MovieClip):void{		this._holder = value; 	}	public function get holder():MovieClip{		return _holder;	}		// Set state of Navigation Drawer	public function set drawerIsOpen(value:Boolean):void{		this._drawerIsOpen = value;		notifyObservers();	}		// Get Navigation Drawer state	public function get drawerIsOpen():Boolean{		return _drawerIsOpen;	}	// Dispatch to View and Model	public function notifyObservers():void {		dispatchEvent(new Event(AppModel.UPDATE));	}	}}