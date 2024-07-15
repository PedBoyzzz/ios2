//
//  ApiPattern.swift
//  Project18
//
//  Created by Niwat on 28/6/2567 BE.
//

import Foundation
protocol ApiPattern{
    func getWalmart(url:String,params:[String:String],result:@escaping([Walmart])->())
}
