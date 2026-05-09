package ohos_app_cangjie_entry.ui.navigation

public class ReplyNavigationController {
    public var currentRoute: Route

    public init(currentRoute: Route) {
        this.currentRoute = currentRoute
    }

    public func navigateTo(route: Route): Unit {
        this.currentRoute = route
    }
}