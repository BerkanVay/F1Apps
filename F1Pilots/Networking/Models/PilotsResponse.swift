//
//  PilotsResponse.swift
//  F1Pilots
//
//  Created by Mustafa Berkan Vay on 19.04.2022.
//

import Foundation

struct PilotsResponse: Decodable {
  let items: [Pilot]
  
  struct Pilot: Decodable {
    let id: Int
    let name: String
    let point: Int
    
    var pointFormatted: String {
      point == 1 ? "\(point) point" : "\(point) points"
    }
  }
}
