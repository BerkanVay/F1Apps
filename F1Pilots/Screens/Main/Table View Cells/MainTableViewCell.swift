//
//  MainTableViewCell.swift
//  F1Pilots
//
//  Created by Mustafa Berkan Vay on 19.04.2022.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    static let reuseIdentifier = "MainTableViewCell"
    
    weak var delegate: MainTableViewCellDelegate?
    
    private var pilot: PilotsResponse.Pilot?
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var pointLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
}

extension MainTableViewCell {
    func configure(withPilot pilot: PilotsResponse.Pilot, isFavorited: Bool) {
        nameLabel.text = pilot.name
        
        pointLabel.text = pilot.pointFormatted
        
        setFavoriteButtonState(isFavorited: isFavorited)
        
        self.pilot = pilot
    }
    
    private func setFavoriteButtonState(isFavorited: Bool) {
        let imageName = isFavorited ? "heart.fill" : "heart"
        
        favoriteButton.setImage(
            .init(systemName: imageName),
            for: .normal
        )
    }
}

extension MainTableViewCell {
    @IBAction private func favoriteButtonTapped(_ sender: Any) {
        guard let pilot = pilot else { return }
        
        delegate?.favoriteButtonTapped(forPilot: pilot)
    }
}
