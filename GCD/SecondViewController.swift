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
		delay(3) {
			self.loginAlert()
		}
	}

	private func delay(_ delay: Int, closure: @escaping () -> Void) {
		DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
			closure()
		}
	}

	private func loginAlert() {
		let alertController = UIAlertController(
			title: "Is register?",
			message: "Enter your login and password",
			preferredStyle: .alert
		)
		let okAction = UIAlertAction(title: "OK", style: .default)
		let cancelAction = UIAlertAction(title: "Cancel", style: .default)

		alertController.addAction(okAction)
		alertController.addAction(cancelAction)

		alertController.addTextField { usernameTF in
			usernameTF.placeholder = "Enter login"
		}
		alertController.addTextField { userPasswordTF in
			userPasswordTF.placeholder = "Enter password"
			userPasswordTF.isSecureTextEntry = true
		}

		present(alertController, animated: true)
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
