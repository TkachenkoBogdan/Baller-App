import Foundation

class BallModel {

    private let answerProvider: AnswerProviding

    var isLoadingDataStateHandler: ((Bool) -> Void)?

    init(with provider: AnswerProviding) {
        self.answerProvider = provider
    }

    func getAnswer(completion: @escaping(PersistableAnswer) -> Void) {
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
