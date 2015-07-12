part of raumffisch;


//non blocking collecting of the the keyinputs.
class MultiKeyController{
  HashMap<int,int> _pressedKeys = new HashMap<int,int>();
  
  MultiKeyController(){
    window.onKeyDown.listen((KeyboardEvent e) {
          if (!_pressedKeys.containsKey(e.keyCode))
            _pressedKeys[e.keyCode] = e.timeStamp;
        });

    window.onKeyUp.listen((KeyboardEvent e) {
          _pressedKeys.remove(e.keyCode);
    });
        
  }
  
//checks whether a key was pressed.
  isPressed(int keyCode) => _pressedKeys.containsKey(keyCode);
}