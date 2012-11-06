package com.shearspire {
	import flash.events.MouseEvent;
	
	public class BasicButton extends BasicObject {
		public function BasicButton() {
			super();
			this.buttonMode = true;
			this.mouseChildren = false;
			this.addEventListener(MouseEvent.CLICK,theParent.clickBtn);
			this.addEventListener(MouseEvent.ROLL_OVER,go2);
			this.addEventListener(MouseEvent.ROLL_OUT,go1);
		}
	}
}