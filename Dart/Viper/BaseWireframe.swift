import UIKit

public protocol WireframeInterface: class {
    func popFromNavigationController(animated: Bool)
    func dismiss(animated: Bool)
    
    func showErrorAlert(with message: String?)
    func showAlert(with title: String?, message: String?)
    func showAlert(with title: String?, message: String?, actions: [UIAlertAction])
}

open class BaseWireframe {

    public unowned var _viewController: UIViewController
    
    //to retain view controller reference upon first access
    fileprivate var _temporaryStoredViewController: UIViewController?
  
    public init(viewController: UIViewController) {
        _temporaryStoredViewController = viewController
        _viewController = viewController
      
    }
}

extension BaseWireframe: WireframeInterface {
  public func popFromNavigationController(animated: Bool) {
        let _ = navigationController?.popViewController(animated: animated)
    }
    
  public func dismiss(animated: Bool) {
    if let navigationController = navigationController {
      navigationController.dismiss(animated: animated)
    } else {
      viewController.dismiss(animated: animated, completion: nil)
    }
    
 }
    
  public func showErrorAlert(with message: String?) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        showAlert(with: "Something went wrong", message: message, actions: [okAction])
    }
    
  public func showAlert(with title: String?, message: String?) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        showAlert(with: title, message: message, actions: [okAction])
    }
    
  public func showAlert(with title: String?, message: String?, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }
        navigationController?.present(alert, animated: true, completion: nil)
    }
}

extension BaseWireframe {
    
    public var viewController: UIViewController {
      defer { _temporaryStoredViewController = nil }
      return _viewController
    }
    
    public var navigationController: UINavigationController? {
        return viewController.navigationController
    }
    
}

extension UIViewController {
    
    public func presentWireframe(_ wireframe: BaseWireframe, animated: Bool = true, completion: (() -> Void)? = nil) {
        present(wireframe.viewController, animated: animated, completion: completion)
    }
    
}

extension UINavigationController {
    
    public func pushWireframe(_ wireframe: BaseWireframe, animated: Bool = true) {
      self.pushViewController(wireframe.viewController, animated: animated)
    }
    
    public func setRootWireframe(_ wireframe: BaseWireframe, animated: Bool = true) {
        self.setViewControllers([wireframe.viewController], animated: animated)
    }
   
}

