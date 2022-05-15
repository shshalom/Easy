//
//  EasyColors.swift
//  Easy
//
//  Created by Shalom on 06/04/2020.
//  Copyright © 2020 Shalom Shwaitzer & Eliran Sharabi. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count >= 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    
                    if hexColor.count == 8 {
                        a = CGFloat(hexNumber & 0x000000ff) / 255
                    } else {
                        a = 1.0
                    }
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
    
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}

public extension String {
    var color: UIColor {
        return UIColor(hex: self) ?? .black
    }
}

public extension UIView {
    
    @discardableResult
    func background(gradient style: Gradient.Properties...) -> Self {
        
        let view = Gradient.View(frame: bounds)
        
        style.forEach { p in
            switch p {
            case let .colors(colors):
                view.colors = colors
            case let .mode(mode):
                view.mode = mode
            case let .radius(multiply: value):
                view.radiusMultiply = value
            case let .direction(dir):
                view.direction = dir
            case .automaticDim:
                view.automaticallyDims = true
            case let .dimColors(colors):
                view.dimmedColors = colors
            case let .drawBoarders(top: top, left: left, right: right, bottom: bottom):
                view.drawsThinBorders = true
                view.topBorderColor = top
                view.leftBorderColor = left
                view.rightBorderColor = right
                view.bottomBorderColor = bottom
            }
        }
        
        insertSubview(view, at: 0)
        
        return self
    }
}

public class Gradient {
    
    public enum Properties {
        case colors([UIColor])
        case mode(Mode)
        case direction(Direction)
        case radius(multiply: CGFloat)
        case automaticDim
        case dimColors([UIColor])
        case drawBoarders(top: UIColor, left: UIColor, right: UIColor, bottom: UIColor)
    }
    
    public enum Mode: Int {
        case linear
        case radial
    }
    
    public enum Direction: Int {
        case vertical
        case horizontal
    }
}

public extension Gradient {
    
    class View: UIView {
        
        var colors: [UIColor]? {
            didSet {
                updateGradient()
            }
        }
        
        /// An array of `UIColor` objects used to draw the dimmed gradient. If the value is `nil`, `colors` will be
        /// converted to grayscale. This will use the same `locations` as `colors`. If length of arrays don't match, bad
        /// things will happen. You must make sure the number of dimmed colors equals the number of regular colors.
        ///
        /// The default is `nil`.
        var dimmedColors: [UIColor]? {
            didSet {
                updateGradient()
            }
        }
        
        /// Automatically dim gradient colors when prompted by the system (i.e. when an alert is shown).
        ///
        /// The default is `true`.
        var automaticallyDims: Bool = true
        
        /// An optional array of `CGFloat`s defining the location of each gradient stop.
        ///
        /// The gradient stops are specified as values between `0` and `1`. The values must be monotonically increasing. If
        /// `nil`, the stops are spread uniformly across the range.
        ///
        /// Defaults to `nil`.
        var locations: [CGFloat]? {
            didSet {
                updateGradient()
            }
        }
        
        var radiusMultiply: CGFloat = 1 {
            didSet {
                setNeedsDisplay()
            }
        }
        
        var mode: Mode = .linear {
            didSet {
                setNeedsDisplay()
            }
        }
        
        var direction: Direction = .vertical {
            didSet {
                setNeedsDisplay()
            }
        }
        
        var drawsThinBorders: Bool = true {
            didSet {
                setNeedsDisplay()
            }
        }
        
        /// The top border color. The default is `nil`.
        var topBorderColor: UIColor? {
            didSet {
                setNeedsDisplay()
            }
        }
        
        /// The right border color. The default is `nil`.
        var rightBorderColor: UIColor? {
            didSet {
                setNeedsDisplay()
            }
        }
        
        ///  The bottom border color. The default is `nil`.
        var bottomBorderColor: UIColor? {
            didSet {
                setNeedsDisplay()
            }
        }
        
        /// The left border color. The default is `nil`.
        var leftBorderColor: UIColor? {
            didSet {
                setNeedsDisplay()
            }
        }
        
