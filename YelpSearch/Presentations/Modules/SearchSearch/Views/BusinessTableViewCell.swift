//
//  BusinessTableViewCell.swift
//  YelpSearch
//
//  Created by Lucio on 29/07/2022.
//

import UIKit
import Kingfisher

class BusinessTableViewCell: UITableViewCell {
    @IBOutlet fileprivate weak var businessImageView: UIImageView!
    @IBOutlet fileprivate weak var businessNameLabel: UILabel!
    @IBOutlet fileprivate weak var businessRatingLabel: UILabel!
    @IBOutlet fileprivate weak var businessPhoneNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareUI()
    }
    
    func bind(_ viewModel: BusinessCellViewModel) {
        self.businessImageView.kf.setImage(with: viewModel.imageUrl)
        self.businessNameLabel.text = viewModel.name
        self.businessRatingLabel.text = viewModel.rating
        self.businessPhoneNumberLabel.text = viewModel.phoneNumber
    }
    
    fileprivate func prepareUI() {
        selectionStyle = .none
        businessImageView.backgroundColor = .gray.withAlphaComponent(0.5)
        businessImageView.layer.cornerRadius = 8.0
    }
    
}
