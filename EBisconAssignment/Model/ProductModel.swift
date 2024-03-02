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
}
@Model
class SwiftDataRatingProduct{
    @Relationship(inverse: \SwiftDataProduct.rating) var rating: SwiftDataRatingProduct?
    var rate:Double
    var count:Int
    init(rate: Double, count: Int) {
        self.rate = rate
        self.count = count
    }
}

@Model
class SwiftDataProduct {
    var title = ""
    var price = 0.0
    var descriptionProduct = ""
    var category = ""
    var image = ""
    var rating: SwiftDataRatingProduct

    
    init(title: String = "", price: Double = 0.0, descriptionProduct: String = "", category: String = "", image: String = "", rating: SwiftDataRatingProduct) {
        self.title = title
        self.price = price
        self.descriptionProduct = descriptionProduct
        self.category = category
        self.image = image
        self.rating = rating
    }
    
}
