//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Toto Tsipun on 13.04.2023.
//
import UIKit

protocol ImageListCellDelegate : AnyObject {
    func imageListCellDidTapLike(_ cell: ImagesListCell)
}

final class ImagesListCell: UITableViewCell {
    static let reuseIdentifier = "ImagesListCell"
    weak var delegate: ImageListCellDelegate?
    
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBAction private func likeButtonClicked() {
        delegate?.imageListCellDidTapLike(self)
    }
    
    func setIsLiked(isLiked: Bool){
        let liked = UIImage(named: "LikeOnButton")
        let disLiked = UIImage(named: "LikeOffButton")
        if isLiked {
            likeButton.setImage(liked, for: .normal)
        } else {
            likeButton.setImage(disLiked, for: .normal)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
// Отменяем загрузку, чтобы избежать багов при переиспользовании ячеек
        imageCell.kf.cancelDownloadTask()
    }
}
