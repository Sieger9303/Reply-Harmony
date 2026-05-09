package ohos_app_cangjie_entry.ui.utils

import std.deriving.*

@Derive[Equatable]
public enum ReplyNavigationType {
    | BOTTOM_NAVIGATION | NAVIGATION_RAIL | PERMANENT_NAVIGATION_DRAWER
}

@Derive[Equatable]
public enum ReplyNavigationContentPosition {
    | TOP | CENTER
}

@Derive[Equatable]
public enum ReplyContentType {
    | SINGLE_PANE | DUAL_PANE
}

public struct ReplyAdaptiveLayoutState {
    public ReplyAdaptiveLayoutState(
        public let navigationType: ReplyNavigationType,
        public let navigationContentPosition: ReplyNavigationContentPosition,
        public let contentType: ReplyContentType
    ) {}
}

public func isCompactBreakpoint(breakpoint: String): Bool {
    breakpoint == "xs" || breakpoint == "sm"
}

public func isExpandedBreakpoint(breakpoint: String): Bool {
    breakpoint == "lg" || breakpoint == "xl" || breakpoint == "xxl"
}

public func contentTypeForBreakpoint(breakpoint: String): ReplyContentType {
    if (isExpandedBreakpoint(breakpoint)) {
        return ReplyContentType.DUAL_PANE
    }
    ReplyContentType.SINGLE_PANE
}

public func navigationTypeForBreakpoint(breakpoint: String, windowWidth: Float64): ReplyNavigationType {
    if (isCompactBreakpoint(breakpoint)) {
        return ReplyNavigationType.BOTTOM_NAVIGATION
    }
    if (windowWidth >= 1200.0) {
        return ReplyNavigationType.PERMANENT_NAVIGATION_DRAWER
    }
    ReplyNavigationType.NAVIGATION_RAIL
}

public func navigationContentPositionForBreakpoint(breakpoint: String): ReplyNavigationContentPosition {
    if (breakpoint == "xs") {
        return ReplyNavigationContentPosition.TOP
    }
    ReplyNavigationContentPosition.CENTER
}

public func adaptiveLayoutStateForWindow(breakpoint: String, windowWidth: Float64): ReplyAdaptiveLayoutState {
    ReplyAdaptiveLayoutState(
        navigationTypeForBreakpoint(breakpoint, windowWidth),
        navigationContentPositionForBreakpoint(breakpoint),
        contentTypeForBreakpoint(breakpoint)
    )
}
