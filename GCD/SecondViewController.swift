//
//  SecondViewController.swift
//  GCD
//
//  Created by Alexey Turulin on 10/11/23.
//

import UIKit

final  class SecondViewController: UIViewController {

	@IBOutlet private weak var imageView: UIImageView!

	private var imageURL: URL?
	private var image: UIImage? {
		get {
			imageView.image
		}
		set {
			imageView.image = newValue
			imageView.sizeToFit()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		getImage()
	}

	private func getImage() {
		imageURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")

		guard let imageURL = imageURL else { return }

		do {
			let imageData = try Data(contentsOf: imageURL)
			image = UIImage(data: imageData)
		} catch {
			print(error)
		}
	}
}
