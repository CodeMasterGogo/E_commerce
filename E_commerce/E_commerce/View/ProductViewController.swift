//
//  ProductViewController.swift
//  E_commerce
//
//  Created by Abhishek Mishra on 16/08/20.
//  Copyright © 2020 Abhishek Mishra. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var product: [ProductDataEntity]?
    var viewModel: ProductViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       //TODO Update Coredata Entity with New Data
        if let productEntity = CoreDataManager.shared().fetchRequest(entityName: "ProductDataEntity") as? [ProductDataEntity]{
            if (productEntity.count) > 0{
                product = productEntity
                self.setupView()
            }
            else{
                CoreDataManager.shared().deleteEntity(entityName: "ProductDataEntity")
                NetworkManager().getProductData { (data) in
                    if let data = data{
                        CoreDataManager.shared().prepare(dataForSaving: data)
                    }
                    if let productEntity = CoreDataManager.shared().fetchRequest(entityName: "ProductDataEntity") as? [ProductDataEntity]{
                        if (productEntity.count) > 0{
                            self.product = productEntity
                            self.setupView()
                        }
                    }
                }
            }
        }
        else{
            CoreDataManager.shared().deleteEntity(entityName: "ProductDataEntity")
            NetworkManager().getProductData { (data) in
                if let data = data{
                    CoreDataManager.shared().prepare(dataForSaving: data)
                }
                if let productEntity = CoreDataManager.shared().fetchRequest(entityName: "ProductDataEntity") as? [ProductDataEntity]{
                    if (productEntity.count) > 0{
                        self.product = productEntity
                        self.setupView()
                    }
                }
            }
        }
    }
    
    func setupView(){
        self.navigationItem.title = "Category"
        if let product = product?.first{
          viewModel = ProductViewModel.init(productData: product)
        }
        tableView.register(UINib.init(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "productCellID")
        tableView.reloadData()
    }
    
    @IBAction func sortBtnPressed(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductSortViewID") as? ProductSortViewController
        vc?.delegate = self
        vc?.viewModel = viewModel?.getSortViewModel()
        present(vc!, animated: true, completion: nil)
    }
}

extension ProductViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.categoryCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (viewModel?.getProductObj(section: section)?.count ?? 0) == 0{
            return 1
        }
        return viewModel?.getProductObj(section: section)?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCellID") as? ProductTableViewCell
        cell?.setupView(vm: viewModel?.getProductCellViewModel(section: indexPath.section, index: indexPath.row))
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel?.categoryTitle(index: section) ?? ""
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vm = self.storyboard?.instantiateViewController(withIdentifier: "productDetailViewID") as? ProductDetailViewController
        vm?.viewModel = viewModel?.getProductDetailViewModel(section: indexPath.section, index: indexPath.row)
        self.navigationController?.pushViewController(vm!, animated: true)
    }
}

extension ProductViewController: SortProductProtocol{
    func updateView(productRankingEntity: RankingViewModel?) {
        guard let vm = productRankingEntity else {return}
        viewModel?.getSortedProductData(productRankingVM: vm)
        tableView.reloadData()
    }
    
    func removerSortFilter() {
        viewModel?.removesortfilter()
        tableView.reloadData()
    }
}
