////
////  BadgeChanger.swift
////  TrollBox
////
////  Created by Constantin Clerc on 23/12/2022.
////
//
// Badge Colour Changing
import SwiftUI
func changeColour(colour: UIColor) {
    var badge: UIImage = getRoundImage(12, 24, 24)!
    
    if UIDevice.current.userInterfaceIdiom == .pad {
        badge = getRoundImage(24, 48, 48)!
    }
    
    badge = changeImageColour(badge, colour)!
    
    let savePath = "/var/mobile/SBIconBadgeView.BadgeBackground:26:26.cpbitmap"
    let targetPath = "/var/mobile/Library/Caches/MappedImageCache/Persistent/SBIconBadgeView.BadgeBackground:26:26.cpbitmap"
    
    let helper = ObjcHelper.init()
    helper.image(toCPBitmap: badge, path: savePath)
    
    let fileManager = FileManager.default
    do {
        try fileManager.removeItem(atPath: targetPath)
    } catch {
        print("Failed to revert changes")
    }
    do {
        try fileManager.moveItem(atPath: savePath, toPath: targetPath)
    } catch {
        print("Failed to move item")
    }
}

func changeImageColour(_ src_image: UIImage?, _ color: UIColor?) -> UIImage? {

    let rect = CGRect(x: 0, y: 0, width: src_image?.size.width ?? 0.0, height: src_image?.size.height ?? 0.0)
    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
    let context = UIGraphicsGetCurrentContext()
    if let CGImage = src_image?.cgImage {
        context?.clip(to: rect, mask: CGImage)
    }
    if let cgColor = color?.cgColor {
        context?.setFillColor(cgColor)
    }
    context?.fill(rect)
    let colorized_image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return colorized_image
}

func getRoundImage(_ radius: Int, _ width: Int, _ height: Int) -> UIImage? {
    
    let rect = CGRect(x: 0, y: 0, width: CGFloat(width), height: CGFloat(height))
    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
    let context = UIGraphicsGetCurrentContext()
    context?.setFillColor(UIColor.black.cgColor)
    context?.fill(rect)
    let src_image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    let image_layer = CALayer()
    image_layer.frame = CGRect(x: 0, y: 0, width: src_image?.size.width ?? 0.0, height: src_image?.size.height ?? 0.0)
    image_layer.contents = src_image?.cgImage

    image_layer.masksToBounds = true
    image_layer.cornerRadius = CGFloat(radius)

    UIGraphicsBeginImageContextWithOptions(src_image?.size ?? CGSize.zero, false, 0.0)
    if let aContext = UIGraphicsGetCurrentContext() {
        image_layer.render(in: aContext)
    }
    let rounded_image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return rounded_image
}

func badgeButtonDiabled() -> Bool {
    return checkSandbox()
}
