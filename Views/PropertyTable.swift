import SwiftUI

struct PropertyTable: View {

    let properties: [Property]

    var body: some View {

        Table(properties) {

            TableColumn("Address") {

                Text($0.address)

            }

            TableColumn("Tenant") {

                Text($0.tenant)

            }

            TableColumn("Email") {

                Text($0.email)

            }

            TableColumn("Status") {

                switch $0.status {

                case .ready:

                    Text("✅ Ready")

                case .missingEmail:

                    Text("⚠ Missing")

                case .invalidEmail:

                    Text("❌ Invalid")

                }

            }

        }

    }

}
