package ohos_app_cangjie_entry.ui.navigation

import std.deriving.*

@Derive[Equatable]
public enum Route {
    | Inbox | Articles | DirectMessages | Groups
}

public struct ReplyTopLevelDestination {
    public ReplyTopLevelDestination(public let route: Route, public let icon: String) {}
}

public let TOP_LEVEL_DESTINATIONS: Array<ReplyTopLevelDestination> = [
    ReplyTopLevelDestination(Route.Inbox, "ic_inbox"),
    ReplyTopLevelDestination(Route.Articles, "ic_article"),
    ReplyTopLevelDestination(Route.DirectMessages, "ic_chat_bubble_outline"),
    ReplyTopLevelDestination(Route.Groups, "ic_group")
]