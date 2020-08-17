//
//  ProductDetailTableViewCell.swift
//  E_commerce
//
//  Created by Abhishek Mishra on 16/08/20.
//  Copyright © 2020 Abhishek Mishra. All rights reserved.
//

import UIKit

class ProductDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupView(vm: ProductDetailCellViewModel?){
        colorLabel.text = vm?.color ?? ""
        sizeLabel.text = vm?.size ?? ""
        priceLabel.text = vm?.priceLabelValue ?? ""
    }
}
