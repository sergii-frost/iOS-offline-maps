//
//  MKSwerefTileOverlay.swift
//  OfflineMapper
//
//  Created by Sergii Nezdolii on 02/03/16.
//  Copyright © 2016 FrostDigital. All rights reserved.
//

import MapKit
import UIKit

class MKSwerefTileOverlay: MKTileOverlay {
    
    let kLantmaterietTemplate = "http://maps-open.lantmateriet.se/open/topowebb-ccby/v1/wmts/1.0.0/topowebb/default/3006/%d/%d/%d.png"

    override func URLForTilePath(path: MKTileOverlayPath) -> NSURL {
        //Need to calculate properly zoom level, 
        //as well as internal Sweden coordinates for x and y 
        //based on SWEREF99 TM used by lantmateriet
        //1 is TileMatrix - zoom level
        //2 is TileRow
        //3 is TileCol
        return NSURL(string: String(format: kLantmaterietTemplate, path.z, path.x, path.y))!
    }
}
