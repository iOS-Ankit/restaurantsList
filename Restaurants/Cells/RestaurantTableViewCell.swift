//
//  RestaurantTableViewCell.swift
//  Dash
//
//  Created by Ankit on 14/10/20.
//  Copyright © 2020 Ankit. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    
    
    // MARK: Cell Interface Builder Outlets
    
    @IBOutlet var sectionNameLbl: UILabel!
    @IBOutlet var viewAllBtn: UIButton!
    @IBOutlet var restaurantsCollVwHeight: NSLayoutConstraint!
    @IBOutlet var restaurantsCollVw: UICollectionView!
    
    // MARK: Cell Interface Properties
    
    var categoryList = [Resturant.Category]()
    var savedList = [Resturant.Offer]()
    var bestOffersList = [Resturant.Offer]()
    var recomendedList = [Resturant.Offer]()
    
    // MARK: Set Cell Data
    
    func setRestaurantData(restaurantsData: Resturant.RestaurantsInfo?) {
        if let data = restaurantsData {
            switch restaurantsCollVw.tag {
            case 0:
                sectionNameLbl.text = "Category"
                if let categories = data.categories {
                    categoryList = categories
                }
            case 1:
                sectionNameLbl.text = "Saved Restaurants"
                if let saved = data.saved {
                    savedList = saved
                }
            case 2:
                sectionNameLbl.text = "Best Offers"
                if let bestOffers = data.bestOffers {
                    bestOffersList = bestOffers
                }
            default:
                sectionNameLbl.text = "Recomended"
                if let recommended = data.recommended {
                    recomendedList = recommended
                }
            }
        }
        restaurantsCollVw.reloadData()
    }
}

extension RestaurantTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return categoryList.count
        case 1:
            return savedList.count
        case 2:
            return bestOffersList.count
        default:
            return recomendedList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView.tag {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
            cell.setCategoryData(category: categoryList[indexPath.item])
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OffersCollectionViewCell", for: indexPath) as! OffersCollectionViewCell
            cell.setOfferData(offer: savedList[indexPath.item], tag: 1)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OffersCollectionViewCell", for: indexPath) as! OffersCollectionViewCell
            cell.setOfferData(offer: bestOffersList[indexPath.item], tag: 2)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OffersCollectionViewCell", for: indexPath) as! OffersCollectionViewCell
            cell.setOfferData(offer: recomendedList[indexPath.item], tag: 3)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0 {
            let cellSize = CGSize(width: 120, height: 170)
            return cellSize
        } else {
            let cellSize = CGSize(width: 250, height: 230)
            return cellSize
        }
    }
}
