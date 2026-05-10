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

@Component
public class ReplyWrapperRouteContent {
    @Prop var currentRoute: Route
    @Link var homeState: ReplyHomeStateHolder
    @Prop var uiState: ReplyHomeUIState
    @Prop var onUiStateChange: (ReplyHomeUIState) -> Unit
    @Prop var contentType: ReplyContentType

    public func build(): Unit {
        if (this.currentRoute == Route.Inbox) {
            ReplyInboxScreen(homeState: this.homeState, uiState: this.uiState, onUiStateChange: this.onUiStateChange, contentType: this.contentType)
        } else {
            BuildEmptyComingSoon()
        }
    }
}

@Component
public class ReplyRouteTabLabel {
    @Prop var icon: String
    @Prop var route: Route
    @Prop var currentRoute: Route
    @Prop var onClick: () -> Unit

    func selected(): Bool {
        this.currentRoute == this.route
    }

    public func build(): Unit {
        Column() {
            Image(mediaResourceForName(this.icon))
                .width(20)
                .height(20)
                .fillColor(if (this.selected()) { REPLY_PRIMARY } else { REPLY_OUTLINE })
            if (this.route == Route.Inbox) {
                Text(@r(app.string.tab_inbox))
                    .fontSize(12)
                    .fontWeight(if (this.selected()) { FontWeight.W700 } else { FontWeight.W400 })
                    .fontColor(if (this.selected()) { REPLY_PRIMARY } else { REPLY_ON_SURFACE_VARIANT })
                    .margin(top: 4)
            } else if (this.route == Route.Articles) {
                Text(@r(app.string.tab_article))
                    .fontSize(12)
                    .fontWeight(if (this.selected()) { FontWeight.W700 } else { FontWeight.W400 })
                    .fontColor(if (this.selected()) { REPLY_PRIMARY } else { REPLY_ON_SURFACE_VARIANT })
                    .margin(top: 4)
            } else if (this.route == Route.DirectMessages) {
                Text(@r(app.string.tab_dm))
                    .fontSize(12)
                    .fontWeight(if (this.selected()) { FontWeight.W700 } else { FontWeight.W400 })
                    .fontColor(if (this.selected()) { REPLY_PRIMARY } else { REPLY_ON_SURFACE_VARIANT })
                    .margin(top: 4)
            } else {
                Text(@r(app.string.tab_groups))
                    .fontSize(12)
                    .fontWeight(if (this.selected()) { FontWeight.W700 } else { FontWeight.W400 })
                    .fontColor(if (this.selected()) { REPLY_PRIMARY } else { REPLY_ON_SURFACE_VARIANT })
                    .margin(top: 4)
            }
        }
        .width(100.percent)
        .padding(top: 10, bottom: 10)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .onClick({ _ => this.onClick() })
    }
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

@Component
public class ReplyDestinationRow {
    @Prop var destination: ReplyTopLevelDestination
    @Prop var currentRoute: Route
    @Prop var centered: Bool

    func selected(): Bool {
        destinationSelected(this.currentRoute, this.destination)
    }

    public func build(): Unit {
        Row() {
            Image(mediaResourceForName(this.destination.icon))
                .width(20)
                .height(20)
                .fillColor(if (this.selected()) { REPLY_PRIMARY } else { REPLY_ON_SURFACE_VARIANT })
            if (this.destination.route == Route.Inbox) {
                Text(@r(app.string.tab_inbox))
                    .fontSize(14)
                    .fontWeight(if (this.selected()) { FontWeight.W700 } else { FontWeight.W400 })
                    .fontColor(if (this.selected()) { REPLY_PRIMARY } else { REPLY_ON_SURFACE_VARIANT })
                    .margin(left: 12)
            } else if (this.destination.route == Route.Articles) {
                Text(@r(app.string.tab_article))
                    .fontSize(14)
                    .fontWeight(if (this.selected()) { FontWeight.W700 } else { FontWeight.W400 })
                    .fontColor(if (this.selected()) { REPLY_PRIMARY } else { REPLY_ON_SURFACE_VARIANT })
                    .margin(left: 12)
            } else if (this.destination.route == Route.DirectMessages) {
                Text(@r(app.string.tab_dm))
                    .fontSize(14)
                    .fontWeight(if (this.selected()) { FontWeight.W700 } else { FontWeight.W400 })
                    .fontColor(if (this.selected()) { REPLY_PRIMARY } else { REPLY_ON_SURFACE_VARIANT })
                    .margin(left: 12)
            } else {
                Text(@r(app.string.tab_groups))
                    .fontSize(14)
                    .fontWeight(if (this.selected()) { FontWeight.W700 } else { FontWeight.W400 })
                    .fontColor(if (this.selected()) { REPLY_PRIMARY } else { REPLY_ON_SURFACE_VARIANT })
                    .margin(left: 12)
            }
        }
        .width(100.percent)
        .padding(left: 16, right: 16, top: 14, bottom: 14)
        .backgroundColor(if (this.selected()) { REPLY_SELECTED } else { Color.Transparent })
        .borderRadius(20)
        .alignItems(VerticalAlign.Center)
        .justifyContent(if (this.centered) { FlexAlign.Center } else { FlexAlign.Start })
    }
}

@Component
public class ReplyBottomNavigation {
    @Prop var currentRoute: Route
    @Prop var onNavigate: (Route) -> Unit

