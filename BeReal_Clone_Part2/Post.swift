import ParseSwift

struct Post: ParseObject {
    var originalData: Data?
    
    var updatedAt: Date?
    
    var ACL: ParseSwift.ParseACL?
    
    static func == (lhs: Post, rhs: Post) -> Bool {
        <#code#>
    }
    
    var objectId: String?
    var user: User?
    var image: ParseFile?
    var createdAt: Date?
    var comments: [Comment]?

    struct Comment: ParseObject {
        var username: String
        var text: String
    }
}
