package ohos_app_cangjie_entry.ui.navigation

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos.resource.*
import ohos_app_cangjie_entry.ui.*
import ohos_app_cangjie_entry.ui.components.*
import ohos_app_cangjie_entry.ui.theme.*
import ohos_app_cangjie_entry.ui.utils.*

public func routeIndex(route: Route): Int32 {
    match (route) {
        case Route.Inbox => 0
        case Route.Articles => 1
        case Route.DirectMessages => 2
        case Route.Groups => 3
    }
}

public func indexRoute(index: Int32): Route {
    match (index) {
        case 0 => Route.Inbox
        case 1 => Route.Articles
        case 2 => Route.DirectMessages
        case _ => Route.Groups
    }
}

func destinationSelected(currentRoute: Route, destination: ReplyTopLevelDestination): Bool {
    currentRoute == destination.route
}

@Builder
func BuildWrapperRouteContent(currentRoute: Route, homeState: ReplyHomeStateHolder, contentType: ReplyContentType): Unit {
    if (currentRoute == Route.Inbox) {
        ReplyInboxScreen(homeState: homeState, contentType: contentType)
    } else {
        BuildEmptyComingSoon()
    }
}

@Builder
public func BuildRouteTabLabel(icon: String, route: Route, selected: Bool): Unit {
    Column() {
        Image(mediaResourceForName(icon))
            .width(20)
            .height(20)
            .fillColor(if (selected) { REPLY_PRIMARY } else { REPLY_OUTLINE })
        if (route == Route.Inbox) {
            Text(@r(app.string.tab_inbox))
                .fontSize(12)
                .fontWeight(if (selected) { FontWeight.W700 } else { FontWeight.W400 })
                .fontColor(if (selected) { REPLY_PRIMARY } else { REPLY_ON_SURFACE_VARIANT })
                .margin(top: 4)
        } else if (route == Route.Articles) {
            Text(@r(app.string.tab_article))
                .fontSize(12)
                .fontWeight(if (selected) { FontWeight.W700 } else { FontWeight.W400 })
                .fontColor(if (selected) { REPLY_PRIMARY } else { REPLY_ON_SURFACE_VARIANT })
                .margin(top: 4)
        } else if (route == Route.DirectMessages) {
            Text(@r(app.string.tab_dm))
                .fontSize(12)
                .fontWeight(if (selected) { FontWeight.W700 } else { FontWeight.W400 })
                .fontColor(if (selected) { REPLY_PRIMARY } else { REPLY_ON_SURFACE_VARIANT })
                .margin(top: 4)
        } else {
            Text(@r(app.string.tab_groups))
                .fontSize(12)
                .fontWeight(if (selected) { FontWeight.W700 } else { FontWeight.W400 })
                .fontColor(if (selected) { REPLY_PRIMARY } else { REPLY_ON_SURFACE_VARIANT })
                .margin(top: 4)
        }
    }
    .width(100.percent)
    .padding(top: 10, bottom: 10)
}

@Builder
func BuildComposeButton(expanded: Bool): Unit {
    Row() {
        Image(mediaResourceForName("ic_edit"))
            .width(18)
            .height(18)
            .fillColor(REPLY_PRIMARY)
        if (expanded) {
            Text(@r(app.string.compose))
                .fontSize(14)
                .fontWeight(FontWeight.W600)
                .fontColor(REPLY_PRIMARY)
                .margin(left: 8)
        }
    }
    .padding(left: 16, right: 16, top: 12, bottom: 12)
    .backgroundColor(REPLY_TERTIARY_CONTAINER)
    .borderRadius(24)
}

@Builder
func BuildDrawerHeader(showCloseButton: Bool, onClose: () -> Unit): Unit {
    Row() {
        Text(@r(app.string.app_name))
            .fontSize(18)
            .fontWeight(FontWeight.W700)
            .fontColor(REPLY_PRIMARY)
            .layoutWeight(1)
        if (showCloseButton) {
            Row() {
                Image(mediaResourceForName("ic_menu_open"))
                    .width(20)
                    .height(20)
                    .fillColor(REPLY_ON_SURFACE_VARIANT)
            }
            .width(36)
            .height(36)
            .justifyContent(FlexAlign.Center)
            .borderRadius(18)
            .backgroundColor(REPLY_SURFACE_VARIANT)
            .onClick({ _ => onClose() })
        }
    }
    .width(100.percent)
    .alignItems(VerticalAlign.Center)
    .padding(left: 16, right: 16, top: 16, bottom: 16)
}

