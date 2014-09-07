//
//  MenuController.swift
//  Deal-link
//
//  Created by kp on 8/09/2014.
//  Copyright (c) 2014 tekkup. All rights reserved.
//

import UIKit

class MenuController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func mapIconPressed(sender: AnyObject) {
        let mapView = self.storyboard.instantiateViewControllerWithIdentifier("mapView") as MapController
        self.navigationController.pushViewController(mapView, animated: true)
        
    }
    
    @IBAction func messagesIconPressed(sender: AnyObject) {
        let messagesView = self.storyboard.instantiateViewControllerWithIdentifier("messagesView") as MessagesController
        self.navigationController.pushViewController(messagesView, animated: true)
    }
    
    
}
