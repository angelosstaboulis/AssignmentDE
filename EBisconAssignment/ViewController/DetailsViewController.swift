//
//  DetailsViewController.swift
//  EBisconAssignment
//
//  Created by Angelos Staboulis on 29/2/24.
//

import UIKit
import Alamofire
import RxSwift
import EasyPeasy
import RxRelay
import SDWebImage
class DetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    var viewModel = ProductsViewModel()
    private let disposeBag = DisposeBag()
    var selectedProduct:ProductModel!
    var offLineProduct:SwiftDataProduct!
    var tableView:UITableView!
    let helper = Helper()
    func setupCollectionViewConstraints(){
        tableView = UITableView(frame:CGRect(x: -200, y: 0, width: UIScreen.main.bounds.width+130, height: UIScreen.main.bounds.height))
        tableView.register(ProductCell.self,forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isUserInteractionEnabled = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupCollectionViewConstraints()
        self.navigationItem.title = "Details Screen"

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductCell
        DispatchQueue.main.async{
            if self.helper.isOnline{
                cell.mainImage.sd_setImage(with:URL(string:self.selectedProduct.image))
                cell.titleLabel.text = self.selectedProduct.title
                cell.descriptionLabel.text = self.selectedProduct.description
                cell.textRating.text = String(describing:self.selectedProduct.rating.rate)
                cell.textRatingParenthesis.text = "("+String(describing:self.selectedProduct.rating.count)+" ratings)"
                cell.priceLabel.text =  String(describing:self.selectedProduct.price)
            }else{
                cell.mainImage.sd_setImage(with:URL(string:self.offLineProduct.image))
                cell.titleLabel.text = self.offLineProduct.title
                cell.descriptionLabel.text = self.offLineProduct.descriptionProduct
                cell.textRating.text = String(describing:self.offLineProduct.rating.rate)
                cell.textRatingParenthesis.text = "("+String(describing:self.offLineProduct.rating.count)+" ratings)"
                cell.priceLabel.text =  String(describing:self.offLineProduct.price)
            }
        }
       
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