@Builder
func BuildDestinationRow(destination: ReplyTopLevelDestination, selected: Bool, centered: Bool): Unit {
    Row() {
        Image(mediaResourceForName(destination.icon))
            .width(20)
            .height(20)
            .fillColor(if (selected) { REPLY_PRIMARY } else { REPLY_ON_SURFACE_VARIANT })
        if (destination.route == Route.Inbox) {
            Text(@r(app.string.tab_inbox))
                .fontSize(14)
                .fontWeight(if (selected) { FontWeight.W700 } else { FontWeight.W400 })
                .fontColor(if (selected) { REPLY_PRIMARY } else { REPLY_ON_SURFACE_VARIANT })
                .margin(left: 12)
        } else if (destination.route == Route.Articles) {
            Text(@r(app.string.tab_article))
                .fontSize(14)
                .fontWeight(if (selected) { FontWeight.W700 } else { FontWeight.W400 })
                .fontColor(if (selected) { REPLY_PRIMARY } else { REPLY_ON_SURFACE_VARIANT })
                .margin(left: 12)
        } else if (destination.route == Route.DirectMessages) {
            Text(@r(app.string.tab_dm))
                .fontSize(14)
                .fontWeight(if (selected) { FontWeight.W700 } else { FontWeight.W400 })
                .fontColor(if (selected) { REPLY_PRIMARY } else { REPLY_ON_SURFACE_VARIANT })
                .margin(left: 12)
        } else {
            Text(@r(app.string.tab_groups))
                .fontSize(14)
                .fontWeight(if (selected) { FontWeight.W700 } else { FontWeight.W400 })
                .fontColor(if (selected) { REPLY_PRIMARY } else { REPLY_ON_SURFACE_VARIANT })
                .margin(left: 12)
        }
    }
    .width(100.percent)
    .padding(left: 16, right: 16, top: 14, bottom: 14)
    .backgroundColor(if (selected) { REPLY_SELECTED } else { Color.Transparent })
    .borderRadius(20)
    .alignItems(VerticalAlign.Center)
    .justifyContent(if (centered) { FlexAlign.Center } else { FlexAlign.Start })
}

@Builder
public func BuildReplyBottomNavigation(currentRoute: Route, onNavigate: (Route) -> Unit): Unit {
    Row() {
        ForEach(TOP_LEVEL_DESTINATIONS, itemGeneratorFunc: { destination: ReplyTopLevelDestination, _: Int64 =>
            Column() {
                BuildRouteTabLabel(destination.icon, destination.route, destinationSelected(currentRoute, destination))
            }
            .layoutWeight(1)
            .onClick({ _ => onNavigate(destination.route) })
        })
    }
    .width(100.percent)
    .padding(left: 12, right: 12, top: 6, bottom: 6)
    .backgroundColor(REPLY_SURFACE)
}

@Builder
public func BuildReplyNavigationRail(
    currentRoute: Route,
    navigationContentPosition: ReplyNavigationContentPosition,
    onNavigate: (Route) -> Unit,
    onOpenDrawer: () -> Unit
): Unit {
    Column() {
        Column() {
            Row() {
                Image(mediaResourceForName("ic_menu"))
                    .width(20)
                    .height(20)
                    .fillColor(REPLY_ON_SURFACE_VARIANT)
            }
            .width(44)
            .height(44)
            .justifyContent(FlexAlign.Center)
            .borderRadius(22)
            .backgroundColor(REPLY_SURFACE_VARIANT)
            .onClick({ _ => onOpenDrawer() })

            Column() {
                BuildComposeButton(false)
            }
            .margin(top: 16, bottom: 24)
        }
        .alignItems(HorizontalAlign.Center)

        Column() {
            ForEach(TOP_LEVEL_DESTINATIONS, itemGeneratorFunc: { destination: ReplyTopLevelDestination, _: Int64 =>
                Column() {
                    Image(mediaResourceForName(destination.icon))
                        .width(22)
                        .height(22)
                        .fillColor(if (destinationSelected(currentRoute, destination)) { REPLY_PRIMARY } else { REPLY_ON_SURFACE_VARIANT })
                }
                .width(56)
                .height(56)
                .justifyContent(FlexAlign.Center)
                .alignItems(HorizontalAlign.Center)
                .backgroundColor(if (destinationSelected(currentRoute, destination)) { REPLY_SELECTED } else { Color.Transparent })
                .borderRadius(28)
                .margin(bottom: 8)
                .onClick({ _ => onNavigate(destination.route) })
            })
        }
        .layoutWeight(if (navigationContentPosition == ReplyNavigationContentPosition.CENTER) { 1 } else { 0 })
        .justifyContent(if (navigationContentPosition == ReplyNavigationContentPosition.CENTER) { FlexAlign.Center } else { FlexAlign.Start })
        .alignItems(HorizontalAlign.Center)
    }
    .width(88)
    .height(100.percent)
    .padding(top: 16, bottom: 16)
    .backgroundColor(REPLY_SURFACE)
}

