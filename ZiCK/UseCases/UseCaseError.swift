enum UseCaseError: Error {
    
    enum InvalidReason {
        case failedValidation
        case duplicate
    }
    
    case invalidAuthentication
    case invalidAuthorization
    case invalidValues(reason: InvalidReason)
    case internalFailure
    
    init(from apiError: APIError) {
        switch apiError {
        case .badRequest:
            self = UseCaseError.invalidValues(reason: .failedValidation)
        case .forbidden:
            self = UseCaseError.invalidAuthorization
        case .internalServerError:
            self = UseCaseError.internalFailure
        case .notFound:
            self = UseCaseError.invalidValues(reason: .failedValidation)
        case .conflict:
            self = UseCaseError.invalidValues(reason: .duplicate)
        case .unAuthorized:
            self = UseCaseError.invalidAuthentication
        }
    }
    
}
