//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Toto Tsipun on 13.04.2023.
//
import UIKit

final class ImagesListCell: UITableViewCell {
    static let reuseIdentifier = "ImagesListCell"
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    } ()
    
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
}

extension ImagesListCell {
    func configCell(isLiked: IndexPath, imageNamed: UIImage?) {
        guard let image = imageNamed else { return }
        
        imageCell.image = image
        dateLabel.text = dateFormatter.string(from: Date())
        
        let likeState = isLiked.row % 2 == 0
        let likeImage = likeState ? UIImage(named: "LikeOffButton") : UIImage(named: "LikeOnButton")
        likeButton.setImage(likeImage, for: .normal)
    }
}
