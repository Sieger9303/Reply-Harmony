package ohos_app_cangjie_entry.ui.components

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import std.sync.*
import ohos_app_cangjie_entry.data.*
import ohos_app_cangjie_entry.ui.theme.*

@Component
class ReplyEmailListItemView {
    @Prop var email: Email
    @Prop var isOpened: Bool
    @Prop var isSelected: Bool
    @Prop var onOpen: () -> Unit
    @Prop var onToggleSelection: () -> Unit

    @State var longPressTriggered: Bool = false
    @State var longPressTimer: ?Timer = Option<Timer>.None
    @State var ignoreNextRelease: Bool = false

    func cancelLongPressTimer(): Unit {
        match (this.longPressTimer) {
            case Some(timer) => timer.cancel()
            case None => ()
        }
        this.longPressTimer = Option<Timer>.None
    }

    func handleSelectorClick(): Unit {
        this.ignoreNextRelease = true
        this.cancelLongPressTimer()
        this.longPressTriggered = false
        this.onToggleSelection()
    }

    func scheduleLongPress(): Unit {
        this.cancelLongPressTimer()
        this.longPressTriggered = false
        this.ignoreNextRelease = false
        this.longPressTimer = Some(Timer.after(500 * Duration.millisecond, { =>
            this.longPressTriggered = true
            this.onToggleSelection()
            Option<Duration>.None
        }))
    }

    func handleTouchRelease(): Unit {
        let didLongPress = this.longPressTriggered
        let shouldIgnoreRelease = this.ignoreNextRelease
        this.cancelLongPressTimer()
        this.longPressTriggered = false
        this.ignoreNextRelease = false
        if (!didLongPress && !shouldIgnoreRelease) {
            this.onOpen()
        }
    }

    public func build(): Unit {
        Column() {
            Row() {
                Row() {
                    if (this.isSelected) {
                        BuildSelectedProfileImage()
                    } else {
                        BuildReplyProfileImage(this.email.sender.avatar, 40)
                    }
                }
                .onClick({ _ => this.handleSelectorClick() })

                Column() {
                    Text(this.email.sender.firstName)
                        .fontSize(14)
                        .fontWeight(FontWeight.W600)
                        .fontColor(REPLY_ON_SURFACE)
                    Text(this.email.createdAt)
                        .fontSize(12)
                        .fontColor(REPLY_OUTLINE)
                }
                .margin(left: 12)
                .layoutWeight(1)
                Row() {
                    Image(mediaResourceForName("ic_star_border"))
                        .width(18)
                        .height(18)
                        .fillColor(if (this.email.isStarred) { REPLY_PRIMARY } else { REPLY_OUTLINE })
                }
                .width(32)
                .height(32)
                .justifyContent(FlexAlign.Center)
                .backgroundColor(REPLY_SURFACE)
                .borderRadius(16)
            }
            .alignItems(VerticalAlign.Center)

            Text(this.email.subject)
                .fontSize(16)
                .fontWeight(FontWeight.W700)
                .fontColor(REPLY_ON_SURFACE)
                .margin(top: 12)
            Text(this.email.body)
                .fontSize(14)
                .fontColor(REPLY_ON_SURFACE_VARIANT)
                .maxLines(2)
                .textOverflow(TextOverflow.Ellipsis)
                .margin(top: 6)
        }
        .width(100.percent)
        .padding(16)
        .backgroundColor(if (this.isSelected) { REPLY_SELECTED } else if (this.isOpened) { REPLY_OPENED } else { REPLY_SURFACE_VARIANT })
        .borderRadius(16)
        .onTouch({ event =>
            match (event.eventType) {
                case TouchType.Down => this.scheduleLongPress()
                case TouchType.Up => this.handleTouchRelease()
                case TouchType.Cancel =>
                    this.cancelLongPressTimer()
                    this.longPressTriggered = false
                case TouchType.Move => ()
                case _ => ()
            }
        })
    }
}

@Builder
public func BuildEmailListItem(
    email: Email,
    isOpened: Bool,
    isSelected: Bool,
    onOpen: () -> Unit,
    onToggleSelection: () -> Unit
): Unit {
    ReplyEmailListItemView(
        email: email,
        isOpened: isOpened,
        isSelected: isSelected,
        onOpen: onOpen,
        onToggleSelection: onToggleSelection
    )
}

@Builder
public func BuildSelectedProfileImage(): Unit {
    Row() {
        Image(mediaResourceForName("ic_check"))
            .width(20)
            .height(20)
            .fillColor(REPLY_ON_PRIMARY)
    }
    .width(40)
    .height(40)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(REPLY_PRIMARY)
    .borderRadius(20)
}