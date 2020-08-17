//
//  ProductSortViewModel.swift
//  E_commerce
//
//  Created by Abhishek Mishra on 16/08/20.
//  Copyright © 2020 Abhishek Mishra. All rights reserved.
//

import Foundation

struct ProductSortViewModel {
    var rankings: [RankingEntity]?
    
    init(rankings: [RankingEntity]?) {
        self.rankings = rankings
    }
    
    var rankingCount: Int{
        return rankings?.count ?? 0
    }
    
    func getRankingViewModel(index: Int) -> RankingViewModel{
        return RankingViewModel.init(ranking: rankings?[index])
    }
}

struct RankingViewModel {
    var ranking: RankingEntity?
    
    init(ranking: RankingEntity?) {
        self.ranking = ranking
    }
    
    var title: String {
        return ranking?.rankingType ?? ""
    }
    
    var rankingArr: [ProductRankingEntity]?{
        return (ranking?.rankingArr?.allObjects as? [ProductRankingEntity])
    }
    
}


