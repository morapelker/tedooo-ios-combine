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

extension Array where Element == AnyCancellable {

    public static func => (cancelable: [AnyCancellable], collection: inout Set<AnyCancellable>) {
        for cancellable in cancelable {
            cancellable.store(in: &collection)
        }
    }
    
}

infix operator ~> : DefaultPrecedence

extension AnyPublisher where Failure == Never {

    public static func ~> (publisher: AnyPublisher<Output, Never>, subject: CurrentValueSubject<Output, Never>) -> AnyCancellable {
        return publisher.assign(to: \.value, on: subject)
    }
    
}

infix operator <~> : DefaultPrecedence

extension UITextField {

    public static func <~> (publisher: UITextField, subject: CurrentValueSubject<String?, Never>) -> [AnyCancellable] {
        let c1 = publisher.textPublisher.sink { text in
            subject.send(text)
        }
        let c2 = subject.sink { [weak publisher] newText in
            guard let self = publisher else { return }
            if self.text != newText {
                self.text = newText
            }
        }
        return [c1, c2]
    }
    
}


extension UITextView {

    public static func <~> (publisher: UITextView, subject: CurrentValueSubject<String?, Never>) -> [AnyCancellable] {
        let c1 = publisher.textPublisher.sink { text in
            subject.send(text)
        }
        let c2 = subject.sink { [weak publisher] newText in
            guard let self = publisher else { return }
            if self.text != newText {
                self.text = newText
            }
        }
        return [c1, c2]
    }
    
}

public extension Publisher {
    func withPrevious() -> AnyPublisher<(previous: Output?, current: Output), Failure> {
        scan(Optional<(Output?, Output)>.none) { ($0?.1, $1) }
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
}
