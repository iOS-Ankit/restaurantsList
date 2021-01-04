//
//  CategoryCollectionViewCell.swift
//  Restaurants
//
//  Created by Ankit on 14/10/20.
//  Copyright © 2020 Ankit. All rights reserved.
//

import UIKit
import Kingfisher

class CategoryCollectionViewCell: UICollectionViewCell {
    
    
    // MARK: Cell Interface Builder Outlets
    
    @IBOutlet var categoryImageVw: UIImageView!
    @IBOutlet var categoryNameLbl: UILabel!
    
    
    // MARK: Set Cell Data
    
    func setCategoryData(category: Resturant.Category) {
        let urlStr = "https://appgrowthcompany.com:3000\(category.image ?? "")"
        let url = URL(string: urlStr)
        categoryImageVw.kf.setImage(with: url)
        categoryNameLbl.text = "\(category.name ?? "")(\(category.restaurants ?? 0))"
    }
}
