import UIKit

class PostCell: UITableViewCell {
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var blurView: UIVisualEffectView!

    func configure(with post: Post) {
        if let currentUser = User.current,
           let lastPostedDate = currentUser.lastPostedDate,
           let createdAt = post.createdAt {
            let diffHours = Calendar.current.dateComponents([.hour], from: createdAt, to: lastPostedDate).hour ?? 0
            blurView.isHidden = abs(diffHours) < 24
        } else {
            blurView.isHidden = false
        }

        // Load image from Parse
        if let imageFile = post.image {
            imageFile.fetch { [weak self] result in
                switch result {
                case .success(let data):
                    self?.postImageView.image = UIImage(data: data)
                case .failure(let error):
                    print("❌ Error loading image: \(error.localizedDescription)")
                }
            }
        }
    }
}
