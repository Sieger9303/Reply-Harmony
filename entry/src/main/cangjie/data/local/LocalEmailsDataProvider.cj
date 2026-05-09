package ohos_app_cangjie_entry.data.local

import ohos_app_cangjie_entry.data.*

let parisAttachments: Array<EmailAttachment> = [
    EmailAttachment("paris_1", "Bridge in Paris"),
    EmailAttachment("paris_2", "Bridge in Paris at night"),
    EmailAttachment("paris_3", "City street in Paris"),
    EmailAttachment("paris_4", "Street with bike in Paris")
]

func makeThreadEmails(): Array<Email> {
    let me: Array<Account> = [LocalAccountsDataProvider.getDefaultUserAccount()]
    [
        Email(8, LocalAccountsDataProvider.getContactAccountByUid(13), me, "Your update on Google Play Store is live!", "Your update, 0.1.1, is now live on the Play Store and available for your alpha users to start testing.", [], false, false, MailboxType.TRASH, "3 hours ago", []),
        Email(5, LocalAccountsDataProvider.getContactAccountByUid(13), me, "Update to Your Itinerary", "", [], false, false, MailboxType.INBOX, "2 hours ago", []),
        Email(6, LocalAccountsDataProvider.getContactAccountByUid(10), me, "Recipe to try", "Raspberry Pie: We should make this pie recipe tonight! The filling is very quick to put together.", [], false, false, MailboxType.SENT, "2 hours ago", []),
        Email(7, LocalAccountsDataProvider.getContactAccountByUid(9), me, "Delivered", "Your shoes should be waiting for you at home!", [], false, false, MailboxType.INBOX, "2 hours ago", []),
        Email(9, LocalAccountsDataProvider.getContactAccountByUid(10), me, "(No subject)", "Hey, Wanted to email and see what you thought of", [], false, false, MailboxType.DRAFTS, "3 hours ago", []),
        Email(1, LocalAccountsDataProvider.getContactAccountByUid(6), me, "Brunch this weekend?", "I'll be in your neighborhood doing errands and was hoping to catch you for a coffee this Saturday.", [], false, false, MailboxType.INBOX, "40 mins ago", []),
        Email(2, LocalAccountsDataProvider.getContactAccountByUid(5), me, "Bonjour from Paris", "Here are some great shots from my trip...", parisAttachments, true, false, MailboxType.INBOX, "1 hour ago", [])
    ]
}

class LocalEmailsDataProvider {
    public static func getAllEmails(): Array<Email> {
        let me: Array<Account> = [LocalAccountsDataProvider.getDefaultUserAccount()]
        let threads = makeThreadEmails()
        [
            Email(0, LocalAccountsDataProvider.getContactAccountByUid(9), me, "Package shipped!", "Cucumber Mask Facial has shipped.", [], false, true, MailboxType.INBOX, "20 mins ago", threads),
            Email(1, LocalAccountsDataProvider.getContactAccountByUid(6), me, "Brunch this weekend?", "I'll be in your neighborhood doing errands and was hoping to catch you for a coffee this Saturday.", [], false, false, MailboxType.INBOX, "40 mins ago", threads),
            Email(2, LocalAccountsDataProvider.getContactAccountByUid(5), me, "Bonjour from Paris", "Here are some great shots from my trip...", parisAttachments, true, false, MailboxType.INBOX, "1 hour ago", threads),
            Email(3, LocalAccountsDataProvider.getContactAccountByUid(8), me, "High school reunion?", "Hi friends, I was at the grocery store on Sunday night when I ran into Genie Williams.", [], false, false, MailboxType.SENT, "2 hours ago", threads),
            Email(4, LocalAccountsDataProvider.getContactAccountByUid(11), me, "Brazil trip", "Thought we might be able to go over some details about our upcoming vacation.", [], false, true, MailboxType.INBOX, "2 hours ago", threads),
            Email(5, LocalAccountsDataProvider.getContactAccountByUid(13), me, "Update to Your Itinerary", "", [], false, false, MailboxType.INBOX, "2 hours ago", threads),
            Email(6, LocalAccountsDataProvider.getContactAccountByUid(10), me, "Recipe to try", "Raspberry Pie: We should make this pie recipe tonight! The filling is very quick to put together.", [], false, false, MailboxType.SENT, "2 hours ago", threads),
            Email(7, LocalAccountsDataProvider.getContactAccountByUid(9), me, "Delivered", "Your shoes should be waiting for you at home!", [], false, false, MailboxType.INBOX, "2 hours ago", threads),
            Email(8, LocalAccountsDataProvider.getContactAccountByUid(13), me, "Your update on Google Play Store is live!", "Your update, 0.1.1, is now live on the Play Store and available for your alpha users to start testing.", [], false, false, MailboxType.TRASH, "3 hours ago", threads),
            Email(9, LocalAccountsDataProvider.getContactAccountByUid(10), me, "(No subject)", "Hey, Wanted to email and see what you thought of", [], false, false, MailboxType.DRAFTS, "3 hours ago", threads),
            Email(10, LocalAccountsDataProvider.getContactAccountByUid(5), me, "Try a free TrailGo account", "Looking for the best hiking trails in your area?", [], false, false, MailboxType.TRASH, "3 hours ago", threads),
            Email(11, LocalAccountsDataProvider.getContactAccountByUid(5), me, "Free money", "You've been selected as a winner in our latest raffle!", [], false, false, MailboxType.SPAM, "3 hours ago", threads)
        ]
    }

    public static func get(id: Int64): ?Email {
        for (email in getAllEmails()) {
            if (email.id == id) {
                return email
            }
        }
        None
    }

    public static func getAllFolders(): Array<String> {
        ["Receipts", "Pine Elementary", "Taxes", "Vacation", "Mortgage", "Grocery coupons"]
    }
}