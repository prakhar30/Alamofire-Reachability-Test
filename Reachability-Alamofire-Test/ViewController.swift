//
//  ViewController.swift
//  Reachability-Alamofire-Test
//
//  Created by Prakhar Tripathi on 19/01/18.
//  Copyright © 2018 Prakhar Tripathi. All rights reserved.
//

import UIKit
import Alamofire
import Reachability

class ViewController: UIViewController {
    let reachability = Reachability()!

    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
        case .cellular:
            print("Reachable via Cellular")
        case .none:
            print("Network not reachable")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getData()
    }
    
    func getData(){
        Alamofire.request("https://reqres.in/api/users?page=2").responseJSON { (response) in
            if let json = response.result.value{
                print(json)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

