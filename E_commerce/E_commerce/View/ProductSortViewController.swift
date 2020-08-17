//
//  ProductSortViewController.swift
//  E_commerce
//
//  Created by Abhishek Mishra on 16/08/20.
//  Copyright © 2020 Abhishek Mishra. All rights reserved.
//

import UIKit

protocol SortProductProtocol{
    func updateView(productRankingEntity: RankingViewModel?)
    func removerSortFilter()
}

class ProductSortViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: ProductSortViewModel?
    var delegate: SortProductProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "productCellID")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
}

extension ProductSortViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.rankingCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCellID") as? ProductTableViewCell
        if indexPath.row == ((viewModel?.rankingCount ?? 0) - 1){
            cell?.productTitle.text = "Show All Product"
        }
        else{
            cell?.setupRankingView(vm: viewModel?.getRankingViewModel(index: indexPath.row))
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == ((viewModel?.rankingCount ?? 0) - 1){
           delegate?.removerSortFilter()
        }
        else{
           delegate?.updateView(productRankingEntity: viewModel?.getRankingViewModel(index: indexPath.row))
        }
        dismiss(animated: true, completion: nil)
    }
}
