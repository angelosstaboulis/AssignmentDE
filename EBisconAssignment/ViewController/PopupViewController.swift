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
    var top:Int!=150
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
    var menusText:[String] = ["American","Turkey","Asia","Fast Food","Pizza","Desserd","Mexican"]
    var buttons:[UIButton] = [UIButton(frame: .zero),UIButton(frame: .zero),UIButton(frame: .zero),UIButton(frame: .zero),UIButton(frame: .zero),UIButton(frame: .zero),UIButton(frame: .zero)]
    fileprivate var sortBy:UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .white
        label.text = "Sort By"
        label.textColor = .black
        return label
    }()
    func createButtonsConstraints(arrayItem:Int,buttons:[UIButton]){
        buttons[arrayItem].translatesAutoresizingMaskIntoConstraints = false
        if arrayItem < 3 {
            buttons[arrayItem].topAnchor.constraint(equalTo: view.topAnchor, constant: CGFloat(top)).isActive = true
            buttons[arrayItem].leftAnchor.constraint(equalTo: view.leftAnchor, constant: CGFloat(arrayItem*120)).isActive = true
            buttons[arrayItem].widthAnchor.constraint(equalToConstant: 120).isActive = true
        }else if arrayItem>=3 && arrayItem<6{
            buttons[arrayItem].topAnchor.constraint(equalTo: view.topAnchor, constant: CGFloat(top+70)).isActive = true
            buttons[arrayItem].leftAnchor.constraint(equalTo: view.leftAnchor, constant: CGFloat(arrayItem*120)-360).isActive = true
            buttons[arrayItem].widthAnchor.constraint(equalToConstant: 120).isActive = true
        }else if arrayItem==6{
            buttons[arrayItem].topAnchor.constraint(equalTo: view.topAnchor, constant: CGFloat(top+140)).isActive = true
            buttons[arrayItem].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(arrayItem*120)-715).isActive = true
            buttons[arrayItem].widthAnchor.constraint(equalToConstant: 120).isActive = true
        }
    }
    func createButtons(){
        for item in 0..<menusText.count{
            buttons[item].setTitle(menusText[item], for: .normal)
            buttons[item].setTitleColor(.black, for: .normal)
            buttons[item].layer.borderWidth = 1
            buttons[item].layer.cornerRadius = 22
            buttons[item].layer.borderColor = UIColor.black.cgColor
            view.addSubview(buttons[item])
            createButtonsConstraints(arrayItem: item, buttons: buttons)
        }
    }
    func createTopMenu(){
        view.addSubview(btnReset)
        view.addSubview(btnDone)
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
    }
    func setupTableView(){
        createButtons()
        createTopMenu()
        tableViewMenu = UITableView(frame:.zero)
        tableViewMenu.register(UITableViewCell.self,forCellReuseIdentifier: "cell")
        tableViewMenu.isUserInteractionEnabled = true
        view.addSubview(tableViewMenu)
        tableViewMenu.translatesAutoresizingMaskIntoConstraints = false
        tableViewMenu.topAnchor.constraint(equalTo: view.topAnchor, constant: 380).isActive = true
        tableViewMenu.leftAnchor.constraint(equalTo: view.leftAnchor, constant:-300).isActive = true
        tableViewMenu.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 300).isActive = true
        tableViewMenu.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 1200).isActive = true
        view.addSubview(sortBy)
       
        
        sortBy.translatesAutoresizingMaskIntoConstraints = false
        sortBy.topAnchor.constraint(equalTo: view.topAnchor, constant: 350).isActive = true
        sortBy.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        sortBy.widthAnchor.constraint(equalToConstant: 90).isActive = true
        sortBy.heightAnchor.constraint(equalToConstant: 45).isActive = true
        sortBy.translatesAutoresizingMaskIntoConstraints = false
        
      
        
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
    func createList(){
        tableViewMenu.register(PopupCell.self,forCellReuseIdentifier: "cell")
        tableViewMenu.rx.setDelegate(self).disposed(by: disposeBag)

         viewModel.createMenu()
        .observe(on: MainScheduler.instance)
        .bind(to: tableViewMenu.rx.items(cellIdentifier: "cell", cellType: PopupCell.self)) { (row, product: String, cell) in
            cell.titleLabel.text =  product
        }.disposed(by: disposeBag)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        createList()
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
