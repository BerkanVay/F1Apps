//
//  File.swift
//  F1Pilots
//
//  Created by Mustafa Berkan Vay on 19.04.2022.
//

import Foundation

struct Pilots: Codable {
    let items: [Item]
}

struct Item: Codable {
    let id: Int
    let name: String
    let point: Int
}

struct Pilot: Codable {
    let id, age: Int
    let image: String
    let team: String
}
