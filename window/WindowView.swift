import SwiftUI

/// Main window view
struct WindowView: View {
    @ObservedObject var viewModel: WindowViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.model.title)
                .font(.headline)
        }
        .frame(
            width: viewModel.model.frame.width,
            height: viewModel.model.frame.height
        )
    }
}
