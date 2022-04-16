import Foundation
import UIKit

extension UIView {
    
    public func top(_ top: NSLayoutAnchor<NSLayoutYAxisAnchor>?, padding size: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: size).isActive = true
        }
    }
    
    
    public func top(_ top: NSLayoutAnchor<NSLayoutYAxisAnchor>?) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top).isActive = true
        }
    }
    
    
    public func leading(_ leading: NSLayoutAnchor<NSLayoutXAxisAnchor>?, padding size: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: size).isActive = true
        }
    }
    
    
    public func leading(_ leading: NSLayoutAnchor<NSLayoutXAxisAnchor>?) {
        translatesAutoresizingMaskIntoConstraints = false
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading).isActive = true
        }
    }
    
    
    public func trailing(_ trailing: NSLayoutAnchor<NSLayoutXAxisAnchor>?, padding size: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: size).isActive = true
        }
    }
    
    
    public func trailing(_ trailing: NSLayoutAnchor<NSLayoutXAxisAnchor>?) {
        translatesAutoresizingMaskIntoConstraints = false
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing).isActive = true
        }
    }
    
    
    public func bottom(_ bottom: NSLayoutAnchor<NSLayoutYAxisAnchor>?, padding size: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: size).isActive = true
        }
    }
    
    
    public func bottom(_ bottom: NSLayoutAnchor<NSLayoutYAxisAnchor>?) {
        translatesAutoresizingMaskIntoConstraints = false
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom).isActive = true
        }
    }
    
    
    public func size(_ size: CGSize) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
    }
    
    
    public func width(_ size: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    
    public func height(_ size: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    
    public func x(_ centerX: NSLayoutAnchor<NSLayoutXAxisAnchor>?, y centerY: NSLayoutAnchor<NSLayoutYAxisAnchor>?) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: centerX!).isActive = true
        centerYAnchor.constraint(equalTo: centerY!).isActive = true
    }
    
    
    public func x(_ centerX: NSLayoutAnchor<NSLayoutXAxisAnchor>?) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: centerX!).isActive = true
    }
    
    
    public func y(_ centerY: NSLayoutAnchor<NSLayoutYAxisAnchor>?) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: centerY!).isActive = true
    }
    
    
    public func x(_ centerX: NSLayoutAnchor<NSLayoutXAxisAnchor>?, padding size: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: centerX!, constant: size).isActive = true
    }
    
    
    public func y(_ centerY: NSLayoutAnchor<NSLayoutYAxisAnchor>?, padding size: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: centerY!, constant: size).isActive = true
    }
    
    
    public func fill() {
        
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: self.superview!.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: self.superview!.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: self.superview!.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: self.superview!.bottomAnchor).isActive = true
    }
    
    
    public func fill(padding: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: self.superview!.topAnchor, constant: padding).isActive = true
        leadingAnchor.constraint(equalTo: self.superview!.leadingAnchor, constant: padding).isActive = true
        trailingAnchor.constraint(equalTo: self.superview!.trailingAnchor, constant: -padding).isActive = true
        bottomAnchor.constraint(equalTo: self.superview!.bottomAnchor, constant: -padding).isActive = true
    }
    
    
    public func fill(top: CGFloat, left: CGFloat, right: CGFloat, bottom: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: self.superview!.topAnchor, constant: top).isActive = true
        leadingAnchor.constraint(equalTo: self.superview!.leadingAnchor, constant: left).isActive = true
        trailingAnchor.constraint(equalTo: self.superview!.trailingAnchor, constant: right).isActive = true
        bottomAnchor.constraint(equalTo: self.superview!.bottomAnchor, constant: bottom).isActive = true
    }
    
    
}
