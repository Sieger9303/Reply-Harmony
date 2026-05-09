package ohos_app_cangjie_entry.data

import std.deriving.*

@Derive[Equatable]
public enum MailboxType {
    | INBOX | DRAFTS | SENT | SPAM | TRASH
}