package ohos_app_cangjie_entry.data.local

import ohos_app_cangjie_entry.data.*

let localUserAccounts: Array<Account> = [
    Account(1, 0, "Jeff", "Hansen", "hikingfan@gmail.com", "hkngfan@outside.com", "avatar_10", true),
    Account(2, 0, "Jeff", "H", "jeffersonloveshiking@gmail.com", "jeffersonloveshiking@work.com", "avatar_2", false),
    Account(3, 0, "Jeff", "Hansen", "jeffersonc@google.com", "jeffersonc@gmail.com", "avatar_9", false)
]

let localContactAccounts: Array<Account> = [
    Account(4, 1, "Tracy", "Alvarez", "tracealvie@gmail.com", "tracealvie@gravity.com", "avatar_1", false),
    Account(5, 2, "Allison", "Trabucco", "atrabucco222@gmail.com", "atrabucco222@work.com", "avatar_3", false),
    Account(6, 3, "Ali", "Connors", "aliconnors@gmail.com", "aliconnors@android.com", "avatar_5", false),
    Account(7, 4, "Alberto", "Williams", "albertowilliams124@gmail.com", "albertowilliams124@chromeos.com", "avatar_0", false),
    Account(8, 5, "Kim", "Alen", "alen13@gmail.com", "alen13@mountainview.gov", "avatar_7", false),
    Account(9, 6, "Google", "Express", "express@google.com", "express@gmail.com", "avatar_express", false),
    Account(10, 7, "Sandra", "Adams", "sandraadams@gmail.com", "sandraadams@textera.com", "avatar_2", false),
    Account(11, 8, "Trevor", "Hansen", "trevorhandsen@gmail.com", "trevorhandsen@express.com", "avatar_8", false),
    Account(12, 9, "Sean", "Holt", "sholt@gmail.com", "sholt@art.com", "avatar_6", false),
    Account(13, 10, "Frank", "Hawkins", "fhawkank@gmail.com", "fhawkank@thisisme.com", "avatar_4", false)
]

class LocalAccountsDataProvider {
    public static func getDefaultUserAccount(): Account {
        localUserAccounts[0]
    }

    public static func getAllUserAccounts(): Array<Account> {
        localUserAccounts
    }

    public static func isUserAccount(uid: Int64): Bool {
        for (account in localUserAccounts) {
            if (account.uid == uid) {
                return true
            }
        }
        false
    }

    public static func getContactAccountByUid(accountId: Int64): Account {
        for (account in localContactAccounts) {
            if (account.id == accountId) {
                return account
            }
        }
        localContactAccounts[0]
    }
}