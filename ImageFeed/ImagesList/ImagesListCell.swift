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
    
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBAction private func likeButtonClicked() {
        delegate?.imageListCellDidTapLike(self)
    }
    weak var delegate: ImageListCellDelegate?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // Отменяем загрузку, чтобы избежать багов при переиспользовании ячеек
        imageCell.kf.cancelDownloadTask()
    }
    
    func setIsLiked(isLiked: Bool){
        let liked = UIImage(named: "like_button_on")
        let disLiked = UIImage(named: "like_button_off")
        if isLiked {
            likeButton.setImage(liked, for: .normal)
        } else {
            likeButton.setImage(disLiked, for: .normal)
        }
    }
}
