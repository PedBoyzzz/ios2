//
//  CollViewController.swift
//  Project18
//
//  Created by Niwat on 28/6/2567 BE.
//

import UIKit

class CollViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let d = data{
            return d.count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "c", for: indexPath) as! Cell
        let walmart = data![indexPath.row]
        URLSession.shared.dataTask(with: NSURL(string: walmart.image)! as URL, completionHandler: { data, response, error in
                    if error != nil {
                        print(error ?? "No Error")
                        return
                    }
            DispatchQueue.main.async {
                if let imageData = data{
                    if let uiImage  = UIImage(data:imageData) {
                        cell.img.image = uiImage
                        }
                    }
                }
        }).resume()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)    {
        print("selecttttt select at \(indexPath.row)")
    }
    
    @IBOutlet weak var jit: UICollectionView!
    var viewMode:ViewModel?
    var data:[Walmart]?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("----- show jit")
        jit.dataSource = self
        jit.delegate = self
        let apiService = ApiService()
        viewMode = ViewModel(apiService: apiService)
        viewMode?.getWalmart(url: "https://fakestoreapiserver.reactbd.com/walmart", params: ["a":"","b":""], result: {it in
            self.data = it
            self.jit.reloadData()
            print("----- result = \(it.count)")
        })
        // Do any additional setup after loading the view.
        
        
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
