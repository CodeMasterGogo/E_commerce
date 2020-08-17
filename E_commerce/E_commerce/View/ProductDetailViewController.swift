//
//  ProductDetailViewController.swift
//  E_commerce
//
//  Created by Abhishek Mishra on 16/08/20.
//  Copyright © 2020 Abhishek Mishra. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var productTitle: UILabel!
    
    var viewModel: ProductDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "ProductDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "productDetailCellID")
        self.navigationItem.title = "Product Detail"
        productTitle.text = viewModel?.title ?? ""
        tableView.reloadData()
    }

}


extension ProductDetailViewController: UITableViewDelegate, UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.totalVarient ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productDetailCellID") as? ProductDetailTableViewCell
        cell?.setupView(vm: viewModel?.getCellViewModel(index: indexPath.row))
        return cell!
    }
}
