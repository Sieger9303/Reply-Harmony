package ohos_app_cangjie_entry.ui

import std.collection.*
import ohos_app_cangjie_entry.data.*
import ohos_app_cangjie_entry.ui.utils.*

public class ReplyHomeUIState {
    public let emails: Array<Email>
    public let selectedEmails: Array<Int64>
    public let openedEmail: ?Email
    public let isDetailOnlyOpen: Bool
    public let loading: Bool
    public let error: ?String

    public init(
        emails: Array<Email>,
        selectedEmails: Array<Int64>,
        openedEmail: ?Email,
        isDetailOnlyOpen: Bool,
        loading: Bool,
        error: ?String
    ) {
        this.emails = emails
        this.selectedEmails = selectedEmails
        this.openedEmail = openedEmail
        this.isDetailOnlyOpen = isDetailOnlyOpen
        this.loading = loading
        this.error = error
    }
}

public class ReplyHomeStateHolder {
    public var uiState = ReplyHomeUIState([], [], Option<Email>.None, false, true, Option<String>.None)
    let emailsRepository: EmailsRepository

    public init(emailsRepository: EmailsRepository) {
        this.emailsRepository = emailsRepository
        observeEmails()
    }

    private func observeEmails(): Unit {
        let emails = emailsRepository.getAllEmails()
        let opened: ?Email = if (emails.size > 0) { emails[0] } else { Option<Email>.None }
        uiState = ReplyHomeUIState(emails, [], opened, false, false, Option<String>.None)
    }

    public func setOpenedEmail(emailId: Int64, contentType: ReplyContentType): Unit {
        var selected: ?Email = Option<Email>.None
        for (email in uiState.emails) {
            if (email.id == emailId) {
                selected = email
                break
            }
        }
        uiState = ReplyHomeUIState(
            uiState.emails,
            uiState.selectedEmails,
            selected,
            contentType == ReplyContentType.SINGLE_PANE,
            false,
            uiState.error
        )
    }

    public func toggleSelectedEmail(emailId: Int64): Unit {
        var nextList = ArrayList<Int64>()
        var found = false
        for (id in uiState.selectedEmails) {
            if (id == emailId) {
                found = true
            } else {
                nextList.add(id)
            }
        }
        if (!found) {
            nextList.add(emailId)
        }
        uiState = ReplyHomeUIState(uiState.emails, nextList.toArray(), uiState.openedEmail, uiState.isDetailOnlyOpen, false, uiState.error)
    }

    public func closeDetailScreen(): Unit {
        let opened: ?Email = if (uiState.emails.size > 0) { uiState.emails[0] } else { Option<Email>.None }
        uiState = ReplyHomeUIState(uiState.emails, uiState.selectedEmails, opened, false, false, uiState.error)
    }
}