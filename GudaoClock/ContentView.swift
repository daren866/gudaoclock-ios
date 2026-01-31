import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ClockViewModel()
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                // 日期显示
                Text(viewModel.dateString)
                    .font(.system(size: 36, weight: .medium))
                    .foregroundColor(.white)
                
                // 时间显示
                Text(viewModel.timeString)
                    .font(.system(size: 72, weight: .bold))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}
