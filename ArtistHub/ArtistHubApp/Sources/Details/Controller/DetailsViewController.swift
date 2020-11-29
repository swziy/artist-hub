import UIKit

final class DetailsViewController: UIViewController {

    override func loadView() {
        view = DetailsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
    }
}
