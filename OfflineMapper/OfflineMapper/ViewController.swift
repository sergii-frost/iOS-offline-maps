//
//  ViewController.swift
//  OfflineMapper
//
//  Created by Sergii Nezdolii on 02/03/16.
//  Copyright © 2016 FrostDigital. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    //MARK: Constants
    let osmTemplate = "http://tile.openstreetmap.org/{z}/{x}/{y}.png"
    
    //MARK: IBOutlets

    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: ViewController funcs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMap()
    }
    
    //MARK: Helper funcs
    
    private func initMap() {
        let osmOverlay = MKTileOverlay(URLTemplate: osmTemplate)
        osmOverlay.canReplaceMapContent = true
        
        mapView.addOverlay(osmOverlay)
    }
    
    // MARK: MKMapViewDelegate
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        guard let tileOverlay = overlay as? MKTileOverlay else {
            return MKOverlayRenderer()
        }
        
        return MKTileOverlayRenderer(tileOverlay: tileOverlay)
    }
}

