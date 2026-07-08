import Foundation

final class SpreadsheetImporter {

    func loadSpreadsheet() -> [Property] {

        return [

            Property(
                address: "Flat 4, 10 Essenden Road",
                tenant: "John Smith",
                email: "john@email.com",
                status: .ready
            ),

            Property(
                address: "2 High Street",
                tenant: "Jane Doe",
                email: "",
                status: .missingEmail
            )

        ]

    }

}
