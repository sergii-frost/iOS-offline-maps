//
//  ViewController.swift
//  OfflineMapper
//
//  Created by Sergii Nezdolii on 02/03/16.
//  Copyright © 2016 FrostDigital. All rights reserved.
//

import UIKit
import MapKit

enum MapTileTemplate: String {
    case OpenStreetMap = "http://tile.openstreetmap.org/{z}/{x}/{y}.png",
    OpenCycleMap = "http://b.tile.opencyclemap.org/cycle/{z}/{x}/{y}.png",
    MapQuest = "http://otile3.mqcdn.com/tiles/1.0.0/osm/{z}/{x}/{y}.jpg"
}

class ViewController: UIViewController, MKMapViewDelegate {

    //MARK: Constants
    let kOpenStreetMapTemplate  = "http://tile.openstreetmap.org/{z}/{x}/{y}.png"
    let kOpenCycleMapTemplate   = "http://b.tile.opencyclemap.org/cycle/{z}/{x}/{y}.png"
    let kMapQuestTemplate       = "http://otile3.mqcdn.com/tiles/1.0.0/osm/{z}/{x}/{y}.jpg"
    let kLantmaterietTemplate   = "http://maps-open.lantmateriet.se/open/topowebb-ccby/v1/wmts/1.0.0/topowebb/default/3006/{z}/{x}/{y}.png"
    let kOpenSeaMapTemplate     = "http://tiles.openseamap.org/seamark/{z}/{x}/{y}.png"
    
    //MARK: IBOutlets

    @IBOutlet weak var mapTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: ViewController funcs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapTypeChanged(mapTypeSegmentedControl)
    }
    
    @IBAction func mapTypeChanged(sender: AnyObject?) {
        addTileOverlayWithTemplate(mapTileTemplate(mapTypeSegmentedControl.selectedSegmentIndex))
    }
    
    //MARK: Helper funcs
    
    private func mapTileTemplate(selectedIndex: Int) -> MapTileTemplate {
        switch selectedIndex {
        case 0: return .OpenStreetMap
        case 1: return .OpenCycleMap
        case 2: return .MapQuest
        default: return .OpenStreetMap
        }
    }
    
    private func addTileOverlayWithTemplate(mapTileTemplate: MapTileTemplate) {
        //Remove old tile overlays, as they are not needed
        let tileOverlays = mapView.overlays.filter { $0 is MKTileOverlay }
        if tileOverlays.count > 0 {
            mapView.removeOverlays(tileOverlays)
        }
        
        let tileOverlay = MKTileOverlay(URLTemplate: mapTileTemplate.rawValue)
        tileOverlay.canReplaceMapContent = true
        mapView.addOverlay(tileOverlay)
    }
    
    private func initMap() {
        let osmOverlay = MKTileOverlay(URLTemplate: kOpenStreetMapTemplate)
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

