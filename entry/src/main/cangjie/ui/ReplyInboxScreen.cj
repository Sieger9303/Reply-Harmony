package ohos_app_cangjie_entry.ui

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import std.collection.*
import ohos_app_cangjie_entry.data.*
import ohos_app_cangjie_entry.ui.components.*
import ohos_app_cangjie_entry.ui.theme.*
import ohos_app_cangjie_entry.ui.utils.*

func containsQuery(text: String, query: String): Bool {
    if (query.isEmpty()) {
        return true
    }
    text.contains(query)
}

@Component
public class ReplyInboxScreen {
    @Link var homeState: ReplyHomeStateHolder
    @Prop var contentType: ReplyContentType
    @State var query: String = ""
    @State var searchExpanded: Bool = false

    func isDualPane(): Bool {
        this.contentType == ReplyContentType.DUAL_PANE
    }

    func filteredEmails(): Array<Email> {
        var result = ArrayList<Email>()
        for (email in this.homeState.uiState.emails) {
            if (containsQuery(email.subject, this.query) || containsQuery(email.sender.fullName, this.query)) {
                result.add(email)
            }
        }
        result.toArray()
    }

    func currentEmail(): Email {
        match (this.homeState.uiState.openedEmail) {
            case Some(opened) => opened
            case _ => this.homeState.uiState.emails[0]
        }
    }

    func openEmail(email: Email): Unit {
        this.homeState.setOpenedEmail(email.id, this.contentType)
    }

    public func build() {
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
                            ForEach(this.homeState.uiState.emails, itemGeneratorFunc: { email: Email, _: Int64 =>
                                if (containsQuery(email.subject, this.query) || containsQuery(email.sender.fullName, this.query)) {
                                    Column() {
                                        BuildEmailListItem(
                                            email,
                                            this.currentEmail().id == email.id,
                                            this.homeState.uiState.selectedEmails.contains(email.id),
                                            { => this.openEmail(email) },
                                            { => this.homeState.toggleSelectedEmail(email.id) }
                                        )
                                    }
                                    .width(100.percent)
                                    .margin(left: 12, right: 12, top: 4, bottom: 4)
                                }
                            })
                        }
                        .width(100.percent)
                    }
                    .layoutWeight(1)
                }
                .width(100.percent)
                .height(100.percent)
            }
            .span(GridColOptions(xs: 12, sm: 12, md: if (this.homeState.uiState.isDetailOnlyOpen) { 0 } else { 12 }, lg: 5, xl: 5, xxl: 5))

            if (this.isDualPane() || this.homeState.uiState.isDetailOnlyOpen) {
                GridCol() {
                    Column() {
                        BuildEmailDetailHeader(this.currentEmail(), !this.isDualPane(), { => this.homeState.closeDetailScreen() })

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
                .span(GridColOptions(xs: 12, sm: 12, md: 12, lg: 7, xl: 7, xxl: 7))
            }
        }
        .width(100.percent)
        .height(100.percent)
    }
}