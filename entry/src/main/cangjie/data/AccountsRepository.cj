package ohos_app_cangjie_entry.data

public interface AccountsRepository {
    func getDefaultUserAccount(): Account
    func getAllUserAccounts(): Array<Account>
    func getContactAccountByUid(uid: Int64): Account
}