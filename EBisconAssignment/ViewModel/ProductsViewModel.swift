//
//  ProductsViewModel.swift
//  EBisconAssignment
//
//  Created by Angelos Staboulis on 28/2/24.
//

import Foundation
import UIKit
import Alamofire
import RxSwift
import RxRelay
import SwiftData
@MainActor
class ProductsViewModel{
    var apishared:APIManager
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let disposeBag = DisposeBag()
    var container:ModelContainer!
    init() {
        apishared = APIManager.shared
        do{
            container = try ModelContainer(for: SwiftDataProduct.self)
        }catch{
            debugPrint("something went wrong")
        }
    }
    
    func insert(product:SwiftDataProduct){
        do{
            let newItem = SwiftDataProduct(title: product.title, price: product.price, descriptionProduct: product.descriptionProduct, category: product.category, image: product.image, rating:.init(rate: 0.0, count:0))
            container.mainContext.insert(newItem)
            try container.mainContext.save()
        }catch{
            debugPrint("something went wrong!!!!")
        }
    }
    func fetchSwiftDataProducts()->Observable<[SwiftDataProduct]>{
        return Observable.create { observer -> Disposable in
            let descriptor = FetchDescriptor<SwiftDataProduct>()
            let products = (try? self.container?.mainContext.fetch(descriptor)) ?? []
            observer.onNext(products)
            return Disposables.create()
        }
    }
    func saveOffLineProducts(){
        self.apishared.getAPIProducts { productsArray in
            Task{
                for product in 0..<productsArray.count{
                    let swiftDataRating = SwiftDataRatingProduct(rate: productsArray[product].rating.rate, count: productsArray[product].rating.count)
                    let swiftData = SwiftDataProduct(title: productsArray[product].title, price: productsArray[product].price, descriptionProduct: productsArray[product].description, category: productsArray[product].category, image: productsArray[product].image, rating:swiftDataRating)
                        self.insert(product: swiftData)
                    
                    
                }
            }
        } onFail: { value in
            debugPrint("saveOfflineProducts=",value)
        }
    }
  
    func getProducts()->Observable<[ProductModel]>{
        return Observable.create { observer -> Disposable in
            self.apishared.getAPIProducts { productsArray in
                observer.onNext(productsArray)
            } onFail: { value in
                debugPrint("something went wrong=",value)
            }
            
            return Disposables.create()
        }
    }

    func createMenu()->Observable<[String]>{
        return Observable.create { observer -> Disposable in
            observer.onNext(["Top Rated","Nearest to me","Cost High to Low ","Cost Low to High"])
            return Disposables.create()
        }
    }
}
