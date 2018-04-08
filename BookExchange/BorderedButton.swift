
//
import UIKit

@IBDesignable
class BorderedView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat  {
        get{
            return 3
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat  {
        get{
            return 1
        }
        set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable var borderColor: UIColor?   {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
}


@IBDesignable
class BorderedButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat  {
        get{
            return 3
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat  {
        get{
            return 1
        }
        set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable var borderColor: UIColor?   {
            didSet {
             layer.borderColor = borderColor?.cgColor
        }
    }
  }

@IBDesignable
class BorderedImageView: UIImageView {
    
    @IBInspectable var cornerRadius: CGFloat  {
        get{
            return 3
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat  {
        get{
            return 1
        }
        set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable var borderColor: UIColor?   {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
}

