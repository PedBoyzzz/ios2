//
//  ViewController.swift
//  Project18
//
//  Created by Niwat on 28/6/2567 BE.
//

import UIKit
import Kingfisher
import SDWebImage
import Alamofire
import AlamofireImage
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBAction func six(_ sender: Any) {
        print("-----six me")
        performSegue(withIdentifier: "dt2", sender: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let d = self.data{
            return d.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "c2", for: indexPath) as! Cell2
        cell.selectionStyle = .none
        let walmart = self.data![indexPath.row]
        cell.title.text = walmart.title
        cell.price.text = walmart.price
        let boldText:String = walmart.title
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        cell.title.attributedText = attributedString
        let str:String? = "Niwat"
    
        cell.price.numberOfLines = 0
        cell.des.text = /*str*/walmart.des
        cell.des.numberOfLines = 0
        /*
        cell.img.sd_setImage(with: URL(string:walmart.image),placeholderImage:nil)
        cell.img.layer.cornerRadius = cell.img.frame.height/2
        cell.img.clipsToBounds = true
        */
        /*
        let url = URL(string: walmart.image)!
        cell.img.af.setImage(withURL: url)
        cell.img.layer.cornerRadius = 10 // Set it how you prefer
        cell.img.layer.masksToBounds = true
        */
        /*
        let url = URL(string: walmart.image)!
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url) {
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                cell.img.image = image
                                //print("iw = \(image.size.width) ih = \(image.size.height)")
                            }
                        }
                }
        }
        */
        /*
        downloadImage(urlString: walmart.image, call: {it in
            imageCache.setObject(it, forKey: walmart.image as NSString)
            cell.img.image = it
        })
        */
        
        
        cell.img.loadImageUsingCacheWithUrlString(walmart.image)
        
        
        
        
        /*if let cachedImage = imageCache.object(forKey: walmart.image as NSString) as? UIImage {
            cell.img.image = cachedImage
        }else{
            let url = URL(string: walmart.image)
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                if let error = error {
                    print(error)
                    return
                }
                DispatchQueue.main.async{
                    if let downloadedImage = UIImage(data: data!) {
                        imageCache.setObject(downloadedImage, forKey: walmart.image as NSString)
                        cell.img.image = downloadedImage
                    }
                }
            }).resume()
            /*downloadImage(urlString: walmart.image, call: {it,url in
                if walmart.image == url{
                    imageCache.setObject(it, forKey: walmart.image as NSString)
                    cell.img.image = it
                }
            })*/
        }*/
        
       
        /*
        let url = URL(string: walmart.image)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            DispatchQueue.main.async(execute: {
                if let downloadedImage = UIImage(data: data!) {
                    cell.img.image = downloadedImage
                }
            })
        }).resume()
         */
         

        /*
        //TDed
        let url = URL(string: walmart.image)
        cell.img.kf.setImage(with: url)
        cell.img.layer.cornerRadius = 10 // Set it how you prefer
        cell.img.layer.masksToBounds = true
        */
        
        //cell.img.load2(urlString: walmart.image)
        //cell.img.load(urlString: walmart.image)
        
        //AF
        
        /*if let image = imageCat.image(withIdentifier: walmart.image){
            cell.img.image = image
        }else{
            cell.img.image = nil
        }*/
        return cell
    }
    func downloadImage(urlString:String,call:@escaping(UIImage,String)->()){
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            DispatchQueue.main.async(execute: {
                if let downloadedImage = UIImage(data: data!) {
                    call(downloadedImage,urlString)
                }
            })
        }).resume()
    }
    func loadImages(){
        for d in data!{
            AF.request( d.image,method: .get).response{ response in
                switch response.result {
                    case .success(let responseData):
                        let image = UIImage(data: responseData!, scale: 1.0)!
                        self.imageCat.add(image, withIdentifier:d.image)
                        DispatchQueue.main.async{
                            self.tb.reloadData()
                        }
                    case .failure(let error):
                        print("error--->",error)
                    }
                
            }
            /*AF.request(d.image).responseImage { [self] response in
                if response.data != nil {
                    let image = UIImage(data: response.data!, scale: 1.0)!
                    imageCat.add(image, withIdentifier:d.image)
                    DispatchQueue.main.async{
                        self.tb.reloadData()
                    }
                }else{
                    print("--- load image null")
                }
            }*/
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let walmart = self.data![indexPath.row]
        performSegue(withIdentifier: "dt", sender: walmart)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Prepare \(segue.identifier)")
        if segue.identifier == "dt"{
            let vc = segue.destination as? DetailsViewController
            vc?.walmart = sender as? Walmart
            print("----next screen")
        }else if segue.identifier == "dt2"{
            print("----next screen dt2")
            let vc = segue.destination as? DtViewController
            vc?.view.backgroundColor = UIColor.blue
        }
       
    }
    @IBOutlet weak var tb: UITableView!
    var viewMode:ViewModel?
    var data:[Walmart]?
    var imageCat = AutoPurgingImageCache( memoryCapacity: 111_111_111, preferredMemoryUsageAfterPurge: 90_000_000)
    func t(chars:String){
        for c in chars{
            if c == "N"{
                print("---- c = \(c) ")
            }
        }
    }
    enum TestEnum{
        case test1(String)
        case test2(String,String)
    }
    var test:TestEnum?
    override func viewDidLoad() {
        super.viewDidLoad()
        t(chars: "Niwat")
    
        tb.dataSource = self
        tb.delegate = self
        self.tb.separatorStyle = UITableViewCell.SeparatorStyle.none
        // Do any additional setup after loading the view.
        //test = .test1("OK1")
        test = .test2("OK1", "OK2")
        switch test{
        case let .test1(s):
            print("--- case test1 = \(s)")
        case .test2(let s,let s2):
            print("case test2  \(s) \(s2)")
        case .test1:
            print("--- case test1 no param")
        default:
            break
        }
        
        
        let apiService = ApiService()
        viewMode = ViewModel(apiService: apiService)
        viewMode?.getWalmart(url: "https://fakestoreapiserver.reactbd.com/walmart", params: ["a":"","b":""], result: {it in
            self.data = it
            //self.loadImages()
            self.tb.reloadData()
            print("----- result = \(it.count)")
        })
    }
}
var imageCache = NSCache<AnyObject,AnyObject>()
extension UIImage{
    static func loadImageUsingCacheWithUrlString(urlString: String, completion: @escaping (UIImage) -> Void) {
            if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
                completion(cachedImage)
            }

