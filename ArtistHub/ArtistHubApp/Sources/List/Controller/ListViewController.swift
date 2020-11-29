import UIKit

protocol ListViewControllerDelegate: AnyObject {

    func didSelectDetail(with id: String)
}

final class ListViewController: UIViewController {

    weak var delegate: ListViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Artist Hub"

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ListViewController.userDidTap))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func userDidTap() {
        delegate?.didSelectDetail(with: "1")
    }
    
}