    public func build(): Unit {
        Row() {
            ForEach(TOP_LEVEL_DESTINATIONS, itemGeneratorFunc: { destination: ReplyTopLevelDestination, _: Int64 =>
                Row() {
                    ReplyRouteTabLabel(
                        icon: destination.icon,
                        route: destination.route,
                        currentRoute: this.currentRoute,
                        onClick: { => this.onNavigate(destination.route) }
                    )
                }
                .layoutWeight(1)
                .justifyContent(FlexAlign.Center)
            })
        }
        .width(100.percent)
        .padding(left: 12, right: 12, top: 6, bottom: 6)
        .backgroundColor(REPLY_SURFACE)
    }
}

@Component
public class ReplyNavigationRail {
    @Prop var currentRoute: Route
    @Prop var navigationContentPosition: ReplyNavigationContentPosition
    @Prop var onNavigate: (Route) -> Unit
    @Prop var onOpenDrawer: () -> Unit

    public func build(): Unit {
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
                .onClick({ _ => this.onOpenDrawer() })

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
                            .fillColor(if (destinationSelected(this.currentRoute, destination)) { REPLY_PRIMARY } else { REPLY_ON_SURFACE_VARIANT })
                    }
                    .width(56)
                    .height(56)
                    .justifyContent(FlexAlign.Center)
                    .alignItems(HorizontalAlign.Center)
                    .backgroundColor(if (destinationSelected(this.currentRoute, destination)) { REPLY_SELECTED } else { Color.Transparent })
                    .borderRadius(28)
                    .margin(bottom: 8)
                    .onClick({ _ => this.onNavigate(destination.route) })
                })
            }
            .layoutWeight(if (this.navigationContentPosition == ReplyNavigationContentPosition.CENTER) { 1 } else { 0 })
            .justifyContent(if (this.navigationContentPosition == ReplyNavigationContentPosition.CENTER) { FlexAlign.Center } else { FlexAlign.Start })
            .alignItems(HorizontalAlign.Center)
        }
        .width(88)
        .height(100.percent)
        .padding(top: 16, bottom: 16)
        .backgroundColor(REPLY_SURFACE)
    }
}

@Component
public class ReplyDrawerContent {
    @Prop var currentRoute: Route
    @Prop var navigationContentPosition: ReplyNavigationContentPosition
    @Prop var onNavigate: (Route) -> Unit
    @Prop var showCloseButton: Bool
    @Prop var onClose: () -> Unit

    public func build(): Unit {
        Column() {
            BuildDrawerHeader(this.showCloseButton, this.onClose)

            Column() {
                BuildComposeButton(true)
            }
            .padding(left: 16, right: 16, bottom: 24)

            Scroll() {
                Column() {
                    ForEach(TOP_LEVEL_DESTINATIONS, itemGeneratorFunc: { destination: ReplyTopLevelDestination, _: Int64 =>
                        Column() {
                            ReplyDestinationRow(
                                destination: destination,
                                currentRoute: this.currentRoute,
                                centered: false
                            )
                        }
                        .margin(left: 12, right: 12, bottom: 8)
                        .onClick({ _ =>
                            this.onNavigate(destination.route)
                            if (this.showCloseButton) {
                                this.onClose()
                            }
                        })
                    })
                }
                .width(100.percent)
                .justifyContent(if (this.navigationContentPosition == ReplyNavigationContentPosition.CENTER) { FlexAlign.Center } else { FlexAlign.Start })
            }
            .layoutWeight(1)
        }
        .width(100.percent)
        .height(100.percent)
    }
}

@Component
public class ReplyPermanentNavigationDrawer {
    @Prop var currentRoute: Route
    @Prop var navigationContentPosition: ReplyNavigationContentPosition
    @Prop var onNavigate: (Route) -> Unit