        // MARK: - UIView
        override public func draw(_ rect: CGRect) {
            let context = UIGraphicsGetCurrentContext()
            let size = bounds.size
            
            // Gradient
            if let gradient = gradient {
                let options: CGGradientDrawingOptions = [.drawsAfterEndLocation]
                
                if mode == .linear {
                    let startPoint = CGPoint.zero
                    let endPoint = direction == .vertical ? CGPoint(x: 0, y: size.height) : CGPoint(x: size.width, y: 0)
                    context?.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: options)
                } else {
                    let center = CGPoint(x: bounds.midX, y: bounds.midY)
                    context?.drawRadialGradient(gradient, startCenter: center, startRadius: 0, endCenter: center, endRadius: min(size.width, size.height) / 2 * self.radiusMultiply, options: options)
                }
            }
            
            let screen: UIScreen = window?.screen ?? UIScreen.main
            let borderWidth: CGFloat = drawsThinBorders ? 1.0 / screen.scale : 1.0
            
            // Top border
            if let color = topBorderColor {
                context?.setFillColor(color.cgColor)
                context?.fill(CGRect(x: 0, y: 0, width: size.width, height: borderWidth))
            }
            
            let sideY: CGFloat = topBorderColor != nil ? borderWidth : 0
            let sideHeight: CGFloat = size.height - sideY - (bottomBorderColor != nil ? borderWidth : 0)
            
            // Right border
            if let color = rightBorderColor {
                context?.setFillColor(color.cgColor)
                context?.fill(CGRect(x: size.width - borderWidth, y: sideY, width: borderWidth, height: sideHeight))
            }
            
            // Bottom border
            if let color = bottomBorderColor {
                context?.setFillColor(color.cgColor)
                context?.fill(CGRect(x: 0, y: size.height - borderWidth, width: size.width, height: borderWidth))
            }
            
            // Left border
            if let color = leftBorderColor {
                context?.setFillColor(color.cgColor)
                context?.fill(CGRect(x: 0, y: sideY, width: borderWidth, height: sideHeight))
            }
        }
        
        override public func tintColorDidChange() {
            super.tintColorDidChange()
            
            if automaticallyDims {
                updateGradient()
            }
        }
        
        override public func didMoveToWindow() {
            super.didMoveToWindow()
            contentMode = .redraw
        }
        
        // MARK: - Private
        fileprivate var gradient: CGGradient?
        
        fileprivate func updateGradient() {
            gradient = nil
            setNeedsDisplay()
            
            let colors = gradientColors()
            if let colors = colors {
                let colorSpace = CGColorSpaceCreateDeviceRGB()
                let colorSpaceModel = colorSpace.model
                
                let gradientColors = colors.map { (color: UIColor) -> AnyObject in
                    let cgColor = color.cgColor
                    let cgColorSpace = cgColor.colorSpace ?? colorSpace
                    
                    // The color's color space is RGB, simply add it.
                    if cgColorSpace.model == colorSpaceModel {
                        return cgColor as AnyObject
                    }
                    
                    // Convert to RGB. There may be a more efficient way to do this.
                    var red: CGFloat = 0
                    var blue: CGFloat = 0
                    var green: CGFloat = 0
                    var alpha: CGFloat = 0
                    color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
                    return UIColor(red: red, green: green, blue: blue, alpha: alpha).cgColor as AnyObject
                } as NSArray
                
                gradient = CGGradient(colorsSpace: colorSpace, colors: gradientColors, locations: locations)
            }
        }
        
        fileprivate func gradientColors() -> [UIColor]? {
            if tintAdjustmentMode == .dimmed {
                if let dimmedColors = dimmedColors {
                    return dimmedColors
                }
                
                if automaticallyDims {
                    if let colors = colors {
                        return colors.map {
                            var hue: CGFloat = 0
                            var brightness: CGFloat = 0
                            var alpha: CGFloat = 0
                            
                            $0.getHue(&hue, saturation: nil, brightness: &brightness, alpha: &alpha)
                            
                            return UIColor(hue: hue, saturation: 0, brightness: brightness, alpha: alpha)
                        }
                    }
                }
            }
            
            return colors
        }
    }
}
