//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Toto Tsipun on 13.04.2023.
//
import UIKit

final class ImagesListCell: UITableViewCell {
    static let reuseIdentifier = "ImagesListCell"
    let photosName: [String] = Array(0..<20).map{"\($0)"}
    
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
    func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        guard let image = UIImage(named: photosName[indexPath.row]) else {
            return
        }
        
        cell.imageCell.image = image
        cell.dateLabel.text = dateFormatter.string(from: Date())
        
        let likeState = indexPath.row % 2 == 0
        let likeImage = likeState ? UIImage(named: "LikeOffButton") : UIImage(named: "LikeOnButton")
        cell.likeButton.setImage(likeImage, for: .normal)
    }
}
