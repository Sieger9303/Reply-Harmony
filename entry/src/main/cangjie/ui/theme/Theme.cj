package ohos_app_cangjie_entry.ui.theme

public struct ReplyThemeTokens {
    public let darkTheme: Bool
    public init(darkTheme: Bool) {
        this.darkTheme = darkTheme
    }
}

public func replyTheme(darkTheme: Bool): ReplyThemeTokens {
    ReplyThemeTokens(darkTheme)
}