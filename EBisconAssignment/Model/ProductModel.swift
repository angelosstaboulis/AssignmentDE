//
//  ProductModel.swift
//  EBisconAssignment
//
//  Created by Angelos Staboulis on 27/2/24.
//

import Foundation
import SwiftData
class RatingObject:Decodable{
    let rate:Double
    let count:Int
    enum CodingKeys: String, CodingKey {
        case rate = "rate"
        case count = "count"
    }
}
class ProductModel:Decodable{
    let id:Int
    let title:String
    let price:Double
    let description:String
    let category:String
    let image:String
    let rating:RatingObject
    
    enum CodingKeys: String, CodingKey {
      case id = "id"
      case title = "title"
      case price = "price"
      case description = "description"
      case category = "category"
      case image = "image"
      case rating = "rating"
    }
    init(id: Int, title: String, price: Double, description: String, category: String, image: String, rating: RatingObject) {
        self.id = id
        self.title = title
        self.price = price
        self.description = description
        self.category = category
        self.image = image
        self.rating = rating
    }
}

@Model
final class DataProduct {
    var title = ""
    var price = 0.0
    var descriptionProduct = ""
    var category = ""
    var image = ""
    var rate:Double
    var count:Int
    init(title: String = "", price: Double = 0.0, descriptionProduct: String = "", category: String = "", image: String = "", rate: Double, count: Int) {
        self.title = title
        self.price = price
        self.descriptionProduct = descriptionProduct
        self.category = category
        self.image = image
        self.rate = rate
        self.count = count
    }
    
//    init(title: String = "", price: Double = 0.0, descriptionProduct: String = "", category: String = "", image: String = "", rating: SwiftDataRatingProduct) {
//        self.title = title
//        self.price = price
//        self.descriptionProduct = descriptionProduct
//        self.category = category
//        self.image = image
//        self.rating = rating
//    }
//    
}
