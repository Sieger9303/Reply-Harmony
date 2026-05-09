package ohos_app_cangjie_entry.data

public struct Account {
    public Account(
        public let id: Int64,
        public let uid: Int64,
        public let firstName: String,
        public let lastName: String,
        public let email: String,
        public let altEmail: String,
        public let avatar: String,
        public var isCurrentAccount: Bool
    ) {}

    public prop fullName: String {
        get() {
            "${firstName} ${lastName}"
        }
    }
}