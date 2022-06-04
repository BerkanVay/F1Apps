//
//  PilotDetail.swift
//  F1Pilots
//
//  Created by Mustafa Berkan Vay on 19.04.2022.
//

import Foundation

struct PilotDetail: Decodable {
    let id: Int
    let age: Int
    let image: String
    let team: String
}
