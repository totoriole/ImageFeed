//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Toto Tsipun on 30.04.2023.
//

import UIKit

final class SingleImageViewController: UIViewController {
    var image: UIImage!
        {
            didSet {
                guard isViewLoaded else { return }
                imageView.image = image
                rescaleAndCenterImageInScrollView()
            }
        }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 1.25
        scrollView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rescaleAndCenterImageInScrollView()
    }
}

private extension SingleImageViewController {
    @IBAction private func didTapBackButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func didTapShareButton() {
        guard let image = image else { return }
        let sharing = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(sharing, animated: true)
    }
    
    private func rescaleAndCenterImageInScrollView () {
        
        let minZoomScale = scrollView.minimumZoomScale
        let maxZoomScale = scrollView.maximumZoomScale
        view.layoutIfNeeded()
        let visibleRectSize = scrollView.bounds.size
        let imageSize = image.size
        let hScale = visibleRectSize.width / imageSize.width
        let vScale = visibleRectSize.height / imageSize.height
        let scale = min(maxZoomScale, max(minZoomScale, max(hScale, vScale)))
        scrollView.setZoomScale(scale, animated: false)
        scrollView.layoutIfNeeded()
        let newContentSize = scrollView.contentSize
        let x = (newContentSize.width - visibleRectSize.width) / 2
        let y = (newContentSize.height - visibleRectSize.height) / 2
        scrollView.setContentOffset(CGPoint(x: x, y: y), animated: false)
//        let halfWidth = (scrollView.bounds.size.width - scrollView.frame.size.width) / 2
//        let halfHeight = (scrollView.bounds.size.height - scrollView.frame.size.height) / 2
//        scrollView.contentInset = .init(top: halfHeight, left: halfWidth, bottom: 0, right: 0)
    }
}

extension SingleImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        rescaleAndCenterImageInScrollView()
    }
}
