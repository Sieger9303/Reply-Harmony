package ohos_app_cangjie_entry.data

public class Email {
    public let id: Int64
    public let sender: Account
    public let recipients: Array<Account>
    public let subject: String
    public let body: String
    public let attachments: Array<EmailAttachment>
    public var isImportant: Bool
    public var isStarred: Bool
    public var mailbox: MailboxType
    public let createdAt: String
    public let threads: Array<Email>

    public init(
        id: Int64,
        sender: Account,
        recipients: Array<Account>,
        subject: String,
        body: String,
        attachments: Array<EmailAttachment>,
        isImportant: Bool,
        isStarred: Bool,
        mailbox: MailboxType,
        createdAt: String,
        threads: Array<Email>
    ) {
        this.id = id
        this.sender = sender
        this.recipients = recipients
        this.subject = subject
        this.body = body
        this.attachments = attachments
        this.isImportant = isImportant
        this.isStarred = isStarred
        this.mailbox = mailbox
        this.createdAt = createdAt
        this.threads = threads
    }
}