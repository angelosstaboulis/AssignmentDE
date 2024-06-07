import UIKit
import Alamofire
import RxSwift
import EasyPeasy
import RxRelay
import SDWebImage
import RxCocoa
class ViewController: UIViewController{
    var viewModel = ProductsViewModel()
    private let disposeBag = DisposeBag()
    fileprivate var tableView:UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 400
        return tableView
    }()
    fileprivate var tableStackView:UIStackView = {
        let view = UIStackView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let sectionHeaderLabel = UILabel(frame:.zero)
    let searchField = UITextField(frame:.zero)
    let btnFilter = UIButton(frame: .zero)
    let sectionHeaderLabelView = UIStackView(arrangedSubviews: [])
    let pullRefresh = UIRefreshControl()
    let helper = Helper()
    var productsSwift:[DataProduct] = []
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200.0
    }
    func createHeaderComponents(){
        sectionHeaderLabel.text = "Discover New Places"
        sectionHeaderLabel.textColor = .brown
        sectionHeaderLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        searchField.textColor = UIColor.black
        searchField.font = UIFont.systemFont(ofSize: 12)
        searchField.placeholder = "Search Text"
        btnFilter.setImage(UIImage(named:"filter"), for: .normal)
        btnFilter.addTarget(self, action: #selector(btnOpenPopup(sender:)), for: .allEvents)
        sectionHeaderLabelView.addArrangedSubview(searchField)
        sectionHeaderLabelView.addArrangedSubview(sectionHeaderLabel)
        sectionHeaderLabelView.addArrangedSubview(btnFilter)
        sectionHeaderLabelView.frame = CGRect(x: 0, y: 0, width: 900, height: 400)
        sectionHeaderLabelView.axis = .vertical
        sectionHeaderLabelView.alignment = .leading
        sectionHeaderLabelView.spacing = 5
        sectionHeaderLabelView.distribution = .fillProportionally
        sectionHeaderLabelView.sendSubviewToBack(tableView)
    }
    func createHeaderConstraints(){
        sectionHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        sectionHeaderLabel.topAnchor.constraint(equalTo: sectionHeaderLabelView.topAnchor, constant: 160).isActive = true
        sectionHeaderLabel.leftAnchor.constraint(equalTo: sectionHeaderLabelView.leftAnchor, constant: (UIScreen.main.bounds.width / 2.0)+200).isActive = true
        sectionHeaderLabel.widthAnchor.constraint(equalToConstant: 600).isActive = true
        sectionHeaderLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
        btnFilter.translatesAutoresizingMaskIntoConstraints = false
        btnFilter.topAnchor.constraint(equalTo: sectionHeaderLabelView.topAnchor, constant: 90).isActive = true
        btnFilter.leftAnchor.constraint(equalTo: sectionHeaderLabelView.leftAnchor, constant: (UIScreen.main.bounds.width / 2.0)+300).isActive = true
        btnFilter.widthAnchor.constraint(equalToConstant: 120).isActive = true
        btnFilter.heightAnchor.constraint(equalToConstant: 45).isActive = true
        searchField.translatesAutoresizingMaskIntoConstraints = false
        searchField.topAnchor.constraint(equalTo: sectionHeaderLabelView.topAnchor, constant: 140).isActive = true
        searchField.leftAnchor.constraint(equalTo: sectionHeaderLabelView.leftAnchor, constant: (UIScreen.main.bounds.width / 2.0)+190).isActive = true
        searchField.widthAnchor.constraint(equalToConstant: 120).isActive = true
        searchField.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    func createHeaderView()->UIView{

       createHeaderComponents()
        
       createHeaderConstraints()
    
       return sectionHeaderLabelView
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return createHeaderView()
    }
    func setupTableViewConstraints(){
        self.view.addSubview(tableView)
        self.view.addSubview(tableStackView)
        self.navigationItem.title = "Assignment"
        tableStackView.translatesAutoresizingMaskIntoConstraints = false
        tableStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: -150).isActive = true
        tableStackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 300).isActive = true
        tableStackView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 300).isActive = true
        tableView.isUserInteractionEnabled = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant:-150).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 300).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 300).isActive = true
        pullRefresh.attributedTitle = NSAttributedString(string: "Pull to refresh")
        tableStackView.axis = .vertical
        tableStackView.alignment = .center
        tableStackView.distribution = .fillEqually
        tableStackView.spacing = 10
        tableStackView.addArrangedSubview(tableView)
        
        
        
        
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
    func createMainList(){
        tableView.register(ProductCell.self,forCellReuseIdentifier: "cell")
        setupTableViewConstraints()
        tableView.becomeFirstResponder()
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        offLineUse()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        createMainList()
        
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
                    .bind(to: self.tableView.rx.items(cellIdentifier: "cell", cellType: ProductCell.self)) { (row:Int, product: DataProduct, cell:ProductCell) in
                        cell.mainImage.sd_setImage(with: URL(string:product.image))
                        cell.titleLabel.text = product.title
                        cell.descriptionLabel.text = product.descriptionProduct
                        cell.textRating.text = String(describing:product.rate)
                        cell.textRatingParenthesis.text = "(" + String(describing: product.count) + " ratings)"
                        cell.priceLabel.text = String(describing:product.price)
                        
                    }.disposed(by: self.disposeBag)
                self.tableView.rx.modelSelected(DataProduct.self)
                    .observe(on: MainScheduler.instance)
                    .subscribe { item in
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let details:DetailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
                        details.offLineProduct = item as DataProduct
                        details.modalPresentationStyle = .fullScreen
                        self.navigationController?.pushViewController(details, animated: true)
                    }.disposed(by: self.disposeBag)
            }
        }
        
    }
    
    
}
extension ViewController:UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
}
extension ViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600.0
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600.0
    }
}
