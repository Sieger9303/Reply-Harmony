package ohos_app_cangjie_entry.data.local

import ohos_app_cangjie_entry.data.*

class AccountsRepositoryImpl <: AccountsRepository {
    public func getDefaultUserAccount(): Account {
        LocalAccountsDataProvider.getDefaultUserAccount()
    }

    public func getAllUserAccounts(): Array<Account> {
        LocalAccountsDataProvider.getAllUserAccounts()
    }

    public func getContactAccountByUid(uid: Int64): Account {
        LocalAccountsDataProvider.getContactAccountByUid(uid)
    }
}