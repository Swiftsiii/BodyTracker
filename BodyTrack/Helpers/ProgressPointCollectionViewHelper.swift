//
//  ProgressPointCollectionViewHelper.swift
//  BodyTrack
//
//  Created by Tom Sugarex on 18/06/2015.
//  Copyright (c) 2015 Tom Sugarex. All rights reserved.
//

import UIKit

class ProgressPointCollectionViewHelper: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    let reuseIdentifier = "Cell"
    let ProgressPointSegueId = "showProgressPointId"
    let bodyReuseIdentifier = "BodyCollectionViewCellId"
    let addReuseIdentifier = "AddCollectionViewId"
    var progressPoints = [ProgressPoint]()
    
    @IBOutlet weak var photoSelectionCollectionViewController: PhotoSelectionCollectionViewController!
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        return self.progressPoints.count + 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        var cell : AnyObject?
        
        if (indexPath.row == self.progressPoints.count)
        {
            cell = collectionView.dequeueReusableCellWithReuseIdentifier(addReuseIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
            
            if let cellSafe: UICollectionViewCell = cell as? UICollectionViewCell
            {
                cellSafe.layer.borderColor = UIColor.purpleColor().CGColor;
                cellSafe.layer.borderWidth = 1.0
                
                return cellSafe
            }
            
        }
        else
        {
            var progressPoint: ProgressPoint = self.progressPoints[indexPath.row]
            
            var imageData: NSData? = NSData.dataWithContentsOfMappedFile(progressPoint.imageName) as? NSData
            var progressImage: UIImage?
            
            if let imageData = imageData
            {
                progressImage = UIImage(data: imageData)
            }
            
            var cell: ProgressPointCollectionViewCell? = collectionView.dequeueReusableCellWithReuseIdentifier(bodyReuseIdentifier, forIndexPath: indexPath) as? ProgressPointCollectionViewCell
            
            if let cellSafe = cell
            {
                if let image = progressImage
                {
                    cellSafe.progressPicImageView.image = progressImage
                }
                
                    
                cellSafe.contentView.frame = cellSafe.bounds
                cellSafe.contentView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
                
                cellSafe.layer.borderColor = UIColor.purpleColor().CGColor;
                cellSafe.layer.borderWidth = 1.0
                return cellSafe
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsetsMake(16, 16, 8, 16)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        let padding:CGFloat = 8 * 3
        let side:CGFloat = CGRectGetWidth(collectionView.frame) / 2
        let sideMinusPadding:CGFloat = side - padding
        return CGSizeMake(sideMinusPadding, sideMinusPadding + 44)
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat
    {
        return 7
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat
    {
        return 8
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        if (indexPath.row == self.progressPoints.count)
        {
            self.photoSelectionCollectionViewController.showActionSheet()
        }
    }
}
