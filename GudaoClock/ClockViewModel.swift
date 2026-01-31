import Foundation
import Combine

class ClockViewModel: ObservableObject {
    @Published var timeString = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        updateTime()
        
        // 每秒更新一次时间
        Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateTime()
            }
            .store(in: &cancellables)
    }
    
    private func updateTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        timeString = formatter.string(from: Date())
    }
}