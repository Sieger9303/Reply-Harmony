package ohos_app_cangjie_entry.data.local

import std.collection.*
import ohos_app_cangjie_entry.data.*

public class EmailsRepositoryImpl <: EmailsRepository {
    public func getAllEmails(): Array<Email> {
        LocalEmailsDataProvider.getAllEmails()
    }

    public func getCategoryEmails(category: MailboxType): Array<Email> {
        var results = ArrayList<Email>()
        for (email in LocalEmailsDataProvider.getAllEmails()) {
            if (email.mailbox == category) {
                results.add(email)
            }
        }
        results.toArray()
    }

    public func getAllFolders(): Array<String> {
        LocalEmailsDataProvider.getAllFolders()
    }

    public func getEmailFromId(id: Int64): ?Email {
        LocalEmailsDataProvider.get(id)
    }
}