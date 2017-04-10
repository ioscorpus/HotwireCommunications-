class Utilities {
  class func subviewsOfView(view: UIView, withType type: String) -> [UIView]
  {
    let prefix = "<\(type)"
    var subviewArray = view.subviews.flatMap { subview in subviewsOfView(subview, withType: type) }

    if view.description.hasPrefix(prefix) {
      subviewArray.append(view)
    }
    
    return subviewArray
  }
}

private func changeDoneButtonColorWhenKeyboardShows()
{
  NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillShowNotification, object: nil, queue: nil) { (notification) -> Void in
    self.changeKeyboardDoneKeyColor()
  }
}

private func changeKeyboardDoneKeyColor()
{
  let (keyboard, keys) = getKeyboardAndKeys()
  
  for key in keys {
    if keyIsOnBottomRightEdge(key, keyboardView: keyboard) {
      let newButton = newDoneButtonWithOld(key)
      keyboard.addSubview(newButton)
    }
  }
}

private func getKeyboardAndKeys() -> (keyboard: UIView, keys: [UIView])!
{
  for keyboardWindow in UIApplication.sharedApplication().windows {
    for view in keyboardWindow.subviews {
      for keyboard in Utilities.subviewsOfView(view, withType: "UIKBKeyplaneView") {
        let keys = Utilities.subviewsOfView(keyboard, withType: "UIKBKeyView")
        return (keyboard, keys)
      }
    }
  }
  
  return nil
}

private func keyIsOnBottomRightEdge(key: UIView, keyboardView: UIView) -> Bool
{
  let margin: CGFloat = 5
  let onRightEdge = key.frame.origin.x + key.frame.width + margin > keyboardView.frame.width
  let onBottom = key.frame.origin.y + key.frame.height + margin > keyboardView.frame.height
  
  return onRightEdge && onBottom
}

private func newDoneButtonWithOld(oldButton: UIView) -> UIButton
{
  let oldFrame = oldButton.frame
  let newFrame = CGRect(x: oldFrame.origin.x + 2,
                        y: oldFrame.origin.y + 1,
                        width: oldFrame.size.width - 4,
                        height: oldFrame.size.height - 4)
  
  let newButton = UIButton(frame: newFrame)
  newButton.backgroundColor = .secondaryColor
  newButton.layer.cornerRadius = 4;
  newButton.setTitle("Done", forState: .Normal)
  newButton.addTarget(self.searchBar, action: "resignFirstResponder", forControlEvents: .TouchUpInside)
  
  return newButton
}