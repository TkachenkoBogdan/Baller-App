import Foundation

final class BallModel {

    private let answerService: AnswerProvider

    var isLoadingDataStateHandler: ((Bool) -> Void)?

    init(provider: AnswerProvider) {
        self.answerService = provider
    }

    func getAnswer(completion: @escaping(Answer) -> Void) {
        isLoadingData = true

        self.answerService.getAnswer { (result) in

            self.isLoadingData = false
                switch result {
                case .success(let answer):
                    completion(answer)
                case .failure:
                    preconditionFailure(L10n.FatalErrors.noLocadAnswer)
                }
        }

    }

    private var isLoadingData = false {
        didSet {
            isLoadingDataStateHandler?(isLoadingData)
        }
    }

}
