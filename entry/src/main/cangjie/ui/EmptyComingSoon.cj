package ohos_app_cangjie_entry.ui

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos.resource.*
import ohos_app_cangjie_entry.ui.theme.*

@Builder
public func BuildEmptyComingSoon(): Unit {
    Column() {
        Text(@r(app.string.empty_screen_title))
            .fontSize(28.fp)
            .fontWeight(FontWeight.W700)
            .fontColor(REPLY_PRIMARY)
            .textAlign(TextAlign.Center)
            .margin(8)
        Text(@r(app.string.empty_screen_subtitle))
            .fontSize(16.fp)
            .fontColor(REPLY_OUTLINE)
            .textAlign(TextAlign.Center)
            .margin(left: 8, right: 8, top: 12)
    }
    .width(100.percent)
    .height(100.percent)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding(24)
}