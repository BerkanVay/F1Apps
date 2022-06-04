//
//  MainTableViewCellDelegate.swift
//  F1Pilots
//
//  Created by Mustafa Berkan Vay on 19.04.2022.
//

import Foundation

protocol MainTableViewCellDelegate: AnyObject {
    func favoriteButtonTapped(forPilot pilot: PilotsResponse.Pilot)
}
