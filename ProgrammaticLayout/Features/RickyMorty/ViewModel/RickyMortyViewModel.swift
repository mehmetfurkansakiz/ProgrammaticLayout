
import Foundation

protocol IRickyMortyViewModel {
    func fetchItems()
    func changeLoading()
    
    var rickyMortyCharacters: [Result] { get set }
    var rickyMortyService: IRickyMortyService { get }
    
    var rickyMortyOutput: RickyMortyOutput? { get }
    
    func setDelegate(output: RickyMortyOutput)
}

final class RickyMortyViewModel: IRickyMortyViewModel {
    var rickyMortyOutput: RickyMortyOutput?
    
    func setDelegate(output: RickyMortyOutput) {
        rickyMortyOutput = output
    }
    
    
    var rickyMortyCharacters: [Result] = []
    private var isLoading = false
    let rickyMortyService: IRickyMortyService
    
    init() {
        rickyMortyService = RickyMortyService()
    }
    
    func fetchItems() {
        changeLoading()
        rickyMortyService.fetchAllDatas { [weak self] response in
            self?.changeLoading()
            self?.rickyMortyCharacters = response ?? []
            self?.rickyMortyOutput?.saveDatas(values: self?.rickyMortyCharacters ?? [])
        }
    }
    
    func changeLoading() {
        isLoading = !isLoading
        rickyMortyOutput?.changeLoading(isLoad: isLoading)
    }
    
}
