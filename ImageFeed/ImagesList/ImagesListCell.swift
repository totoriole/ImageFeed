//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Toto Tsipun on 13.04.2023.
//
import UIKit
import ProgressHUD

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
        
        likeButton.setImage(UIImage(named: isLiked ? "LikeOnButton" : "LikeOffButton"), for: .normal)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // Отменяем загрузку, чтобы избежать багов при переиспользовании ячеек
        imageCell.kf.cancelDownloadTask()
        delegate = nil
    }
}
