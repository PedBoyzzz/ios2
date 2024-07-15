//
//  ApiService.swift
//  Project18
//
//  Created by Niwat on 28/6/2567 BE.
//

import Foundation
import Alamofire
class ApiService:ApiPattern{
    func getWalmart(url:String,params:[String:String],result:@escaping([Walmart])->()){
        AF.request(url).response { response in
            /*
            do {
                let r = try JSONDecoder().decode([Walmart].self, from:response.data!)
                result(r)
            }
            catch {
                print("error ")
            }
            */
            
            /*switch response.result {
                case .success:
                    if let d = response.data {
                        do {
                            let r = try JSONDecoder().decode([Walmart].self, from:d)
                            result(r)
                        }
                        catch {
                            print("error ")
                        }
                    }
                //let resJSON = JSON(response.value)
                case .failure(let error):
                    print("Error:", error)
            }
             */
            
            switch(response.result){
                case .success(let d):
                    print("------- success1")
                    do {
                        let r = try JSONDecoder().decode([Walmart].self, from:d!)
                        result(r)
                    }
                    catch {
                        print("error ")
                    }
                case .failure(let error):
                    print("------- error \(error)")
                /*case .success:
                    print("------- success2")
                    print("")*/
            }
        }
    }
}

