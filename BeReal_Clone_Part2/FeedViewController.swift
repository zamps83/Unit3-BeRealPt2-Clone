import UIKit
import ParseSwift

class FeedViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        fetchFeed()
    }

    func fetchFeed() {
        guard let currentUser = User.current, currentUser.hasUploadedPhoto else {
            print("❌ You must upload a photo to view the feed.")
            return
        }

        let yesterdayDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!

        let query = Post.query()
            .include("user")
            .where("createdAt" >= yesterdayDate)
            .limit(10)

        query.find { [weak self] result in
            switch result {
            case .success(let posts):
                self?.posts = posts
                self?.tableView.reloadData()
            case .failure(let error):
                print("❌ Error fetching posts: \(error.localizedDescription)")
            }
        }
    }
}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.row]
        cell.configure(with: post)
        return cell
    }
}
