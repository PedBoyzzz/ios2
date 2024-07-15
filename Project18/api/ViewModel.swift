//
//  ViewModel.swift
//  Project18
//
//  Created by Niwat on 28/6/2567 BE.
//

import Foundation
class ViewModel{
    var apiService:ApiService
    init(apiService:ApiService){
        self.apiService = apiService
    }
    func getWalmart(url:String,params:[String:String],result:@escaping([Walmart])->()){
        self.apiService.getWalmart(url: url, params: params, result: result)
    }
}
