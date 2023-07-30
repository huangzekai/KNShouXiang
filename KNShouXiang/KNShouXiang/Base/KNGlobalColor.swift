//
//  KNGlobalColor.swift
//  KNToolsSet
//
//  Created by kenny on 2023/7/28.
//

import UIKit

//红色：秋海棠红
let redColor = UIColor(hex: "#ec2b24")
//深红色
let deepRedColor = UIColor(hex: "#FA1627")
//灰色
let grayColor = UIColor(hex: "#CFCBCB")
//
let textGrayColor = UIColor(hex: "#848484")
//黑色
let blackColor = UIColor(hex: "#333333")
//浅灰色
let lightGrayColor = UIColor(hex: "#F1F1F1")

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexStringSlice = hexString[start...]
            hexString = String(hexStringSlice)
        }

        let scanner = Scanner(string: hexString)
        var colorValue: UInt64 = 0
        scanner.scanHexInt64(&colorValue)

        let redValue = CGFloat((colorValue & 0xFF0000) >> 16) / 255.0
        let greenValue = CGFloat((colorValue & 0x00FF00) >> 8) / 255.0
        let blueValue = CGFloat(colorValue & 0x0000FF) / 255.0

        self.init(red: redValue, green: greenValue, blue: blueValue, alpha: alpha)
    }
    
    func toImage(size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
         let rect = CGRect(origin: .zero, size: size)
         UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
         self.setFill()
         UIRectFill(rect)
         let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
         UIGraphicsEndImageContext()
         return image
     }
}
