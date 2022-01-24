//
//  ViewController.swift
//  CurrencyConvertor
//
//  Created by Beytullah Özer on 17.12.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var cbpLabel: UILabel!
    @IBOutlet weak var penLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var btcLabel: UILabel!
    @IBOutlet weak var bynLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func getRatesButton(_ sender: Any) {
    
        // 1) request - veb adresine gitmek
        // 2) Datayı almak Response & Data
        // 3) Aldığın veriyi işlemek. Parsing & JSON Serialization
        
        // Step 1
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=159ffd4229293f58bc7199cb499a9b21")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data, response, error) in
        
            //Closure
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
            } else {
                // Step 2
                if data != nil {
                    
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary <String, Any>
                        
                        //ASYNC
                        DispatchQueue.main.sync {
                            //print(jsonResponse)
                            if let takeRates = jsonResponse["rates"] as? [String:Any] {
                                //print(takeRates)
                                if let cad = takeRates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD: \(cad)"
                                }
                                if let chf = takeRates["CHF"] as? Double {
                                    self.chfLabel.text = "CHF: \(chf)"
                                }
                                if let gbp = takeRates["GBP"] as? Double {
                                    self.cbpLabel.text = "GBP: \(gbp)"
                                }
                                if let pen = takeRates["PEN"] as? Double {
                                    self.penLabel.text = "PEN: \(pen)"
                                }
                                if let usd = takeRates["USD"] as? Double {
                                    self.usdLabel.text = "USD: \(usd)"
                                }
                                if let tryy = takeRates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY: \(tryy)"
                                }
                                if let btc = takeRates["BTC"] as? Double {
                                    self.btcLabel.text = "BTC: \(btc)"
                                }
                                if let byn = takeRates["BYN"] as? Double {
                                    self.bynLabel.text = "BYN: \(byn)"
                                }
                                
                            }
                        }
                        
                    } catch {
                        print("Error...")
                    }
                }
            }
        }
        task.resume()
    }
}

