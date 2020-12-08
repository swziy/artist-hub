struct ErrorHandler {

    func handle(error: Error?, response: URLResponse?, data: Data?) -> ApiError? {
        if let error = handle(error: error) {
            return error
        }

        if let error = handle(response: response) {
            return error
        }

        if let error = handle(data: data) {
            return error
        }

        return nil
    }

    // MARK: - Private

    private func handle(error: Error?) -> ApiError? {
        guard let _ = error else {
            return nil
        }

        if let error = error as? URLError, error.code == .cancelled {
            return .cancelled
        }

        return .generalError
    }

    private func handle(response: URLResponse?) -> ApiError? {
        guard let _ = response else {
            return .generalError
        }

        guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode  else {
            return .generalError
        }

        return nil
    }

    private func handle(data: Data?) -> ApiError? {
        guard data != nil else {
            return .generalError
        }

        return nil
    }
}
