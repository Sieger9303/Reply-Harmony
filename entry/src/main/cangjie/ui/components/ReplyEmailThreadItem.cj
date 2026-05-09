package ohos_app_cangjie_entry.ui.components

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.data.*
import ohos_app_cangjie_entry.ui.theme.*

@Builder
public func BuildEmailThreadItem(email: Email): Unit {
    Column() {
        Row() {
            BuildReplyProfileImage(email.sender.avatar, 40)
            Column() {
                Text(email.sender.firstName)
                    .fontSize(14)
                    .fontWeight(FontWeight.W600)
                    .fontColor(REPLY_ON_SURFACE)
                Text(email.createdAt)
                    .fontSize(12)
                    .fontColor(REPLY_OUTLINE)
            }
            .margin(left: 12)
            .layoutWeight(1)
            Row() {
                Image(mediaResourceForName("ic_star_border"))
                    .width(18)
                    .height(18)
                    .fillColor(if (email.isStarred) { REPLY_PRIMARY } else { REPLY_OUTLINE })
            }
            .width(32)
            .height(32)
            .justifyContent(FlexAlign.Center)
            .backgroundColor(REPLY_SURFACE)
            .borderRadius(16)
        }
        .alignItems(VerticalAlign.Center)
        Text(email.subject)
            .fontSize(14)
            .fontColor(REPLY_OUTLINE)
            .margin(top: 12)
        Text(email.body)
            .fontSize(16)
            .fontColor(REPLY_ON_SURFACE_VARIANT)
            .margin(top: 8)
        Row() {
            Button('Reply')
                .layoutWeight(1)
                .backgroundColor(REPLY_SURFACE)
                .fontColor(REPLY_ON_SURFACE)
            Button('Reply All')
                .layoutWeight(1)
                .margin(left: 12)
                .backgroundColor(REPLY_SURFACE)
                .fontColor(REPLY_ON_SURFACE)
        }
        .margin(top: 20)
    }
    .width(100.percent)
    .padding(16)
    .backgroundColor(REPLY_THREAD)
    .borderRadius(16)
}