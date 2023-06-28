import Foundation

// MARK: - Input

protocol MovieListViewProtocol: AnyObject {
    
    func success()
    func failure(error: BackendError)
}

// MARK: - Output

protocol MovieListViewPresenterProtocol: AnyObject {
    
    var data: [Movie] { get set }
    
    var filtredData: [Movie] { get }
    var filter: Genre? { get set }
    
    init(router: RouterMovieProtocol, fetch: FetchHelperProtocol)
    
    func getData()
    func tapOnData(data: Movie?)
}


// MARK: - Movie list presenter

final class MovieListPresenter: MovieListViewPresenterProtocol {
    
    let router: RouterMovieProtocol!
    var data: [Movie] = []
    
    var fetch: FetchHelperProtocol
    
    var filter: Genre? {
        didSet { fetch.view?.success() }
    }
    
    var filtredData: [Movie] {
        switch filter {
        case .all, nil:
            return data.sorted {
                let frstValue = Int($0.year ?? "0")
                let scndValue = Int($1.year ?? "0")
                return (frstValue ?? Int()) < (scndValue ?? Int())
            }
        default:
            return data.filter {
                $0.genre?.contains(filter?.rawValue ?? "") == true
            }
        }
    }
    
    required init(router: RouterMovieProtocol, fetch: FetchHelperProtocol) {
        self.router = router
        self.fetch = fetch
        self.filter = .all
    }
    
    func getData() {
        fetch.getData {
            self.data = self.fetch.data
            self.fetch.view?.success()
        }
    }
    
    func tapOnData(data: Movie?) {
        router.showObjects(data: data)
    }
}
