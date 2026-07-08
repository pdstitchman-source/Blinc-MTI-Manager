import Foundation

struct Property: Identifiable {

    let id = UUID()

    var address: String
    var tenant: String
    var email: String

    var status: Status

    enum Status {

        case ready
        case missingEmail
        case invalidEmail

    }

}
