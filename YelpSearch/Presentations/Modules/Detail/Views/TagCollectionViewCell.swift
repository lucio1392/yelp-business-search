//
//  TagCollectionViewCell.swift
//  YelpSearch
//
//  Created by Lucio on 30/07/2022.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {

    @IBOutlet fileprivate weak var tagNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
    }
    
    func bind(_ title: String) {
        self.tagNameLabel.text = title
    }

}
