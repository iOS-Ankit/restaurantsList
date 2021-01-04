//
//  OffersCollectionViewCell.swift
//  Restaurants
//
//  Created by Ankit on 14/10/20.
//  Copyright © 2020 Ankit. All rights reserved.
//

import UIKit
import Kingfisher

class OffersCollectionViewCell: UICollectionViewCell {
    
    
    // MARK: Cell Interface Builder Outlets
    
    @IBOutlet var offerImageVw: UIImageView!
    @IBOutlet var offerNameLbl: UILabel!
    @IBOutlet var stackRightVw: UIView!
    @IBOutlet var categoriesOrDiscountLbl: UILabel!
    @IBOutlet var ratingLbl: UILabel!
    @IBOutlet var timeLbl: UILabel!
    @IBOutlet var countLbl: UILabel!
    
    
    // MARK: Set Cell Data
    
    func setOfferData(offer: Resturant.Offer, tag: Int) {
        let urlStr = "https://appgrowthcompany.com:3000\(offer.image ?? "")"
        let url = URL(string: urlStr)
        offerImageVw.kf.setImage(with: url)
        offerNameLbl.text = offer.name ?? ""
        
        if tag == 2 {
            stackRightVw.isHidden = false
            categoriesOrDiscountLbl.text = "\(offer.discount ?? 0.0)% Off Valid Up to \(offer.currency ?? "") \(offer.ratingCount ?? 0)"
            categoriesOrDiscountLbl.textColor = UIColor(red: 158.0/255.0, green: 204.0/255.0, blue: 59.0/255.0, alpha: 1)
        } else {
            categoriesOrDiscountLbl.textColor = UIColor.darkText
            var categoriesStr = ""
            if let categoriesArr = offer.categories {
                for category in categoriesArr {
                    categoriesStr.append(contentsOf: "\(category.name ?? ""), ")
                }
            } else {
                categoriesStr = "N/A"
            }
            stackRightVw.isHidden = true
            categoriesOrDiscountLbl.text = categoriesStr
        }
        
        ratingLbl.text = "\(offer.ratings ?? 0.0)(\(offer.ratingCount ?? 0))"
        timeLbl.text = "\(offer.avgDeliveryTime ?? 0) Min"
        countLbl.text = "\(offer.outletSize ?? 0)"
    }
}