            //No cache, so create new one and set image
            let url = URL(string: urlString)
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                if let error = error {
                    print(error)
                    return
                }
                DispatchQueue.main.async(execute: {
                    if let downloadedImage = UIImage(data: data!) {
                        imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                        completion(downloadedImage)
                    }
                })

            }).resume()
        }
}
extension UIImageView{
    func load(urlString:String){
        guard let url = URL(string: urlString) else{
            return
        }
        DispatchQueue.global().async {[weak self] in
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self!.image = image
                    }
                }
            }
        }
    }
    func load2(urlString:String){
        URLSession.shared.dataTask(with: NSURL(string:urlString)! as URL, completionHandler: { data, response, error in
            if error != nil {
                print(error ?? "No Error")
                return
            }
            DispatchQueue.main.async(execute:{
                let image = UIImage(data: data!)
                self.image = image
            })
        }).resume()
    }
    func loadImageUsingCacheWithUrlString(_ urlString: String) {
            if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
                self.image = cachedImage
                return
            }
            //No cache, so create new one and set image
            let url = URL(string: urlString)
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                if let error = error {
                    print(error)
                    return
                }
                DispatchQueue.main.async{
                    if let downloadedImage = UIImage(data: data!) {
                        imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                        self.image = downloadedImage
                    }
                }
            }).resume()
        
    }
}


