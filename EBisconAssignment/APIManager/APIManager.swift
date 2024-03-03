//
//  APIManager.swift
//  EBisconAssignment
//
//  Created by Angelos Staboulis on 29/2/24.
//

import Foundation
import Alamofire
import RxSwift
class APIManager{
    static let shared = APIManager()
    private init(){}
    func getAPIProducts(onSuccess:@escaping ([ProductModel])->(),onFail:@escaping (Int)->Void)  {
        AF.request("https://fakestoreapi.com/products/")
            .response { response in
                switch response.result {
                case .success(let data):
                    do {
                        let products = try JSONDecoder().decode([ProductModel].self, from: data!)
                        onSuccess(products)
                    } catch {
                        debugPrint("something went wrong with products!!!!")
                        onFail(-1000)
                    }
                case .failure(let error):
                    debugPrint("something went wrong!!!!",error.localizedDescription)
                    onFail(-1000)

                }
            }.resume()
    }
}
