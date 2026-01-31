import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ClockViewModel()
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            GeometryReader { geometry in
                VStack(spacing: geometry.size.width > geometry.size.height ? 30 : 40) {
                    // 日期显示
                    Text(viewModel.dateString)
                        .font(.system(size: geometry.size.width > geometry.size.height ? 40 : 36, weight: .medium))
                        .foregroundColor(.white)
                    
                    // 时间显示
                    Text(viewModel.timeString)
                        .font(.system(size: geometry.size.width > geometry.size.height ? 100 : 72, weight: .bold))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        }
    }
}
