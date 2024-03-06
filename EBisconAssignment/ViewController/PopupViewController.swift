//
//  PopupViewController.swift
//  EBisconAssignment
//
//  Created by Angelos Staboulis on 2/3/24.
//

import UIKit
import RxSwift
class PopupViewController: UIViewController,UITableViewDelegate {
    let disposeBag = DisposeBag()
    var tableViewMenu:UITableView!
    var menus:Observable<[String]> = Observable.just(["1","2","3","4","5"])
    fileprivate var btnReset:UIButton = {
        let button = UIButton(frame: .zero)
        button.isUserInteractionEnabled = true
        button.backgroundColor = .white
        button.setTitle("Reset", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    fileprivate var btnDone:UIButton = {
        let button = UIButton(frame: .zero)
        button.isUserInteractionEnabled = true
        button.backgroundColor = .white
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    fileprivate var button1:UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .white
        button.setTitle("American", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    fileprivate var button2:UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .white
        button.setTitle("Turkey", for: .normal)
        button.setTitleColor(.black, for: .normal)

        return button
    }()
    fileprivate var button3:UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .white
        button.setTitle("Asia", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    fileprivate var button4:UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .white
        button.setTitle("Fast Food", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    fileprivate var button5:UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .white
        button.setTitle("Pizza", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    fileprivate var button6:UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .white
        button.setTitle("Desserd", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    fileprivate var button7:UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .white
        button.setTitle("Mexican", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    fileprivate var sortBy:UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .white
        label.text = "Sort By"
        label.textColor = .black
        return label
    }()
    func setupTableView(){
        tableViewMenu = UITableView(frame:.zero)
        tableViewMenu.register(UITableViewCell.self,forCellReuseIdentifier: "cell")
        tableViewMenu.isUserInteractionEnabled = true
        view.addSubview(tableViewMenu)
        tableViewMenu.translatesAutoresizingMaskIntoConstraints = false
        tableViewMenu.topAnchor.constraint(equalTo: view.topAnchor, constant: 350).isActive = true
        tableViewMenu.leftAnchor.constraint(equalTo: view.leftAnchor, constant:-300).isActive = true
        tableViewMenu.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 300).isActive = true
        tableViewMenu.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 1200).isActive = true
        view.addSubview(btnReset)
        view.addSubview(btnDone)
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(button3)
        view.addSubview(button4)
        view.addSubview(button5)
        view.addSubview(button6)
        view.addSubview(button7)
        view.addSubview(sortBy)
        btnReset.translatesAutoresizingMaskIntoConstraints = false
        btnReset.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        btnReset.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        btnReset.widthAnchor.constraint(equalToConstant: 90).isActive = true
        btnReset.heightAnchor.constraint(equalToConstant: 65).isActive = true
        btnDone.translatesAutoresizingMaskIntoConstraints = false
        btnDone.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        if UIDevice.current.userInterfaceIdiom == .pad{
            btnDone.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIScreen.main.bounds.width - 200).isActive = true
        }else{
            btnDone.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIScreen.main.bounds.width - 120).isActive = true
        }
        btnDone.widthAnchor.constraint(equalToConstant: 90).isActive = true
        btnDone.heightAnchor.constraint(equalToConstant: 65).isActive = true
        btnReset.addTarget(self, action: #selector(btnReset(sender:)), for: .touchUpInside)
        btnDone.addTarget(self, action: #selector(btnDone(sender:)), for: .touchUpInside)
        button1.translatesAutoresizingMaskIntoConstraints = false
        button1.translatesAutoresizingMaskIntoConstraints = false
        button1.topAnchor.constraint(equalTo: view.topAnchor, constant: 130).isActive = true
        button1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        button1.widthAnchor.constraint(equalToConstant: 90).isActive = true
        button1.heightAnchor.constraint(equalToConstant: 65).isActive = true
        button1.translatesAutoresizingMaskIntoConstraints = false
        
        button2.translatesAutoresizingMaskIntoConstraints = false
        button2.topAnchor.constraint(equalTo: view.topAnchor, constant: 130).isActive = true
        button2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 110).isActive = true
        button2.widthAnchor.constraint(equalToConstant: 90).isActive = true
        button2.heightAnchor.constraint(equalToConstant: 65).isActive = true
        button2.translatesAutoresizingMaskIntoConstraints = false
        
        button3.translatesAutoresizingMaskIntoConstraints = false
        button3.topAnchor.constraint(equalTo: view.topAnchor, constant: 130).isActive = true
        button3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 198).isActive = true
        button3.widthAnchor.constraint(equalToConstant: 90).isActive = true
        button3.heightAnchor.constraint(equalToConstant: 65).isActive = true
        button3.translatesAutoresizingMaskIntoConstraints = false
        
        
        button4.translatesAutoresizingMaskIntoConstraints = false
        button4.topAnchor.constraint(equalTo: view.topAnchor, constant: 130).isActive = true
        button4.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 290).isActive = true
        button4.widthAnchor.constraint(equalToConstant: 90).isActive = true
        button4.heightAnchor.constraint(equalToConstant: 65).isActive = true
        button4.translatesAutoresizingMaskIntoConstraints = false
        
        button5.translatesAutoresizingMaskIntoConstraints = false
        button5.topAnchor.constraint(equalTo: view.topAnchor, constant: 210).isActive = true
        button5.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        button5.widthAnchor.constraint(equalToConstant: 90).isActive = true
        button5.heightAnchor.constraint(equalToConstant: 65).isActive = true
        button5.translatesAutoresizingMaskIntoConstraints = false
        
        button6.translatesAutoresizingMaskIntoConstraints = false
        button6.topAnchor.constraint(equalTo: view.topAnchor, constant: 210).isActive = true
        button6.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 105).isActive = true
        button6.widthAnchor.constraint(equalToConstant: 90).isActive = true
        button6.heightAnchor.constraint(equalToConstant: 65).isActive = true
        button6.translatesAutoresizingMaskIntoConstraints = false
        
        button7.translatesAutoresizingMaskIntoConstraints = false
        button7.topAnchor.constraint(equalTo: view.topAnchor, constant: 210).isActive = true
        button7.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 195).isActive = true
        button7.widthAnchor.constraint(equalToConstant: 90).isActive = true
        button7.heightAnchor.constraint(equalToConstant: 65).isActive = true
        button7.translatesAutoresizingMaskIntoConstraints = false
        
        sortBy.translatesAutoresizingMaskIntoConstraints = false
        sortBy.topAnchor.constraint(equalTo: view.topAnchor, constant: 290).isActive = true
        sortBy.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        sortBy.widthAnchor.constraint(equalToConstant: 90).isActive = true
        sortBy.heightAnchor.constraint(equalToConstant: 45).isActive = true
        sortBy.translatesAutoresizingMaskIntoConstraints = false
        
        button1.layer.borderWidth = 1
        button1.layer.cornerRadius = 22
        button1.layer.borderColor = UIColor.black.cgColor
        button2.layer.borderWidth = 1
        button2.layer.cornerRadius = 22
        button2.layer.borderColor = UIColor.black.cgColor
        button3.layer.borderWidth = 1
        button3.layer.cornerRadius = 22
        button3.layer.borderColor = UIColor.black.cgColor
        button4.layer.borderWidth = 1
        button4.layer.cornerRadius = 22
        button4.layer.borderColor = UIColor.black.cgColor
        button5.layer.borderWidth = 1
        button5.layer.cornerRadius = 22
        button5.layer.borderColor = UIColor.black.cgColor
        button6.layer.borderWidth = 1
        button6.layer.cornerRadius = 22
        button6.layer.borderColor = UIColor.black.cgColor
        button7.layer.borderWidth = 1
        button7.layer.cornerRadius = 22
        button7.layer.borderColor = UIColor.black.cgColor
        
    }
    
    @objc func btnReset(sender:UIBarButtonItem){
        self.dismiss(animated: true)
    }
    @objc func btnDone(sender:UIBarButtonItem){
        self.dismiss(animated: true)
    }
    var viewModel = ProductsViewModel()
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        tableViewMenu.register(PopupCell.self,forCellReuseIdentifier: "cell")
        tableViewMenu.rx.setDelegate(self).disposed(by: disposeBag)

         viewModel.createMenu()
        .observe(on: MainScheduler.instance)
        .bind(to: tableViewMenu.rx.items(cellIdentifier: "cell", cellType: PopupCell.self)) { (row, product: String, cell) in
            cell.titleLabel.text =  product
        }.disposed(by: disposeBag)
        // Do any additional setup after loading the view.
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
