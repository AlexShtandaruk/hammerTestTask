import Foundation

// MARK: - Input

protocol MovieDetailViewProtocol: AnyObject {
    
    func setData(data: Movie?)
}

// MARK: - Output

protocol MovieDetailPresenterProtocol: AnyObject {
    
    init(
        view: MovieDetailViewProtocol,
        networkService: NetworkServiceProtocol,
        data: Movie?,
        router: RouterMovieProtocol,
        completionAuth: @escaping () -> Void
    )
    
    func getData()
    func tapBack()
    func tapLogOut()
}

final class MovieDetailPresenter: MovieDetailPresenterProtocol {
    
    var data: Movie?
    weak var view: MovieDetailViewProtocol?
    let networkService: NetworkServiceProtocol!
    let router: RouterMovieProtocol!
    let completionAuth: () -> Void
    
    required init(
        view: MovieDetailViewProtocol,
        networkService: NetworkServiceProtocol,
        data: Movie?, router: RouterMovieProtocol,
        completionAuth: @escaping () -> Void
    ) {
        self.view = view
        self.networkService = networkService
        self.data = data
        self.router = router
        self.completionAuth = completionAuth
    }
    
    func getData() {
        view?.setData(data: data)
    }
    
    func tapBack() {
        router.popToRoot()
    }
    
    func tapLogOut() {
        completionAuth()
    }
    
}

