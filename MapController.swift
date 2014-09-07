//
//  ViewController.swift
//  Deal-link
//
//  Created by kp on 8/09/2014.
//  Copyright (c) 2014 tekkup. All rights reserved.
//

import UIKit
import MapKit

class MapController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var latitude:CLLocationDegrees = -33.882957
        var longtitude:CLLocationDegrees = 151.200467

        
        //zoom in
        var latDelta:CLLocationDegrees = 0.01
        var longDelta:CLLocationDegrees = 0.01
        
        var theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        var UTSLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longtitude)
        var theRegion:MKCoordinateRegion = MKCoordinateRegionMake(UTSLocation, theSpan)
        
        self.mapView.setRegion(theRegion, animated: true)
        
        var theUlmMinsterAnnotation = MKPointAnnotation()
        theUlmMinsterAnnotation.coordinate = UTSLocation
        
        theUlmMinsterAnnotation.title = "Our UTS"
        theUlmMinsterAnnotation.subtitle = "A very old and odd looking building actually"
        
        self.mapView.addAnnotation(theUlmMinsterAnnotation)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

