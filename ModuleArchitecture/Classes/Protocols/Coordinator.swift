public protocol CoordinatorType: AnyObject {
    
    func start()
    func attach(_ child: CoordinatorType)
    func detach(_ child: CoordinatorType)
}

public protocol ViewableCoordinatorType: CoordinatorType {
    
    var viewController: ViewControllerType { get }
}

public protocol ReusableCoordinatorType: CoordinatorType {

    func prepareForReuse()
}

open class Coordinator<Presentable>: CoordinatorType {

    private var children: [CoordinatorType] = []

    private let presenterType: PresenterType

    public let presenter: Presentable

    public init(presenter: Presentable) {

        guard let presenterType = presenter as? PresenterType else { fatalError() }
        self.presenterType = presenterType
        self.presenter = presenter
    }

    open func start() {

        self.presenterType.start()
    }

    public func attach(_ child: CoordinatorType) {

        self.children.append(child)
    }

    public func detach(_ child: CoordinatorType) {

        guard let index = self.children.firstIndex(where: { $0 === child }) else { return }
        self.children.remove(at: index)
    }
}
