import Foundation
import UserNotifications

struct Alarm: Identifiable {
    let id = UUID()
    var hour: Int
    var minute: Int
    var isEnabled: Bool = true
    
    init(hour: Int, minute: Int) {
        self.hour = hour
        self.minute = minute
    }
    
    var timeString: String {
        let hourString = hour < 10 ? "0\(hour)" : "\(hour)"
        let minuteString = minute < 10 ? "0\(minute)" : "\(minute)"
        return "\(hourString):\(minuteString)"
    }
}

class AlarmViewModel: ObservableObject {
    @Published var alarms: [Alarm] = []
    
    init() {
        // 请求通知权限
        requestNotificationPermission()
    }
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("通知权限已授予")
            } else {
                print("通知权限被拒绝")
            }
        }
    }
    
    func addAlarm(hour: Int, minute: Int) {
        let newAlarm = Alarm(hour: hour, minute: minute)
        alarms.append(newAlarm)
        
        // 调度通知
        scheduleNotification(for: newAlarm)
    }
    
    func scheduleNotification(for alarm: Alarm) {
        let content = UNMutableNotificationContent()
        content.title = "闹钟"
        content.body = "到时间了，点击停止提醒"
        content.sound = UNNotificationSound.default
        
        // 设置每天重复的通知触发时间
        var dateComponents = DateComponents()
        dateComponents.hour = alarm.hour
        dateComponents.minute = alarm.minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: alarm.id.uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("调度通知失败: \(error)")
            } else {
                print("通知已调度: \(alarm.timeString)")
            }
        }
    }
    
    func removeAlarm(at index: Int) {
        if index < alarms.count {
            let alarmToRemove = alarms[index]
            // 取消该闹钟的通知
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarmToRemove.id.uuidString])
            alarms.remove(at: index)
        }
    }
    
    func toggleAlarm(at index: Int) {
        if index < alarms.count {
            let alarm = alarms[index]
            alarms[index].isEnabled.toggle()
            
            if alarms[index].isEnabled {
                // 重新调度通知
                scheduleNotification(for: alarms[index])
            } else {
                // 取消通知
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.id.uuidString])
            }
        }
    }
}