//
//  HomeModel.swift
//  Restaurants
//
//  Created by Ankit on 14/10/20.
//  Copyright © 2020 Ankit. All rights reserved.
//

import Foundation

enum Resturant {
    
    struct RestaurantsInfo: Codable {
        var categories: [Category]?
        var saved: [Offer]?
        var bestOffers: [Offer]?
        var recommended: [Offer]?
    }
    
    struct Category: Codable {
        var _id: String?
        var name: String?
        var image: String?
        var restaurants: Int?
    }
    
    struct Outlet: Codable {
        var _id: String?
        var address: String?
        var latitude: Double?
        var longitude: Double?
        var distance: Double?
        var isSelected: Bool?
    }
    
    struct Offer: Codable {
        var _id: String?
        var categories: [Category]?
        var currency: String?
        var foodType: Int?
        var discount: Double?
        var discountUpto: Int?
        var avgDeliveryTime: Int?
        var avgOrderPrice: Double?
        var openTime: String?
        var closeTime: String?
        var status: Int?
        var name: String?
        var image: String?
        var outlets: [Outlet]?
        var outletSize: Int?
        var isFavourite: Int?
        var ratingCount: Int?
        var ratings: Double?
    }
}


