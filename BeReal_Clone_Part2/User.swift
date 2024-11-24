import ParseSwift

struct User: ParseUser {
    var objectId: String?
    var username: String?
    var email: String?
    var password: String?
    var lastPostedDate: Date?
    var hasUploadedPhoto: Bool = false

    // Required fields for ParseUser
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
}
