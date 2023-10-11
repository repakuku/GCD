//
//  SecondViewController.swift
//  GCD
//
//  Created by Alexey Turulin on 10/11/23.
//

import UIKit

final  class SecondViewController: UIViewController {

	@IBOutlet private weak var imageView: UIImageView!
	@IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

	private var imageURL: URL?
	private var image: UIImage? {
		get {
			imageView.image
		}
		set {
			activityIndicator.stopAnimating()
			imageView.image = newValue
			imageView.sizeToFit()
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		activityIndicator.hidesWhenStopped = true
		getImage()
	}

	private func getImage() {
		imageURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")

		activityIndicator.startAnimating()

		guard let imageURL = imageURL else { return }

		let queue = DispatchQueue.global(qos: .utility)
		queue.async {
			do {
				let imageData = try Data(contentsOf: imageURL)
				DispatchQueue.main.async { [weak self] in
					guard let self = self else { return }
					self.image = UIImage(data: imageData)
				}
			} catch {
				print(error)
			}
		}
	}
}
