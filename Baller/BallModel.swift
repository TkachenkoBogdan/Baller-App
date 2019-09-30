import Foundation

final class BallModel {

    private let answerProvider: AnswerService

    var isLoadingDataStateHandler: ((Bool) -> Void)?

    init(with provider: AnswerService) {
        self.answerProvider = provider
    }

    func getAnswer(completion: @escaping(Answer) -> Void) {
        isLoadingData = true

        self.answerProvider.getAnswer { (result) in

            self.isLoadingData = false
                switch result {
                case .success(let answer):
                    completion(answer)
                case .failure:
                    preconditionFailure("Failed to provide local answer")
                }
        }

    }

    private var isLoadingData = false {
        didSet {
            isLoadingDataStateHandler?(isLoadingData)
        }
    }

}
