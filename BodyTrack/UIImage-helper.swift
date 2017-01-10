//
//  UIImage-helper.swift
//  BodyTrack
//
//  Created by Tom Sugarev on 03/07/2015.
//  Copyright (c) 2015 Tom Sugarex. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {

    func imageRotatedBy90Degrees(flip: Bool) -> UIImage {

        let rotatedViewBox = UIView(frame: CGRect(x: 0, y: 0, width: self.size.height, height: self.size.width))
        let t = CGAffineTransform(rotationAngle: 0.5 * CGFloat(M_PI))
        rotatedViewBox.transform = t
        let rotatedSize = rotatedViewBox.frame.size

        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap = UIGraphicsGetCurrentContext()

        bitmap!.translateBy(x: rotatedSize.width / 2.0, y: rotatedSize.height / 2.0)

        //   // Rotate the image context
        bitmap!.rotate(by: 0.5 * CGFloat(M_PI))

        // Now, draw the rotated/scaled image into the context
        var yFlip: CGFloat

        if flip {
            yFlip = CGFloat(-1.0)
        } else {
            yFlip = CGFloat(1.0)
        }

        bitmap!.scaleBy(x: yFlip, y: -1.0)

        bitmap!.draw(self.cgImage!,
                     in: CGRect(x: -size.height / 2,
                                y: -size.width / 2,
                                width: size.height,
                                height: size.width)
        )

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }

    class func createCompareImage(_ progressPoint1: ProgressPoint,
                                  progressPoint2: ProgressPoint,
                                  statsEnabled: Bool) -> UIImage {

        let image1: UIImage = progressPoint1.getImage()!
        let image2: UIImage = progressPoint2.getImage()!
        let size = CGSize(width: image1.size.width * 2, height: image1.size.height)

        let font = UIFont.systemFont(ofSize: 16)

        UIGraphicsBeginImageContext(size)

        image1.draw(in: CGRect(x: 0, y: 0, width: image1.size.width, height: image1.size.height))
        image2.draw(in: CGRect(x: image1.size.width, y: 0, width: image2.size.width, height: image2.size.height))

        if statsEnabled {
            let attributes = [
                NSFontAttributeName: font,
                NSForegroundColorAttributeName: UIColor.white,
                NSBackgroundColorAttributeName: UIColor.black.withAlphaComponent(0.5)
            ]

            let rectForLeftImageStats = CGRect(
                x: 10,
                y: image1.size.height - 100,
                width: progressPoint1.description.size(attributes: attributes).width,
                height: 100

            )

            progressPoint1.description.draw(in: rectForLeftImageStats, withAttributes: attributes)

            let rectForRightImageStats = CGRect(
                x: image2.size.width + 10,
                y: image2.size.height - 100,
                width: progressPoint2.description.size(attributes: attributes).width,
                height: 100
            )

            progressPoint2.description.draw(in: rectForRightImageStats, withAttributes:attributes)
        }

        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return finalImage!
    }
}
