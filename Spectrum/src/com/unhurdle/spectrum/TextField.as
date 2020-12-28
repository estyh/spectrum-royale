package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }
  import com.unhurdle.spectrum.const.IconType;

/**
 * <input type="text" placeholder="Enter your name" name="field" value="Not a valid input" class="spectrum-Textfield" pattern="[\d]+" required>
 * <input type="text" placeholder="Enter your name" name="field" value="A valid input" class="spectrum-Textfield spectrum-Textfield--quiet is-valid" pattern="[\w\s]+" required disabled>
 */
  public class TextField extends TextFieldBase
  {
    public function TextField()
    {
      super();
      _input.addEventListener("input",checkValidation);
    }

    public function get readonly():Boolean
    {
    	return input.readOnly;
    }

    public function set readonly(value:Boolean):void
    {
      input.readOnly = value;
    }

    public function get placeholder():String
    {
    	return input.placeholder;
    }

    public function set placeholder(value:String):void
    {
      if(value){
      	input.placeholder = value;
      } else {
        input.removeAttribute("placeholder");
      }
    }

    COMPILE::SWF
    override public function get name():String
    {
      return super.name;
    }
    COMPILE::SWF
    override public function set name(value:String):void
    {
      super.name = value;
    }

    COMPILE::JS
    public function get name():String
    {
    	return input.name;
    }

    COMPILE::JS
    public function set name(value:String):void
    {
        input.name = name;
    }

    public function get text():String
    {
      return input.value;
    }

    public function set text(value:String):void
    {
      if(value){
      	input.value = value;
      } else {
        input.value = "";
      }
      checkValidation();
    }

    private var _pattern:String;

    public function get pattern():String
    {
    	return _pattern;
    }

    public function set pattern(value:String):void
    {
      _pattern = value;
      if(text){
        checkValidation();
      }
    }
    private var _required:Boolean;
    public function get required():Boolean
    {
    	return input.required;
    }

    public function set required(value:Boolean):void
    {
      if(!!value != !!_required){
      	input.required = value;
      }
      _required = value;
    }


    override public function get disabled():Boolean
    {
    	return super.disabled;
    }

    override public function set disabled(value:Boolean):void
    {
      if(value != super.disabled){
        input.disabled = value;
      }
      super.disabled = value;
    }

    private var validIcon:Icon;
    private var invalidIcon:Icon;
    override public function get valid():Boolean
    {
    	return super.valid;
    }

    override public function set valid(value:Boolean):void
    {
      super.valid = value;
      if(value){
        if(!validIcon){
          var type:String = IconType.CHECKMARK_MEDIUM;
          validIcon = new Icon(Icon.getCSSTypeSelector(type));
          validIcon.className = appendSelector("-validationIcon");
          validIcon.type = type;
        }
        //if icon doesn't exist
        if(getElementIndex(validIcon) == -1){
          addElementAt(validIcon,0);
        }
      } else{
        if(validIcon && getElementIndex(validIcon) != -1){
          removeElement(validIcon);
        }
      }
    }

    override public function get invalid():Boolean
    {
    	return super.invalid;
    }

    override public function set invalid(value:Boolean):void
    {
      super.invalid = value;
      if(value){
        if(!invalidIcon){
          var type:String = IconType.ALERT_MEDIUM;
          invalidIcon = new Icon(Icon.getCSSTypeSelector(type));
          invalidIcon.className = appendSelector("-validationIcon");
          invalidIcon.type = type;
          invalidIcon.style = {'box-sizing': 'content-box'};
        }
        if(getElementIndex(invalidIcon) == -1){
          addElementAt(invalidIcon,0);
        }
      } else{
        if(invalidIcon && getElementIndex(invalidIcon) != -1){
          removeElement(invalidIcon);
        }
      }
    }

    private function checkValidation():void
    {
      if(pattern){
        var patt:RegExp = new RegExp(pattern);
        if(patt.test(_input.value)){
          valid = true;
        } else{
          invalid = true;
        }
      }
    }
    
    override public function get focusElement():HTMLElement{
      return _input;
    }

    protected var _input:HTMLInputElement;

    public function get input():HTMLInputElement
    {
    	return _input;
    }

    COMPILE::JS
		override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = super.createElement();
      _input = newElement("input",appendSelector("-input")) as HTMLInputElement;
      elem.appendChild(input);
      return elem;
    }
    private var _inputClass:String;

    public function get inputClass():String
    {
    	return _inputClass;
    }

    public function set inputClass(value:String):void
    {
    	_inputClass = value;
      input.className = appendSelector("-input") + " " + value;
    }
  }
}