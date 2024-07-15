//
//  DetailsViewController.swift
//  Project18
//
//  Created by Niwat on 28/6/2567 BE.
//

import UIKit

class DetailsViewController: UIViewController {
    var walmart:Walmart?
    
    @IBOutlet weak var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("----walmart title = \(walmart?.title)")
        // Do any additional setup after loading the view.
        if let uWalmart = walmart{
            URLSession.shared.dataTask(with: NSURL(string: uWalmart.image)! as URL, completionHandler: { data, response, error in
                        if error != nil {
                            print(error ?? "No Error")
                            return
                        }
                DispatchQueue.main.async {
                    if let imageData = data{
                        if let uiImage  = UIImage(data:imageData) {
                            self.img.image = uiImage
                        }
                    }
                }
            }).resume()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
