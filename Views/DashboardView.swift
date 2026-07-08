import SwiftUI

struct DashboardView: View {

    let agents = [
        "Letting Land",
        "Harringtons",
        "James Dean",
        "Choices",
        "Kaybridge",
        "Greenfield",
        "Birdhouse Surrey",
        "Knights",
        "Zoom"
    ]

    @State private var selectedAgent = SettingsManager.shared.loadAgent()
    @State private var properties: [Property] = []

    var body: some View {

        VStack(alignment: .leading, spacing: 25) {

            Text("Blinc MTI Manager")
                .font(.largeTitle.bold())

            VStack(alignment: .leading) {

                Text("Estate Agent")

                Picker("", selection: $selectedAgent) {

                    ForEach(agents, id: \.self) {

                        Text($0)

                    }

                }
                .pickerStyle(.menu)
                .frame(width:250)

            }

            Button("Choose Spreadsheet") {

                properties = SpreadsheetImporter().loadSpreadsheet()

            }

            Divider()

            PropertyTable(properties: properties)

            Spacer()

        }
        .padding(30)
        .frame(minWidth:800,minHeight:600)

        .onChange(of: selectedAgent) { newValue in
            SettingsManager.shared.save(agent: newValue)
        }

    }

}
