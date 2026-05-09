package ohos_app_cangjie_entry.ui.components

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos.resource.*

public func mediaResourceForName(mediaName: String): AppResource {
    match (mediaName) {
        case "avatar_0" => @r(app.media.avatar_0)
        case "avatar_1" => @r(app.media.avatar_1)
        case "avatar_2" => @r(app.media.avatar_2)
        case "avatar_3" => @r(app.media.avatar_3)
        case "avatar_4" => @r(app.media.avatar_4)
        case "avatar_5" => @r(app.media.avatar_5)
        case "avatar_6" => @r(app.media.avatar_6)
        case "avatar_7" => @r(app.media.avatar_7)
        case "avatar_8" => @r(app.media.avatar_8)
        case "avatar_9" => @r(app.media.avatar_9)
        case "avatar_10" => @r(app.media.avatar_10)
        case "avatar_express" => @r(app.media.avatar_express)
        case "paris_1" => @r(app.media.paris_1)
        case "paris_2" => @r(app.media.paris_2)
        case "paris_3" => @r(app.media.paris_3)
        case "paris_4" => @r(app.media.paris_4)
        case "ic_check" => @r(app.media.ic_check)
        case "ic_star_border" => @r(app.media.ic_star_border)
        case "ic_arrow_back" => @r(app.media.ic_arrow_back)
        case "ic_more_vert" => @r(app.media.ic_more_vert)
        case "ic_search" => @r(app.media.ic_search)
        case "ic_menu" => @r(app.media.ic_menu)
        case "ic_menu_open" => @r(app.media.ic_menu_open)
        case "ic_edit" => @r(app.media.ic_edit)
        case "ic_inbox" => @r(app.media.ic_inbox)
        case "ic_article" => @r(app.media.ic_article)
        case "ic_chat_bubble_outline" => @r(app.media.ic_chat_bubble_outline)
        case "ic_group" => @r(app.media.ic_group)
        case _ => @r(app.media.avatar_0)
    }
}

@Builder
public func BuildReplyProfileImage(mediaName: String, size: Int64): Unit {
    Image(mediaResourceForName(mediaName))
        .width(size.vp)
        .height(size.vp)
        .borderRadius((size / 2).vp)
}