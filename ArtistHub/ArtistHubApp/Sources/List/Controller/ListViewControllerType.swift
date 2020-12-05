import UIKit

protocol ListViewControllerType: UIViewController {
    var delegate: ListViewControllerDelegate? { get set }
}
