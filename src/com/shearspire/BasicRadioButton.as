package com.shearspire {
	import flash.events.MouseEvent;
	
	public class BasicRadioButton extends BasicObject {
		public var selected:Boolean = false;
		public var btnLabel:String = "";
		
		public function BasicRadioButton() {
			super();
			this.buttonMode = true;
			this.mouseChildren = false;
			this.addEventListener(MouseEvent.CLICK,theParent.clickBtn);
			this.addEventListener(MouseEvent.ROLL_OVER,go2);
			this.addEventListener(MouseEvent.ROLL_OUT,go1);
		}
		public function setLabel(s:String):void {
			btnLabel = s;
			fld.text = btnLabel;
		}
		public function select():void {
			gotoAndStop(3);
			setLabel(btnLabel);
			selected = true;
		}
		public function deselect():void {
			gotoAndStop(1);
			setLabel(btnLabel);
			selected = false;
		}
		override public function go2(e:MouseEvent):void{
			e.target.gotoAndStop(2);
			setLabel(btnLabel);
		}
		override public function go1(e:MouseEvent):void{
			e.target.gotoAndStop(1);
			setLabel(btnLabel);
		}
		public function disable():void {
			deselect();
			this.removeEventListener(MouseEvent.CLICK,theParent.clickBtn);
			this.removeEventListener(MouseEvent.ROLL_OVER,go2);
			this.removeEventListener(MouseEvent.ROLL_OUT,go1);
			this.buttonMode = false;
		}
	}
}