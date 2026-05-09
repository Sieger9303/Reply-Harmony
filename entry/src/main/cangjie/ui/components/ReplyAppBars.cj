package ohos_app_cangjie_entry.ui.components

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos.resource.*
import ohos_app_cangjie_entry.data.*
import ohos_app_cangjie_entry.ui.theme.*

@Builder
public func BuildReplyDockedSearchBar(
    filteredEmails: Array<Email>,
    query: String,
    expanded: Bool,
    onQueryChange: (String) -> Unit,
    onExpandedChange: (Bool) -> Unit,
    onSearchItemSelected: (Email) -> Unit
): Unit {
    Column() {
        Row() {
            Row() {
                if (expanded) {
                    Image(mediaResourceForName("ic_arrow_back"))
                        .width(18)
                        .height(18)
                        .fillColor(REPLY_OUTLINE)
                } else {
                    Image(mediaResourceForName("ic_search"))
                        .width(18)
                        .height(18)
                        .fillColor(REPLY_OUTLINE)
                }
            }
            .width(32)
            .height(32)
            .justifyContent(FlexAlign.Center)
            .onClick({ _ =>
                if (expanded) {
                    onQueryChange("")
                    onExpandedChange(false)
                } else {
                    onExpandedChange(true)
                }
            })

            Search(value: query, placeholder: @r(app.string.search_emails))
                .searchButton(@r(app.string.search))
                .layoutWeight(1)
                .onClick({ _ => onExpandedChange(true) })
                .onChange({ value =>
                    onQueryChange(value)
                    onExpandedChange(true)
                })
                .onSubmit({ _ => onExpandedChange(false) })

            BuildReplyProfileImage("avatar_6", 32)
        }
        .width(100.percent)
        .padding(left: 12, right: 12, top: 8, bottom: 8)
        .backgroundColor(REPLY_SURFACE)
        .borderRadius(20)
        .alignItems(VerticalAlign.Center)

        if (expanded) {
            Column() {
                if (!query.isEmpty() && filteredEmails.size > 0) {
                    ForEach(filteredEmails, itemGeneratorFunc: { email: Email, _: Int64 =>
                        Row() {
                            BuildReplyProfileImage(email.sender.avatar, 32)
                            Column() {
                                Text(email.subject)
                                    .fontSize(14)
                                    .fontWeight(FontWeight.W600)
                                    .fontColor(REPLY_ON_SURFACE)
                                    .maxLines(1)
                                    .textOverflow(TextOverflow.Ellipsis)
                                Text(email.sender.fullName)
                                    .fontSize(12)
                                    .fontColor(REPLY_ON_SURFACE_VARIANT)
                                    .margin(top: 2)
                                    .maxLines(1)
                                    .textOverflow(TextOverflow.Ellipsis)
                            }
                            .layoutWeight(1)
                            .margin(left: 12)
                        }
                        .width(100.percent)
                        .padding(left: 12, right: 12, top: 10, bottom: 10)
                        .borderRadius(12)
                        .onClick({ _ =>
                            onSearchItemSelected(email)
                            onQueryChange("")
                            onExpandedChange(false)
                        })
                    })
                } else if (!query.isEmpty()) {
                    Text(@r(app.string.no_item_found))
                        .fontSize(13)
                        .fontColor(REPLY_ON_SURFACE_VARIANT)
                        .padding(left: 12, right: 12, top: 12, bottom: 12)
                } else {
                    Text(@r(app.string.no_search_history))
                        .fontSize(13)
                        .fontColor(REPLY_ON_SURFACE_VARIANT)
                        .padding(left: 12, right: 12, top: 12, bottom: 12)
                }
            }
            .width(100.percent)
            .margin(top: 8)
            .padding(left: 4, right: 4, bottom: 4)
            .backgroundColor(REPLY_SURFACE)
            .borderRadius(20)
        }
    }
    .width(100.percent)
    .margin(left: 16, right: 16, top: 12, bottom: 12)
}

@Builder
public func BuildEmailDetailHeader(email: Email, isFullScreen: Bool, onBackPressed: () -> Unit): Unit {
    Row() {
        if (isFullScreen) {
            Row() {
                Image(mediaResourceForName("ic_arrow_back"))
                    .width(14)
                    .height(14)
                    .fillColor(REPLY_ON_SURFACE)
            }
            .width(32)
            .height(32)
            .justifyContent(FlexAlign.Center)
            .backgroundColor(REPLY_SURFACE)
            .borderRadius(16)
            .margin(right: 12)
            .onClick({ _ => onBackPressed() })
        }
        Column() {
            Text(email.subject)
                .fontSize(20)
                .fontWeight(FontWeight.W700)
                .fontColor(REPLY_ON_SURFACE_VARIANT)
            Row() {
                Text("${email.threads.size}")
                    .fontSize(12)
                    .fontColor(REPLY_OUTLINE)
                Text(@r(app.string.messages))
                    .fontSize(12)
                    .fontColor(REPLY_OUTLINE)
                    .margin(left: 4)
            }
            .margin(top: 4)
            .justifyContent(if (isFullScreen) { FlexAlign.Center } else { FlexAlign.Start })
        }
        .layoutWeight(1)
        .alignItems(if (isFullScreen) { HorizontalAlign.Center } else { HorizontalAlign.Start })
        Row() {
            Image(mediaResourceForName("ic_more_vert"))
                .width(18)
                .height(18)
                .fillColor(REPLY_ON_SURFACE_VARIANT)
        }
        .width(32)
        .height(32)
        .justifyContent(FlexAlign.Center)
    }
    .width(100.percent)
    .padding(left: 16, right: 16, top: 16, bottom: 12)
    .backgroundColor(REPLY_BACKGROUND)
}