import UIKit

enum ListViewState {
    case loading
    case error
    case loaded
}

struct ListViewStatePresenter {

    func show(state: ListViewState, on view: ListView) {
        switch state {
        case .loading:
            view.hideErrorView()
            view.showActivityIndicator()
        case .error:
            view.showErrorView()
            view.hideActivityIndicator()
        case .loaded:
            view.hideErrorView()
            view.hideActivityIndicator()
        }
    }
}
