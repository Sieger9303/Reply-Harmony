package ohos_app_cangjie_entry.ui.components

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.data.*
import ohos_app_cangjie_entry.ui.theme.*

@Component
class ReplyEmailListItemView {
    @Prop var email: Email
    @Prop var isOpened: Bool
    @Prop var isSelected: Bool
    @Prop var onOpen: () -> Unit
    @Prop var onToggleSelection: () -> Unit

    @State var touchStartX: Float64 = 0.0
    @State var touchStartY: Float64 = 0.0
    @State var swipeSelecting: Bool = false
    @State var touchHandled: Bool = false

    func cardColor(): Color {
        if (this.isSelected) {
            return REPLY_SELECTED
        }
        if (this.isOpened) {
            return REPLY_OPENED
        }
        REPLY_SURFACE_VARIANT
    }

    func absFloat(value: Float64): Float64 {
        if (value < 0.0) {
            return -value
        }
        value
    }

    func tryToggleByHorizontalSwipe(currentX: Float64, currentY: Float64): Unit {
        let deltaX = currentX - this.touchStartX
        let deltaY = currentY - this.touchStartY

        let absDeltaX = this.absFloat(deltaX)
        let absDeltaY = this.absFloat(deltaY)

        /*
         * 这里不再只判断右滑，而是左右横向滑动都可以选中。
         * 阈值设小一点，16px 就触发。
         * 同时要求横向位移明显大于纵向位移，避免正常上下滚动邮件列表时误触。
         */
        if (!this.swipeSelecting && absDeltaX > 16.0 && absDeltaX > absDeltaY) {
            this.swipeSelecting = true
            this.touchHandled = true
            this.onToggleSelection()
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
                .width(40)
                .height(40)
                .justifyContent(FlexAlign.Center)
                .alignItems(VerticalAlign.Center)
                .onClick({ _ =>
                    this.onToggleSelection()
                })

                Row() {
                    Column() {
                        Text(this.email.sender.firstName)
                            .fontSize(14)
                            .fontWeight(FontWeight.W600)
                            .fontColor(REPLY_ON_SURFACE)

                        Text(this.email.createdAt)
                            .fontSize(12)
                            .fontColor(REPLY_OUTLINE)
                            .margin(top: 2)
                    }
                    .layoutWeight(1)
                    .margin(left: 12, right: 12, top: 4, bottom: 4)

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
                .layoutWeight(1)
                .alignItems(VerticalAlign.Center)
                .onClick({ _ =>
                    if (!this.touchHandled) {
                        this.onOpen()
                    }
                })
            }
            .width(100.percent)
            .alignItems(VerticalAlign.Center)

            Column() {
                Text(this.email.subject)
                    .fontSize(16)
                    .fontWeight(FontWeight.W700)
                    .fontColor(REPLY_ON_SURFACE)
                    .margin(top: 12, bottom: 8)

                Text(this.email.body)
                    .fontSize(14)
                    .fontColor(REPLY_ON_SURFACE_VARIANT)
                    .maxLines(2)
                    .textOverflow(TextOverflow.Ellipsis)
            }
            .width(100.percent)
            .onClick({ _ =>
                if (!this.touchHandled) {
                    this.onOpen()
                }
            })
        }
        .width(100.percent)
        .padding(20)
        .backgroundColor(this.cardColor())
        .borderRadius(16)
        .onTouch({ event =>
            if (event.touches.size > 0) {
                let touch = event.touches[0]

                if (event.eventType == TouchType.Down) {
                    this.touchStartX = touch.screenX
                    this.touchStartY = touch.screenY
                    this.swipeSelecting = false
                    this.touchHandled = false
                } else if (event.eventType == TouchType.Move) {
                    this.tryToggleByHorizontalSwipe(touch.screenX, touch.screenY)

                    if (this.touchHandled) {
                        event.stopPropagation()
                    }
                } else if (event.eventType == TouchType.Up || event.eventType == TouchType.Cancel) {
                    /*
                     * 有些情况下 Move 不一定稳定触发，所以 Up 时再判断一次。
                     * 这样用户只要横向滑动后松手，也可以触发选中。
                     */
                    this.tryToggleByHorizontalSwipe(touch.screenX, touch.screenY)

                    if (this.touchHandled) {
                        event.stopPropagation()
                    }

                    this.swipeSelecting = false
                }
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
    .alignItems(VerticalAlign.Center)
    .backgroundColor(REPLY_PRIMARY)
    .borderRadius(20)
}