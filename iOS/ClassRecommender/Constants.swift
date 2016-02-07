import Foundation
import Firebase

struct Constants {
    static let rootRef = Firebase(url: "https://glaring-torch-8449.firebaseio.com/")
    static let usersRef = rootRef.childByAppendingPath("users")
    static var userRef: Firebase! {
        get {
            let uid = Constants.rootRef.authData.uid
            return usersRef.childByAppendingPath(uid)
        }
    }
    
    static let coursesRef = rootRef.childByAppendingPath("courses")
    
}