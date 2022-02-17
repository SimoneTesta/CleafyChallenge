//
//  StargazerCellTableViewCell.swift
//  SecureApp
//
//  Created by Simone Testa on 17/02/22.
//

import UIKit
import SecureSDK

class StargazerCellTableViewCell: UITableViewCell {

    public static let identifier = "StargazerCell"

    @IBOutlet weak var stargazerNameLabel: UILabel!
    @IBOutlet weak var stargazerImageView: UIImageView!
    
    
    public func configure(stargazer: StarGazersResponse) {
        stargazerNameLabel.text = stargazer.login
        stargazerImageView.downloaded(from: stargazer.avatar_url)
    }

}
