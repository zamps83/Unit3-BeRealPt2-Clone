import UIKit
import ParseSwift

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var previewImageView: UIImageView!
    var pickedImage: UIImage?

    @IBAction func onTakePhotoTapped(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.editedImage] as? UIImage else {
            print("❌ Unable to retrieve image.")
            return
        }
        pickedImage = image
        previewImageView.image = image
        // TODO: Save image to server.
    }

    @IBAction func onShareTapped(_ sender: Any) {
        guard let image = pickedImage else { return }
        // TODO: Upload image and save the post.
        if var currentUser = User.current {
            currentUser.lastPostedDate = Date()
            currentUser.save { result in
                switch result {
                case .success:
                    print("✅ Post shared and user updated!")
                case .failure(let error):
                    print("❌ Failed to update user: \(error.localizedDescription)")
                }
            }
        }
    }
}
