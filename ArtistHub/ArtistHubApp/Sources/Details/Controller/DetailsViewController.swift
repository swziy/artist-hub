import UIKit

final class DetailsViewController: UIViewController, DetailsViewControllerType {

    override func loadView() {
        view = DetailsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
    }
}
