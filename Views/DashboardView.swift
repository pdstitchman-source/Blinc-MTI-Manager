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

    var body: some View {

        VStack(alignment: .leading, spacing: 25) {

            Text("Blinc MTI Manager")
                .font(.largeTitle.bold())
