import UIKit
import SwiftUI

final class IntroCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let appEngine: AppEngine
    
    private lazy var loginCoordinator = LoginCoordinator(
        navigationController: navigationController,
        appEngine: appEngine
    )
    
    init(
        navigationController: UINavigationController,
        appEngine: AppEngine
    ) {
        self.navigationController = navigationController
        self.appEngine = appEngine
    }
    
    func start() {
        let vc =  UIHostingController(rootView: IntroView(
            viewModel: IntroViewModel(
                userDefaultManager: appEngine.userDefaultsManager,
                showLoginScreen: showLoginScreen,
                showFacebook: showFacebook,
                showInstagram: showInstagram,
                showLinkedIn: showLinkedIn
            )
        ))
        
        navigationController.go(to: vc, as: .root)
    }
    
    private func showLoginScreen() {
        loginCoordinator.start()
    }
    
    private func showFacebook() {
        UIApplication.shared.open(AppVariables.facebookURL)
    }
    
    private func showInstagram() {
        UIApplication.shared.open(AppVariables.instagramURL)
    }
    
    private func showLinkedIn() {
        UIApplication.shared.open(AppVariables.linkedInURL)
    }
}
