import UIKit

public extension UIStoryboard {
    
    func instantiateViewController<T: UIViewController>(ofType type: T.Type, withIdentifier identifier: String? = nil) -> T {
        let identifier = identifier ?? String(describing: type)
       
        return instantiateViewController(withIdentifier: identifier) as! T
    }
    
}
