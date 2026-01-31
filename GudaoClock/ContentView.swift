import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ClockViewModel()
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text(viewModel.dateString)
                    .font(.system(size: 36, weight: .medium))
                    .foregroundColor(.white)
                Text(viewModel.timeString)
                    .font(.system(size: 72, weight: .bold))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}