@Builder
func BuildDrawerContent(
    currentRoute: Route,
    navigationContentPosition: ReplyNavigationContentPosition,
    onNavigate: (Route) -> Unit,
    showCloseButton: Bool,
    onClose: () -> Unit
): Unit {
    Column() {
        BuildDrawerHeader(showCloseButton, onClose)

        Column() {
            BuildComposeButton(true)
        }
        .padding(left: 16, right: 16, bottom: 24)

        Scroll() {
            Column() {
                ForEach(TOP_LEVEL_DESTINATIONS, itemGeneratorFunc: { destination: ReplyTopLevelDestination, _: Int64 =>
                    Column() {
                        BuildDestinationRow(
                            destination,
                            destinationSelected(currentRoute, destination),
                            false
                        )
                    }
                    .margin(left: 12, right: 12, bottom: 8)
                    .onClick({ _ =>
                        onNavigate(destination.route)
                        if (showCloseButton) {
                            onClose()
                        }
                    })
                })
            }
            .width(100.percent)
            .justifyContent(if (navigationContentPosition == ReplyNavigationContentPosition.CENTER) { FlexAlign.Center } else { FlexAlign.Start })
        }
        .layoutWeight(1)
    }
    .width(100.percent)
    .height(100.percent)
}

@Builder
public func BuildPermanentNavigationDrawer(
    currentRoute: Route,
    navigationContentPosition: ReplyNavigationContentPosition,
    onNavigate: (Route) -> Unit
): Unit {
    Column() {
        BuildDrawerContent(currentRoute, navigationContentPosition, onNavigate, false, { => })
    }
    .width(280)
    .height(100.percent)
    .backgroundColor(REPLY_SURFACE_VARIANT)
}

@Builder
func BuildModalNavigationDrawer(
    currentRoute: Route,
    navigationContentPosition: ReplyNavigationContentPosition,
    onNavigate: (Route) -> Unit,
    onCloseDrawer: () -> Unit
): Unit {
    Row() {
        Column() {
            BuildDrawerContent(currentRoute, navigationContentPosition, onNavigate, true, onCloseDrawer)
        }
        .width(280)
        .height(100.percent)
        .backgroundColor(REPLY_SURFACE_VARIANT)

        Blank()
            .layoutWeight(1)
            .height(100.percent)
            .backgroundColor(Color.Transparent)
            .onClick({ _ => onCloseDrawer() })
    }
    .width(100.percent)
    .height(100.percent)
    .backgroundColor(REPLY_SCRIM)
}

@Builder
public func BuildReplyNavigationWrapper(
    navigationType: ReplyNavigationType,
    navigationContentPosition: ReplyNavigationContentPosition,
    currentRoute: Route,
    drawerOpen: Bool,
    homeState: ReplyHomeStateHolder,
    contentType: ReplyContentType,
    onNavigate: (Route) -> Unit,
    onOpenDrawer: () -> Unit,
    onCloseDrawer: () -> Unit
): Unit {
    if (navigationType == ReplyNavigationType.BOTTOM_NAVIGATION) {
        Column() {
            Column() {
                BuildWrapperRouteContent(currentRoute, homeState, contentType)
            }
            .layoutWeight(1)
            .width(100.percent)

            BuildReplyBottomNavigation(currentRoute, onNavigate)
        }
        .width(100.percent)
        .height(100.percent)
    } else if (navigationType == ReplyNavigationType.NAVIGATION_RAIL) {
        Stack() {
            Row() {
                BuildReplyNavigationRail(currentRoute, navigationContentPosition, onNavigate, onOpenDrawer)
                Column() {
                    BuildWrapperRouteContent(currentRoute, homeState, contentType)
                }
                .layoutWeight(1)
                .height(100.percent)
            }
            .width(100.percent)
            .height(100.percent)

            if (drawerOpen) {
                BuildModalNavigationDrawer(currentRoute, navigationContentPosition, onNavigate, onCloseDrawer)
            }
        }
        .width(100.percent)
        .height(100.percent)
    } else {
        Row() {
            BuildPermanentNavigationDrawer(currentRoute, navigationContentPosition, onNavigate)
            Column() {
                BuildWrapperRouteContent(currentRoute, homeState, contentType)
            }
            .layoutWeight(1)
            .height(100.percent)
        }
        .width(100.percent)
        .height(100.percent)
    }
}