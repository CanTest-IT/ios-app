
import Foundation

public final class NotificationCenter: NSObject {
    public static let shared = NotificationCenter()
    
    private var notificationDefaultViewPresenter: NotificationDefaultViewPresenter?
    private var isOtherNotificationRunning: Bool {
        return queue.contains(where: { $0.notificationHasBeenShown == true })
    }
    
    private var queue: [Notification] = [] {
        didSet {
            if !isOtherNotificationRunning {
                queue.sort(by: { $0.priority.rawValue == $1.priority.rawValue ? $0.creationDate < $1.creationDate : $0.priority.rawValue < $1.priority.rawValue })
                showFirstNotificationFromQueue()
            }
        }
    }
    
    private override init() {
        super.init()
    }
    
    public func showMessage(with parameters: NotificationParameters) {
        let notification = Notification(parameters: parameters)
        add(notification: notification)
    }
    
    private func add(notification: Notification) {
        queue.append(notification)
    }
    
    private func showFirstNotificationFromQueue() {
        guard let notification = getFirstNotificationFromQueue() else { return }

        notification.notificationHasBeenShown = true
        
        notificationDefaultViewPresenter = NotificationDefaultViewPresenter(delegate: self)
        notificationDefaultViewPresenter?.presentDefaultNotificationView(withParameters: notification.parameters)
    }
    
    private func getFirstNotificationFromQueue() -> Notification? {
        return queue.first
    }
}

extension NotificationCenter: NotificationPresenterDelegate {
    func didFinishDisplayingNotification() {
        notificationDefaultViewPresenter = nil
        guard let indexToRemove = queue.index(where: { $0.notificationHasBeenShown == true }) else { return }

        queue.remove(at: indexToRemove)
    }
}
