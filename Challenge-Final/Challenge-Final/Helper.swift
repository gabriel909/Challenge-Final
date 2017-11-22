//
//  Helper.swift
//  Challenge-Final
//
//  Created by Luisa Mello on 11/09/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

import Foundation
import UIKit

//Screen width and height
let screenRect = UIScreen.main.bounds
let width = screenRect.size.width
let height = screenRect.size.height

//MARK: - Extensions
//MARK: Navigation Bar
extension UINavigationBar {
    //Transparent Bar
    func transparentNavigationBar() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
    }
}

//MARK: String
extension String {
    func getFormattedDate() -> String {
        var array: [String] = []
        var strTemp: String = ""
        
        for letter in self {
            if letter == "T" {
                array.append(strTemp)
                break
                
            } else if letter == "-" {
                array.append(strTemp)
                strTemp = ""
                
            } else {
                strTemp += "\(letter)"
                
            }
        }
        
        strTemp = array.reversed().joined(separator: "/")
        return strTemp
    }
    
    var localized: String {
        print(self)
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}

//MARK: View Controller
extension UIViewController {
    //Hide the keyboard when user tap on the screen
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

//MARK: UIButton
extension UIButton {
    func animateButton() {
        let anticOverTiming = CAMediaTimingFunction(controlPoints: 0.42, -0.30, 0.58, 1.30)
        let overshootTiming = CAMediaTimingFunction(controlPoints: 0.00, 0.00, 0.58, 1.30)
        
        let modeloBotaoScaleXAnimation = CAKeyframeAnimation(keyPath: "transform.scale.x")
        modeloBotaoScaleXAnimation.duration = 0.350
        modeloBotaoScaleXAnimation.values = [1.000 as Float, 0.800 as Float, 1.100 as Float, 1.000 as Float]
        modeloBotaoScaleXAnimation.keyTimes = [0.000 as NSNumber, 0.286 as NSNumber, 0.643 as NSNumber, 1.000 as NSNumber]
        modeloBotaoScaleXAnimation.timingFunctions = [anticOverTiming, anticOverTiming, overshootTiming]
        self.layer.add(modeloBotaoScaleXAnimation, forKey:"ButtonPress_ScaleX")
        
        let modeloBotaoScaleYAnimation = CAKeyframeAnimation(keyPath: "transform.scale.y")
        modeloBotaoScaleYAnimation.duration = 0.350
        modeloBotaoScaleYAnimation.values = [1.000 as Float, 0.800 as Float, 1.100 as Float, 1.000 as Float]
        modeloBotaoScaleYAnimation.keyTimes = [0.000 as NSNumber, 0.286 as NSNumber, 0.643 as NSNumber, 1.000 as NSNumber]
        modeloBotaoScaleYAnimation.timingFunctions = [anticOverTiming, anticOverTiming, overshootTiming]
        self.layer.add(modeloBotaoScaleYAnimation, forKey:"ButtonPress_ScaleY")
    }
}

//MARK: UIColor
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

//MARK: - UIImage
extension UIImage {
    func resize(_ targetSize: CGSize) -> UIImage {
        let size = self.size
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        var newSize: CGSize
        
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
            
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
            
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

//MARK: UIView
extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowOpacity = 0.4
            layer.shadowRadius = shadowRadius
        }
    }
}

//MARK: as UISearchBar extension
extension UISearchBar {
    func changeSearchBar(color : UIColor) {
        for subView in self.subviews {
            for subSubView in subView.subviews {
                
                if let _ = subSubView as? UITextInputTraits {
                    let textField = subSubView as! UITextField
                    textField.backgroundColor = color
                    
                    break
                }
                
            }
        }
    }
    
    func changeTint(color: UIColor) {
        for subView in self.subviews {
            for subSubView in subView.subviews {
                
                if let _ = subSubView as? UITextInputTraits {
                    let textField = subSubView as! UITextField
                    textField.textColor = color
                    
                    let textFieldInsideUISearchBarLabel = textField.value(forKey: "placeholderLabel") as? UILabel
                    textFieldInsideUISearchBarLabel?.textColor = .white
                    break
                }
            }
        }
    }
    
}

extension UIImage {
    func tinted(with color: UIColor) -> UIImage? {
        defer { UIGraphicsEndImageContext() }
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()
        withRenderingMode(.alwaysTemplate).draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

//Global Methods
//Create and present an UIAlert
public func message(_ title: String, desc: String, view: UIViewController) {
    let alertController = UIAlertController(title: title, message: desc, preferredStyle: UIAlertControllerStyle.alert)
    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
    
    view.present(alertController, animated: true, completion: nil)
}

class SegueFromRight: UIStoryboardSegue {
    override func perform() {
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
            
        }, completion: { finished in
            src.present(dst, animated: false, completion: nil)
            
        })
    }
}

class SegueFromLeft: UIStoryboardSegue {
    override func perform() {
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: -src.view.frame.size.width, y: 0)
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
            
        }, completion: { finished in
            src.present(dst, animated: false, completion: nil)
            
        })
    }
}
