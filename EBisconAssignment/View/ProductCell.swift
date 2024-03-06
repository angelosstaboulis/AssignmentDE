//
//  ProductCell.swift
//  EBisconAssignment
//
//  Created by Angelos Staboulis on 29/2/24.
//

import Foundation
import UIKit
import Alamofire
import RxSwift
import EasyPeasy
import RxRelay
import SDWebImage
class ProductCell:UITableViewCell{
    var mainImage:UIImageView = {
        let image = UIImageView(frame: .zero)
        return image
    }()
    var titleLabel:UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
  
    var descriptionLabel:UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    var imageRating:UIImageView = {
        let image = UIImageView(frame: .zero)
        return image
    }()
    var textRating:UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    var textRatingParenthesis:UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    var priceLabel:UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    var ratingView:UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    let helper = Helper()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let image = helper.resizeImage(image: UIImage(named:"rating")!, targetSize: .init(width: 32, height: 32))
        contentView.addSubview(mainImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(imageRating)
        contentView.addSubview(ratingView)
        contentView.addSubview(textRating)
        contentView.addSubview(textRatingParenthesis)
        contentView.addSubview(priceLabel)
        ratingView.addSubview(imageRating)
        ratingView.addSubview(textRating)
        ratingView.addSubview(textRatingParenthesis)
        imageRating.image = image
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        ratingView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 450).isActive = true
        ratingView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 130).isActive = true
        ratingView.widthAnchor.constraint(equalToConstant: 500).isActive = true
        ratingView.heightAnchor.constraint(equalToConstant: 95).isActive = true
        ratingView.sendSubviewToBack(contentView)
        mainImage.translatesAutoresizingMaskIntoConstraints = false
        mainImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 130).isActive = true
        mainImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -130).isActive = true
        mainImage.widthAnchor.constraint(equalToConstant: 145).isActive = true
        mainImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 280).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 130).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 350).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 130).isActive = true
        descriptionLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true

        imageRating.translatesAutoresizingMaskIntoConstraints = false
        imageRating.topAnchor.constraint(equalTo: ratingView.topAnchor, constant: 5).isActive = true
        imageRating.leftAnchor.constraint(equalTo: ratingView.leftAnchor, constant: 115).isActive = true
        imageRating.widthAnchor.constraint(equalToConstant: 32).isActive = true
        imageRating.heightAnchor.constraint(equalToConstant: 32).isActive = true
        textRating.translatesAutoresizingMaskIntoConstraints = false
        textRating.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 440).isActive = true
        textRating.leftAnchor.constraint(equalTo: imageRating.rightAnchor, constant: 25).isActive = true
        textRating.widthAnchor.constraint(equalToConstant: 50).isActive = true
        textRating.heightAnchor.constraint(equalToConstant: 60).isActive = true
        textRatingParenthesis.translatesAutoresizingMaskIntoConstraints = false
        textRatingParenthesis.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 440).isActive = true
        textRatingParenthesis.leftAnchor.constraint(equalTo: textRating.rightAnchor, constant: 25).isActive = true
        textRatingParenthesis.widthAnchor.constraint(equalToConstant: 200).isActive = true
        textRatingParenthesis.heightAnchor.constraint(equalToConstant: 60).isActive = true
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 520).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 50).isActive = true
        priceLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true

    }
    override class func awakeFromNib() {
        
    }
    required init(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
    
}
