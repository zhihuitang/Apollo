//
//  MKGPX.swift
//  Apollo
//
//  Created by Zhihui Tang on 2017-01-20.
//  Copyright © 2017 Zhihui Tang. All rights reserved.
//

import MapKit

extension GPX.Waypoint: MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    // Title and subtitle for use by selection UI.
    var title: String? {
        return name
    }
    
    var subtitle: String? {
        return info
    }
    
    var thumbnailURL: URL? {
        return getImageURLofType(type: "thumbnail")
    }
    
    var imageURL: URL? {
        return getImageURLofType(type: "large")
    }
    private func getImageURLofType( type: String?) -> URL? {
        for link in links {
            if link.type == type {
                return link.url as URL?
            }
        }
        return nil
    }
}
