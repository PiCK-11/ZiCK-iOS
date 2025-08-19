enum UseCaseError: Error {
    
    case invalidAuthentication
    case invalidAuthorization
    case invalidValues
    case internalFailure
    
    init(from apiError: APIError) {
        switch apiError {
        case .badRequest:
            self = UseCaseError.invalidValues
        case .forbidden:
            self = UseCaseError.invalidAuthorization
        case .internalServerError:
            self = UseCaseError.internalFailure
        case .notFound:
            self = UseCaseError.invalidValues
        case .unAuthorized:
            self = UseCaseError.invalidAuthentication
        }
    }
    
}
