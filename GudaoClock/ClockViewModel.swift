import Foundation
import Combine

class ClockViewModel: ObservableObject {
    @Published var timeString = ""
    @Published var dateString = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        updateDateTime()
        
        // 每秒更新一次时间
        Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateDateTime()
            }
            .store(in: &cancellables)
    }
    
    private func updateDateTime() {
        // 更新时间
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss"
        timeString = timeFormatter.string(from: Date())
        
        // 更新日期
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM月dd日 EEEE"
        dateFormatter.locale = Locale(identifier: "zh_CN")
        dateString = dateFormatter.string(from: Date())
    }
}