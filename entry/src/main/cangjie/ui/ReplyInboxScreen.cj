package ohos_app_cangjie_entry.ui

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import std.collection.*
import std.unicode.*
import ohos_app_cangjie_entry.data.*
import ohos_app_cangjie_entry.ui.components.*
import ohos_app_cangjie_entry.ui.theme.*
import ohos_app_cangjie_entry.ui.utils.*

func startsWithIgnoreCase(text: String, query: String): Bool {
    if (query.isEmpty()) {
        return true
    }
    text.toLower().startsWith(query.toLower())
}

@Component
public class ReplyInboxScreen {
    @Prop var homeState: ReplyHomeStateHolder
    @Prop var uiState: ReplyHomeUIState
    @Prop var contentType: ReplyContentType
    @Prop var onUiStateChange: (ReplyHomeUIState) -> Unit
    @State var query: String = ""
    @State var searchExpanded: Bool = false
    @State var selectedEmailIds: Array<Int64> = []
    @State var openedEmailId: Int64 = -1
    @State var detailOnlyOpen: Bool = false
    @State var refreshVersion: Int64 = 0

    func isDualPane(): Bool {
        this.contentType == ReplyContentType.DUAL_PANE
    }

    func copySelectedEmailIds(ids: Array<Int64>): Array<Int64> {
        var copied = ArrayList<Int64>()
        for (id in ids) {
            copied.add(id)
        }
        copied.toArray()
    }

    func syncLocalUiState(state: ReplyHomeUIState): Unit {
        this.selectedEmailIds = this.copySelectedEmailIds(state.selectedEmails)
        this.detailOnlyOpen = state.isDetailOnlyOpen
        match (state.openedEmail) {
            case Some(opened) => this.openedEmailId = opened.id
            case _ =>
                if (state.emails.size > 0) {
                    this.openedEmailId = state.emails[0].id
                } else {
                    this.openedEmailId = -1
                }
        }
    }

    func emailItemKey(email: Email): String {
        let selectedPart = if (this.selectedEmailIds.contains(email.id)) { "selected" } else { "normal" }
        let openedPart = if (this.openedEmailId == email.id) { "opened" } else { "closed" }
        email.id.toString() + "_" + selectedPart + "_" + openedPart + "_" + this.refreshVersion.toString()
    }

    func filteredEmails(): Array<Email> {
        var result = ArrayList<Email>()
        for (email in this.uiState.emails) {
            if (startsWithIgnoreCase(email.subject, this.query) || startsWithIgnoreCase(email.sender.fullName, this.query)) {
                result.add(email)
            }
        }
        result.toArray()
    }

    func currentEmail(): Email {
        for (email in this.uiState.emails) {
            if (email.id == this.openedEmailId) {
                return email
            }
        }
        this.uiState.emails[0]
    }

    func pushUiState(): Unit {
        let nextState = this.homeState.uiState
        this.syncLocalUiState(nextState)
        this.refreshVersion = this.refreshVersion + 1
        this.onUiStateChange(nextState)
    }

    func openEmail(email: Email): Unit {
        this.homeState.setOpenedEmail(email.id, this.contentType)
        this.pushUiState()
    }

    func toggleSelectedEmail(email: Email): Unit {
        this.homeState.toggleSelectedEmail(email.id)
        this.pushUiState()
    }

    func closeDetailScreen(): Unit {
        this.homeState.closeDetailScreen()
        this.pushUiState()
    }

