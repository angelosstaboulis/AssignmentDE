//
//  PopupCell.swift
//  EBisconAssignment
//
//  Created by Angelos Staboulis on 2/3/24.
//

import Foundation
import UIKit
class PopupCell:UITableViewCell{
   
    var titleLabel:UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
  
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 130).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        

    }
    override class func awakeFromNib() {
        
    }
    required init(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
    
}
