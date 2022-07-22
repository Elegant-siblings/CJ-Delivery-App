//
//  Extensions.swift
//  CJ-Delivery-App
//
//  Created by 안현주 on 2022/07/22.
//

import Foundation
import UIKit

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
    class var cjWhite: UIColor { return UIColor(rgb: 0xF9F9F9) }
    class var cjRed: UIColor { return UIColor(rgb: 0xFF6F6F) }
    class var cjBlue: UIColor { return UIColor(rgb: 0x6FBAFF) }
    class var cjOragne: UIColor { return UIColor(rgb: 0xFF9A6F) }
    class var cjYellow: UIColor { return UIColor(rgb: 0xFFCE6E) }
    
}

extension UIView {
    func addSubviews(_ views: [UIView]) {
        for view in views {
            self.addSubview(view)
        }
    }
}

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}

extension CALayer {
    func  addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
                switch edge {
                    case UIRectEdge.top:
                        border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                        break
                    case UIRectEdge.bottom:
                        border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                        break
                    case UIRectEdge.left:
                        border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                        break
                    case UIRectEdge.right:
                        border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                        break
                    default:
                        break
                }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}

extension UIView {
  func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

extension UIButton {
    func alignTextBelow(spacing: CGFloat = 4.0) {
        
        guard let image = self.imageView?.image else { return }
        guard let titleLabel = self.titleLabel else { return }
        guard let titleText = titleLabel.text else { return }
        
        let titleSize = titleText.size(withAttributes: [
            NSAttributedString.Key.font: titleLabel.font as Any
        ])
        
        titleEdgeInsets = UIEdgeInsets(top: spacing, left: -image.size.width, bottom: -image.size.height, right: 0)
        imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0, bottom: 0, right: -titleSize.width)
    }
}
