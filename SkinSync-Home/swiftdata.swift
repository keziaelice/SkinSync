import Foundation
import SwiftData

@Model
class UserModel {
    var id: UUID
    var username: String
    var age: Int

    init(username: String, age: Int) {
        self.id = UUID() // Automatically generates a unique identifier
        self.username = username
        self.age = age
    }
}
