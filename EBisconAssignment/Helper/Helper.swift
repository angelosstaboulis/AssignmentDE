//
//  Helper.swift
//  EBisconAssignment
//
//  Created by Angelos Staboulis on 28/2/24.
//

import Foundation
import Alamofire
import RxSwift
import UIKit
import Network
class Helper{
    @Published var isOnline = Bool()
    init(){
        checkOnline()
    }
    func checkOnline(){
        let monitor = NWPathMonitor()
        monitor.start(queue: .main)
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied{
                self!.isOnline = true
            }else{
                self!.isOnline = false
            }
        }
    }
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
