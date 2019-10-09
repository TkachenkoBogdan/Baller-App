import Foundation

final class BallModel {

    // MARK: - Dependencies:

    private let answerService: AnswerProvider
    private let secureStorage: SecureStoring

    // MARK: - Init:

    init(provider: AnswerProvider, secureStorage: SecureStoring) {
        self.answerService = provider
        self.secureStorage = secureStorage
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

        self.answerService.getAnswer { (result) in

            self.isLoadingData = false
            switch result {
            case .success(let answer):
                completion(answer)
            case .failure:
                preconditionFailure(L10n.FatalErrors.noLocalAnswer)
            }
        }

    }

    // MARK: - Private:

    private func incrementAttemptsCount() {
        attemptsCount += 1
        secureStorage.set(attemptsCount, forKey: AppConstants.shakeAttempts)
        countUpdatedHandler?(attemptsCount)
    }

    private func setupAttemptsCount() -> Int {
        guard let count = secureStorage.value(forKey: AppConstants.shakeAttempts) else {
            secureStorage.set(0, forKey: AppConstants.shakeAttempts)
            return 0
        }
        return count
    }

}
