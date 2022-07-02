import Combine

precedencegroup DisposePrecedence {
    associativity: left

    lowerThan: DefaultPrecedence
}

infix operator => : DisposePrecedence

public typealias CombineBag = Set<AnyCancellable>

extension AnyCancellable {

    public static func => (cancelable: AnyCancellable, collection: inout Set<AnyCancellable>) {
        cancelable.store(in: &collection)
    }
    
}

infix operator ~> : DefaultPrecedence

extension AnyPublisher where Failure == Never {

    public static func ~> (publisher: AnyPublisher<Output, Never>, subject: CurrentValueSubject<Output, Never>) -> AnyCancellable {
        return publisher.assign(to: \.value, on: subject)
    }
    
}
