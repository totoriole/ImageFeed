//
//  ViewController.swift
//  ImageFeed
//
//  Created by Toto Tsipun on 29.03.2023.
//

import UIKit
import Kingfisher
import ProgressHUD

class ImagesListViewController: UIViewController {
    private let showSingleImageSegueIdentifier = "ShowSingleImage"

    private var imagesListServiceObserver: NSObjectProtocol?
    var photos: [Photo] = []
    private let imagesListService = ImagesListService.shared
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    } ()
    
    @IBOutlet weak private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        
        UIBlockingProgressHUD.show()
        imagesListServiceObserver = NotificationCenter.default.addObserver(
            forName: ImagesListService.DidChangeNotification,
            object: nil,
            queue: .main) {[weak self] _ in
                guard let self = self else {return}
                self.updateTableViewAnimated()
                UIBlockingProgressHUD.dismiss()
            }
        imagesListService.fetchPhotosNextPage()
    }
    
    private func updateTableViewAnimated() {
        let oldCount = photos.count
        let newCount = imagesListService.photos.count
        photos = imagesListService.photos
        if oldCount != newCount{
            tableView.performBatchUpdates {
                let indexPath = (oldCount..<newCount).map { i in
                    IndexPath(row: i, section: 0)
                }
                tableView.insertRows(at: indexPath, with: .automatic)
            } completion: { _ in }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showSingleImageSegueIdentifier {
            let viewController = segue.destination as! SingleImageViewController
            let indexPath = sender as! IndexPath
            let fullImageURL = URL(string: photos[indexPath.row].fullImageURL)
            viewController.fullImageURL = fullImageURL
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
    // MARK: - Alert
    
    private func showLikeAlert(with error: Error) {
        let alert = UIAlertController(
            title: "Что-то пошло не так",
            message: "Действие временно недоступно, попробуйте позднее",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
}



//MARK: - Extensions

extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath)
        guard let imageListCell = cell as? ImagesListCell else {
            print("Ошибка приведения типов")
            return UITableViewCell()
        }
        imageListCell.delegate = self
        configCell(for: imageListCell, with: indexPath)
        return imageListCell
    }
    
    private func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        guard let imageThumbURL = URL(string: photos[indexPath.row].thumbImageURL),
              let placeholder = UIImage(named: "Stub") else {return}
        cell.imageCell.kf.indicatorType = .activity
        cell.imageCell.kf.setImage(with: imageThumbURL, placeholder: placeholder) { _ in
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        cell.setIsLiked(isLiked: photos[indexPath.row].isLiked)
        if let date = photos[indexPath.row].createdAt {
            cell.dateLabel.text = dateFormatter.string(from: date)
        } else {
            cell.dateLabel.text = nil
        }
    }
}

extension ImagesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: showSingleImageSegueIdentifier, sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == imagesListService.photos.count {
            imagesListService.fetchPhotosNextPage()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let image = photos[indexPath.row]
        let imageInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        let imageViewWidth = tableView.bounds.width - imageInsets.left - imageInsets.right
        let imageWidth = image.size.width
        let scale = imageViewWidth / imageWidth
        let cellHeight = image.size.height * scale + imageInsets.bottom + imageInsets.top
        return cellHeight
    }
}

// MARK: - Extension ImageListCellDelegate
extension ImagesListViewController: ImageListCellDelegate {
    
    func imageListCellDidTapLike(_ cell: ImagesListCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        let photo = photos[indexPath.row]
        UIBlockingProgressHUD.show() //// Покажем лоадер
        imagesListService.changeLikes(photoID: photo.id, isLike: !photo.isLiked) { [weak self]  result in
            guard let self = self else {return}
            switch result {
            case .success:
                // Синхронизируем массив картинок с сервисом
                self.photos = self.imagesListService.photos
                // Изменим индикацию лайка картинки
                cell.setIsLiked(isLiked: self.photos[indexPath.row].isLiked)
                // Уберём лоадер
                UIBlockingProgressHUD.dismiss()
            case .failure(let error):
                // Уберём лоадер
                UIBlockingProgressHUD.dismiss()
                // Покажем, что что-то пошло не так
                self.showLikeAlert(with: error)
            }
        }
    }
}