    public func build(): Unit {
        Column() {
            ReplyDrawerContent(
                currentRoute: this.currentRoute,
                navigationContentPosition: this.navigationContentPosition,
                onNavigate: this.onNavigate,
                showCloseButton: false,
                onClose: { => }
            )
        }
        .width(280)
        .height(100.percent)
        .backgroundColor(REPLY_SURFACE_VARIANT)
    }
}

@Component
public class ReplyModalNavigationDrawer {
    @Prop var currentRoute: Route
    @Prop var navigationContentPosition: ReplyNavigationContentPosition
    @Prop var onNavigate: (Route) -> Unit
    @Prop var onCloseDrawer: () -> Unit

    public func build(): Unit {
        Row() {
            Column() {
                ReplyDrawerContent(
                    currentRoute: this.currentRoute,
                    navigationContentPosition: this.navigationContentPosition,
                    onNavigate: this.onNavigate,
                    showCloseButton: true,
                    onClose: this.onCloseDrawer
                )
            }
            .width(280)
            .height(100.percent)
            .backgroundColor(REPLY_SURFACE_VARIANT)

            Blank()
                .layoutWeight(1)
                .height(100.percent)
                .backgroundColor(Color.Transparent)
                .onClick({ _ => this.onCloseDrawer() })
        }
        .width(100.percent)
        .height(100.percent)
        .backgroundColor(REPLY_SCRIM)
    }
}

@Component
public class ReplyNavigationWrapper {
    @Prop var navigationType: ReplyNavigationType
    @Prop var navigationContentPosition: ReplyNavigationContentPosition
    @Link var currentRoute: Route
    @State var activeRoute: Route = Route.Inbox
    @Link var drawerOpen: Bool
    @Link var homeState: ReplyHomeStateHolder
    @Prop var uiState: ReplyHomeUIState
    @Prop var onUiStateChange: (ReplyHomeUIState) -> Unit
    @Prop var contentType: ReplyContentType
    @Prop var onNavigate: (Route) -> Unit
    @Prop var onOpenDrawer: () -> Unit
    @Prop var onCloseDrawer: () -> Unit

    func handleNavigate(route: Route): Unit {
        this.activeRoute = route
        this.currentRoute = route
        this.drawerOpen = false
        this.onNavigate(route)
    }

    func handleOpenDrawer(): Unit {
        this.drawerOpen = true
        this.onOpenDrawer()
    }

    func handleCloseDrawer(): Unit {
        this.drawerOpen = false
        this.onCloseDrawer()
    }

    public func build(): Unit {
        if (this.navigationType == ReplyNavigationType.BOTTOM_NAVIGATION) {
            Column() {
                Column() {
                    ReplyWrapperRouteContent(currentRoute: this.activeRoute, homeState: this.homeState, uiState: this.uiState, onUiStateChange: this.onUiStateChange, contentType: this.contentType)
                }
                .layoutWeight(1)
                .width(100.percent)

                ReplyBottomNavigation(currentRoute: this.activeRoute, onNavigate: { route: Route => this.handleNavigate(route) })
            }
            .width(100.percent)
            .height(100.percent)
        } else if (this.navigationType == ReplyNavigationType.NAVIGATION_RAIL) {
            Stack() {
                Row() {
                    ReplyNavigationRail(
                        currentRoute: this.activeRoute,
                        navigationContentPosition: this.navigationContentPosition,
                        onNavigate: { route: Route => this.handleNavigate(route) },
                        onOpenDrawer: { => this.handleOpenDrawer() }
                    )
                    Column() {
                        ReplyWrapperRouteContent(currentRoute: this.activeRoute, homeState: this.homeState, uiState: this.uiState, onUiStateChange: this.onUiStateChange, contentType: this.contentType)
                    }
                    .layoutWeight(1)
                    .height(100.percent)
                }
                .width(100.percent)
                .height(100.percent)

                if (this.drawerOpen) {
                    ReplyModalNavigationDrawer(
                        currentRoute: this.activeRoute,
                        navigationContentPosition: this.navigationContentPosition,
                        onNavigate: { route: Route => this.handleNavigate(route) },
                        onCloseDrawer: { => this.handleCloseDrawer() }
                    )
                }
            }
            .width(100.percent)
            .height(100.percent)
        } else {
            Row() {
                ReplyPermanentNavigationDrawer(
                    currentRoute: this.activeRoute,
                    navigationContentPosition: this.navigationContentPosition,
                    onNavigate: { route: Route => this.handleNavigate(route) }
                )
                Column() {
                    ReplyWrapperRouteContent(currentRoute: this.activeRoute, homeState: this.homeState, uiState: this.uiState, onUiStateChange: this.onUiStateChange, contentType: this.contentType)
                }
                .layoutWeight(1)
                .height(100.percent)
            }
            .width(100.percent)
            .height(100.percent)
        }
    }
}