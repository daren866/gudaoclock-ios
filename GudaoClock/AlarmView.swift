import SwiftUI

struct AlarmView: View {
    @Binding var isPresented: Bool
    @ObservedObject var alarmViewModel: AlarmViewModel
    @State private var selectedHour: String = "11"
    @State private var selectedMinute: String = "45"
    
    var body: some View {
        ZStack {
            // 半透明背景
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    isPresented = false
                }
            
            // 弹窗内容
            VStack(spacing: 40) {
                // 标题栏
                HStack {
                    Button(action: {
                        isPresented = false
                    }) {
                        Text("取消")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.black)
                    }
                    
                    Text("新增闹钟")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                    
                    Button(action: {
                        // 存储闹钟
                        if let hour = Int(selectedHour), let minute = Int(selectedMinute) {
                            alarmViewModel.addAlarm(hour: hour, minute: minute)
                            isPresented = false
                        }
                    }) {
                        Text("存储")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.black)
                    }
                }
                .padding(.horizontal, 30)
                .padding(.top, 20)
                
                // 时间选择
                HStack(spacing: 40) {
                    // 小时选择
                    VStack {
                        TextField("", text: $selectedHour)
                            .font(.system(size: 48, weight: .bold))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .frame(width: 120, height: 80)
                            .background(Color.white)
                            .border(Color.gray, width: 2)
                    }
                    
                    // 分钟选择
                    VStack {
                        TextField("", text: $selectedMinute)
                            .font(.system(size: 48, weight: .bold))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .frame(width: 120, height: 80)
                            .background(Color.white)
                            .border(Color.gray, width: 2)
                    }
                }
                
                Spacer()
            }
            .frame(width: 320, height: 240)
            .background(Color.gray.opacity(0.9))
            .cornerRadius(12)
            .padding()
        }
    }
}