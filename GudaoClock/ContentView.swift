import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ClockViewModel()
    @StateObject private var alarmViewModel = AlarmViewModel()
    @State private var showAlarmIcon = false
    @State private var showAlarmSheet = false
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            GeometryReader { geometry in
                VStack(spacing: geometry.size.width > geometry.size.height ? 30 : 40) {
                    // 日期显示和闹钟图标
                    HStack {
                        Text(viewModel.dateString)
                            .font(.system(size: geometry.size.width > geometry.size.height ? 40 : 36, weight: .medium))
                            .foregroundColor(.white)
                        Spacer()
                        if showAlarmIcon {
                            Button(action: {
                                showAlarmSheet = true
                            }) {
                                Image(systemName: "alarm.fill")
                                    .font(.system(size: geometry.size.width > geometry.size.height ? 32 : 28))
                                    .foregroundColor(.white)
                                    .padding(.trailing, 20)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                    // 时间显示（可点击）
                    Button(action: {
                        showAlarmIcon.toggle()
                    }) {
                        Text(viewModel.timeString)
                            .font(.system(size: geometry.size.width > geometry.size.height ? 100 : 72, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            
            // 新增闹钟弹窗
            if showAlarmSheet {
                AlarmView(isPresented: $showAlarmSheet, alarmViewModel: alarmViewModel)
            }
        }
    }
}
