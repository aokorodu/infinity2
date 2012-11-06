﻿package com.oakwood.vimeo.common {	import flash.display.MovieClip;	import flash.media.Video;	import flash.net.NetConnection;	import flash.net.NetStream;    /**     * Example Player     *     * A simple example of referencing a vimeo video from a PRO account      * and playing in a custom video player within flash     *     * @author      Jez Becker (jeremy.becker@oakwood-dc.com)	 */	public class BasicVimeoPlayer extends MovieClip    {       		private var vid:Video = new Video();		public function BasicVimeoPlayer()        {                   }                public function init(url:String) : void        {			//TODO We should probably add some error event handlers etc..			//create connection			var nc:NetConnection = new NetConnection();			nc.connect(null);			var ns:NetStream = new NetStream(nc);			//create client to handle the metadata			ns.client = {};			ns.client.onMetaData = ns_onMetaData;			vid.attachNetStream(ns);			stage.addChild(vid);						ns.play(url);					}		public function ns_onMetaData(item:Object):void 		{		    // Meta data receieved for file - Resize video instance.		    vid.width = item.width;		    vid.height = item.height;		    // Center video instance on Stage.		    vid.x = (stage.stageWidth - vid.width) / 2;		    vid.y = (stage.stageHeight - vid.height) / 2;		}    }}