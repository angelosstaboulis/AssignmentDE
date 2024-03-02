//
//  ViewController.swift
//  EBisconAssignment
//
//  Created by Angelos Staboulis on 26/2/24.
//

import UIKit
import Alamofire
import RxSwift
import EasyPeasy
import RxRelay
import SDWebImage
import RxCocoa
class ViewController: UIViewController,UITableViewDelegate,UITextFieldDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600.0
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600.0
    }
    var viewModel = ProductsViewModel()
    private let disposeBag = DisposeBag()
    fileprivate var tableView:UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 400
        return tableView
    }()
    fileprivate var mainTitle:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 30)
        label.text = "Discover New Places"
        return label
    }()
    fileprivate var searchField:UITextField = {
        let textField = UITextField()
        
        textField.textColor = UIColor.black
        textField.font = UIFont.systemFont(ofSize: 12)
        textField.placeholder = "Search Text"
        return textField
    }()
    fileprivate var btnSearch:UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .white
        button.setImage(UIImage(named:"filter"), for: .normal)
        return button
    }()
    let pullRefresh = UIRefreshControl()
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
    let helper = Helper()
    var productsSwift:[SwiftDataProduct] = []

    func setupCollectionViewConstraints(){
        self.view.addSubview(tableView)
        self.view.addSubview(mainTitle)
        self.view.addSubview(searchField)
        self.view.addSubview(btnSearch)
        searchField.delegate = self
        tableView.isUserInteractionEnabled = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant:-300).isActive = true
        
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 300).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 300).isActive = true
        pullRefresh.attributedTitle = NSAttributedString(string: "Pull to refresh")
        pullRefresh.addTarget(self, action: #selector(makeRefresh(_:)), for: .valueChanged)
        tableView.addSubview(pullRefresh)
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        mainTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: -300).isActive = true
        
        mainTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant:UIScreen.main.bounds.width / 2).isActive = true
        mainTitle.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 300).isActive = true
        mainTitle.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 60).isActive = true
        searchField.translatesAutoresizingMaskIntoConstraints = false
        searchField.topAnchor.constraint(equalTo: view.topAnchor, constant: -350).isActive = true
        searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:30).isActive = true
        searchField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -200).isActive = true
        searchField.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 60).isActive = true
        
        btnSearch.translatesAutoresizingMaskIntoConstraints = false
        btnSearch.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
        btnSearch.leftAnchor.constraint(equalTo: view.rightAnchor, constant: -155).isActive = true
        btnSearch.widthAnchor.constraint(equalToConstant: 100).isActive = true
        btnSearch.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btnSearch.addTarget(self, action: #selector(btnOpenPopup(sender:)), for: .allEvents)
    }
    @objc func btnOpenPopup(sender:UIButton){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "PopupViewController") as! PopupViewController
        
        controller.providesPresentationContextTransitionStyle = true
        controller.definesPresentationContext = true
        controller.modalPresentationStyle = .pageSheet
        self.navigationController?.present(controller, animated: true)
        
    }
    @objc func makeRefresh(_ sender: Any) {
        tableView.reloadData()
        pullRefresh.endRefreshing()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ProductCell.self,forCellReuseIdentifier: "cell")
        setupCollectionViewConstraints()

        tableView.becomeFirstResponder()
        tableView.rx.setDelegate(self).disposed(by: disposeBag)

        offLineUse()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    func offLineUse(){
        DispatchQueue.main.async{
            if self.helper.isOnline {
                Task{
                    self.viewModel.saveOffLineProducts()
                }
                self.viewModel.getProducts()
                    .observe(on: MainScheduler.instance)
                    .bind(to: self.tableView.rx.items(cellIdentifier: "cell", cellType: ProductCell.self)) { (row, product: ProductModel, cell) in
                        cell.mainImage.sd_setImage(with: URL(string:product.image))
                        cell.titleLabel.text = product.title
                        cell.descriptionLabel.text = product.description
                        cell.textRating.text = String(describing:product.rating.rate)
                        cell.textRatingParenthesis.text = "(" + String(describing: product.rating.count) + " ratings)"
                        cell.priceLabel.text = String(describing:product.price)
                        
                    }.disposed(by: self.disposeBag)
                self.tableView.rx.modelSelected(ProductModel.self)
                    .observe(on: MainScheduler.instance)
                    .subscribe { item in
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let details:DetailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
                        details.selectedProduct = item as ProductModel
                        details.modalPresentationStyle = .fullScreen
                        self.navigationController?.pushViewController(details, animated: true)
                    }.disposed(by: self.disposeBag)
                
            }else{
                self.viewModel
                    .fetchSwiftDataProducts()
                    .bind(to: self.tableView.rx.items(cellIdentifier: "cell", cellType: ProductCell.self)) { (row:Int, product: SwiftDataProduct, cell:ProductCell) in
                        cell.mainImage.sd_setImage(with: URL(string:product.image))
                        cell.titleLabel.text = product.title
                        cell.descriptionLabel.text = product.descriptionProduct
                        cell.textRating.text = String(describing:product.rating.rate)
                        cell.textRatingParenthesis.text = "(" + String(describing: product.rating.count) + " ratings)"
                        cell.priceLabel.text = String(describing:product.price)
                        
                    }.disposed(by: self.disposeBag)
                self.tableView.rx.modelSelected(SwiftDataProduct.self)
                    .observe(on: MainScheduler.instance)
                    .subscribe { item in
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let details:DetailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
                        details.offLineProduct = item as SwiftDataProduct
                        details.modalPresentationStyle = .fullScreen
                        self.navigationController?.pushViewController(details, animated: true)
                    }.disposed(by: self.disposeBag)
            }
        }
            
    }


}

