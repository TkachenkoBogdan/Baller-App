import Foundation

final class BallModel {

    private enum Keys: String {
       case shakeAttempts
    }

    // MARK: - Dependencies:

    private let answerService: AnswerProvider
    private let secureStorage: SecureStoring
    private let store: AnswerStore

    // MARK: - Init:

    init(provider: AnswerProvider, store: AnswerStore, secureStorage: SecureStoring) {
        self.answerService = provider
        self.secureStorage = secureStorage
        self.store = store

        self.attemptsCount = setupAttemptsCount()
    }

    // MARK: - Properties:

    private var attemptsCount: Int = 0

    var countUpdatedHandler: ((Int) -> Void)? {
        didSet {
            countUpdatedHandler?(attemptsCount)
        }
    }

    private var isLoadingData = false {
        didSet {
            isLoadingDataStateHandler?(isLoadingData)
        }
    }

    var isLoadingDataStateHandler: ((Bool) -> Void)?

    // MARK: - Logic:

    func getAnswer(completion: @escaping(Answer) -> Void) {
        isLoadingData = true
        incrementAttemptsCount()

        self.answerService.getAnswer { (result, isLocal) in

            self.isLoadingData = false
            switch result {
            case .success(let answer):
                if !isLocal {
                    self.store.appendAnswer(answer)
                }
                completion(answer)
            case .failure:
                preconditionFailure(L10n.FatalErrors.noLocalAnswer)
            }
        }

    }

    // MARK: - Private:

    private func incrementAttemptsCount() {
        attemptsCount += 1
        secureStorage.set(attemptsCount, forKey: Keys.shakeAttempts.rawValue)
        countUpdatedHandler?(attemptsCount)
    }

    private func setupAttemptsCount() -> Int {
        guard let count = secureStorage.value(forKey: Keys.shakeAttempts.rawValue) else {
            secureStorage.set(0, forKey: Keys.shakeAttempts.rawValue)
            return 0
        }
        return count
    }

}
