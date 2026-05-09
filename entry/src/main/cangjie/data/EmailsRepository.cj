package ohos_app_cangjie_entry.data

public interface EmailsRepository {
    func getAllEmails(): Array<Email>
    func getCategoryEmails(category: MailboxType): Array<Email>
    func getAllFolders(): Array<String>
    func getEmailFromId(id: Int64): ?Email
}