//
//  ProductTableViewCell.swift
//  E_commerce
//
//  Created by Abhishek Mishra on 16/08/20.
//  Copyright © 2020 Abhishek Mishra. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBAction func otherVariantBtnPressed(_ sender: Any) {
        
    }
    
    @IBOutlet weak var productTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView(vm: ProductCellViewModel?){
        productTitle.text = vm?.title ?? "Coming Soon.."
    }
    
    func setupRankingView(vm: RankingViewModel?){
        productTitle.text = vm?.title ?? ""
    }
    
}
