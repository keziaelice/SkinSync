import Foundation
import SwiftData

@Model
class UserModel {
    var id: UUID
    var username: String
    var age: Int
    var gender: String

    init(username: String, age: Int, gender: String) {
        self.id = UUID() // Automatically generates a unique identifier
        self.username = username
        self.age = age
        self.gender = gender
    }
}