    public func build() {
        if (this.isDualPane()) {
            GridRow(
                columns: 12,
                gutter: GutterOption(x: 12.vp, y: 0.vp),
                breakpoints: BreakPoints(value: [600.vp, 840.vp, 1200.vp], reference: BreakpointsReference.WindowSize),
                direction: GridRowDirection.Row
            ) {
                GridCol() {
                    Column() {
                        BuildReplyDockedSearchBar(
                            this.filteredEmails(),
                            this.query,
                            this.searchExpanded,
                            { value: String => this.query = value },
                            { expanded: Bool => this.searchExpanded = expanded },
                            { email: Email => this.openEmail(email) }
                        )

                        Scroll() {
                            Column() {
                                ForEach(
                                    this.filteredEmails(),
                                    itemGeneratorFunc: { email: Email, _: Int64 =>
                                        if (startsWithIgnoreCase(email.subject, this.query) || startsWithIgnoreCase(email.sender.fullName, this.query)) {
                                            Column() {
                                                BuildEmailListItem(
                                                    email,
                                                    this.openedEmailId == email.id,
                                                    this.selectedEmailIds.contains(email.id),
                                                    { => this.openEmail(email) },
                                                    { => this.toggleSelectedEmail(email) }
                                                )
                                            }
                                            .width(100.percent)
                                            .margin(left: 12, right: 12, top: 4, bottom: 4)
                                        }
                                    },
                                    keyGeneratorFunc: { email: Email, _: Int64 =>
                                        this.emailItemKey(email)
                                    }
                                )
                            }
                            .width(100.percent)
                        }
                        .layoutWeight(1)
                    }
                    .width(100.percent)
                    .height(100.percent)
                }
                .span(GridColOptions(xs: 12, sm: 12, md: 5, lg: 5, xl: 5, xxl: 5))

                GridCol() {
                    Column() {
                        BuildEmailDetailHeader(this.currentEmail(), false, { => this.closeDetailScreen() })

                        Scroll() {
                            Column() {
                                if (this.currentEmail().attachments.size > 0) {
                                    Row() {
                                        ForEach(this.currentEmail().attachments, itemGeneratorFunc: { attachment: EmailAttachment, _: Int64 =>
                                            Column() {
                                                Image(mediaResourceForName(attachment.mediaKey))
                                                    .width(120)
                                                    .height(90)
                                                    .borderRadius(12)
                                                Text(attachment.contentDesc)
                                                    .fontSize(10)
                                                    .fontColor(REPLY_ON_SURFACE_VARIANT)
                                                    .maxLines(2)
                                                    .textOverflow(TextOverflow.Ellipsis)
                                                    .margin(top: 6)
                                            }
                                            .width(120)
                                            .padding(8)
                                            .backgroundColor(REPLY_ATTACHMENT)
                                            .borderRadius(12)
                                            .margin(right: 8)
                                        })
                                    }
                                    .margin(left: 16, right: 16, bottom: 12)
                                }
                                ForEach(this.currentEmail().threads, itemGeneratorFunc: { thread: Email, _: Int64 =>
                                    Column() {
                                        BuildEmailThreadItem(thread)
                                    }
                                    .margin(left: 16, right: 16, bottom: 8)
                                })
                            }
                            .width(100.percent)
                        }
                        .layoutWeight(1)
                    }
                    .width(100.percent)
                    .height(100.percent)
                    .backgroundColor(REPLY_SURFACE)
                }
                .span(GridColOptions(xs: 12, sm: 12, md: 7, lg: 7, xl: 7, xxl: 7))
            }
            .width(100.percent)
            .height(100.percent)
            .onAppear({ => this.syncLocalUiState(this.uiState) })
        } else if (this.detailOnlyOpen && this.uiState.emails.size > 0) {
            Column() {
                BuildEmailDetailHeader(this.currentEmail(), true, { => this.closeDetailScreen() })

                Scroll() {
                    Column() {
                        if (this.currentEmail().attachments.size > 0) {
                            Row() {
                                ForEach(this.currentEmail().attachments, itemGeneratorFunc: { attachment: EmailAttachment, _: Int64 =>
                                    Column() {
                                        Image(mediaResourceForName(attachment.mediaKey))
                                            .width(120)
                                            .height(90)
                                            .borderRadius(12)
                                        Text(attachment.contentDesc)
                                            .fontSize(10)
                                            .fontColor(REPLY_ON_SURFACE_VARIANT)
                                            .maxLines(2)
                                            .textOverflow(TextOverflow.Ellipsis)
                                            .margin(top: 6)
                                    }
                                    .width(120)
                                    .padding(8)
                                    .backgroundColor(REPLY_ATTACHMENT)
                                    .borderRadius(12)
                                    .margin(right: 8)
                                })
                            }
                            .margin(left: 16, right: 16, bottom: 12)
                        }
                        ForEach(this.currentEmail().threads, itemGeneratorFunc: { thread: Email, _: Int64 =>
                            Column() {
                                BuildEmailThreadItem(thread)
                            }
                            .margin(left: 16, right: 16, bottom: 8)
                        })
                    }
                    .width(100.percent)
                }
                .layoutWeight(1)
            }
            .width(100.percent)
            .height(100.percent)
            .backgroundColor(REPLY_SURFACE)
            .onAppear({ => this.syncLocalUiState(this.uiState) })
        } else {
            Column() {
                BuildReplyDockedSearchBar(
                    this.filteredEmails(),
                    this.query,
                    this.searchExpanded,
                    { value: String => this.query = value },
                    { expanded: Bool => this.searchExpanded = expanded },
                    { email: Email => this.openEmail(email) }
                )

                Scroll() {
                    Column() {
                        ForEach(
                            this.filteredEmails(),
                            itemGeneratorFunc: { email: Email, _: Int64 =>
                                if (startsWithIgnoreCase(email.subject, this.query) || startsWithIgnoreCase(email.sender.fullName, this.query)) {
                                    Column() {
                                        BuildEmailListItem(
                                            email,
                                            this.openedEmailId == email.id,
                                            this.selectedEmailIds.contains(email.id),
                                            { => this.openEmail(email) },
                                            { => this.toggleSelectedEmail(email) }
                                        )
                                    }
                                    .width(100.percent)
                                    .margin(left: 12, right: 12, top: 4, bottom: 4)
                                }
                            },
                            keyGeneratorFunc: { email: Email, _: Int64 =>
                                this.emailItemKey(email)
                            }
                        )
                    }
                    .width(100.percent)
                }
                .layoutWeight(1)
            }
            .width(100.percent)
            .height(100.percent)
            .onAppear({ => this.syncLocalUiState(this.uiState) })
        }
    }
}