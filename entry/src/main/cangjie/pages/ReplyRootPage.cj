package ohos_app_cangjie_entry.pages

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.data.*
import ohos_app_cangjie_entry.data.local.*
import ohos_app_cangjie_entry.ui.*
import ohos_app_cangjie_entry.ui.navigation.*
import ohos_app_cangjie_entry.ui.theme.*
import ohos_app_cangjie_entry.ui.utils.*

@Entry
@Component
class ReplyRootPage {
    @State var currentBreakpoint: String = "xs"
    @State var windowWidth: Float64 = 0.0
    @State var drawerOpen: Bool = false
    @State var currentRoute: Route = Route.Inbox
    @State var homeState: ReplyHomeStateHolder = ReplyHomeStateHolder(EmailsRepositoryImpl())
    @State var uiState: ReplyHomeUIState = ReplyHomeUIState([], [], Option<Email>.None, false, true, Option<String>.None)

    func adaptiveLayoutState(): ReplyAdaptiveLayoutState {
        adaptiveLayoutStateForWindow(this.currentBreakpoint, this.windowWidth)
    }

    func currentNavigationType(): ReplyNavigationType {
        this.adaptiveLayoutState().navigationType
    }

    func currentNavigationContentPosition(): ReplyNavigationContentPosition {
        this.adaptiveLayoutState().navigationContentPosition
    }

    func currentContentType(): ReplyContentType {
        this.adaptiveLayoutState().contentType
    }

    func navigateTo(route: Route): Unit {
        this.currentRoute = route
        this.drawerOpen = false
    }

    func syncUiState(): Unit {
        this.uiState = this.homeState.uiState
    }

    func updateWindowWidth(width: Float64): Unit {
        this.windowWidth = width
        if (this.currentNavigationType() != ReplyNavigationType.NAVIGATION_RAIL) {
            this.drawerOpen = false
        }
    }

    func updateBreakpoint(breakpoint: String): Unit {
        this.currentBreakpoint = breakpoint
        if (this.currentNavigationType() != ReplyNavigationType.NAVIGATION_RAIL) {
            this.drawerOpen = false
        }
    }

    func build(): Unit {
        GridRow(
            columns: 12,
            gutter: GutterOption(x: 0.vp, y: 0.vp),
            breakpoints: BreakPoints(value: [600.vp, 840.vp, 1200.vp], reference: BreakpointsReference.WindowSize),
            direction: GridRowDirection.Row
        ) {
            GridCol() {
                Column() {
                    ReplyNavigationWrapper(
                        navigationType: this.currentNavigationType(),
                        navigationContentPosition: this.currentNavigationContentPosition(),
                        currentRoute: this.currentRoute,
                        drawerOpen: this.drawerOpen,
                        homeState: this.homeState,
                        uiState: this.uiState,
                        onUiStateChange: { value: ReplyHomeUIState => this.uiState = value },
                        contentType: this.currentContentType(),
                        onNavigate: { route: Route => this.navigateTo(route) },
                        onOpenDrawer: { => this.drawerOpen = true },
                        onCloseDrawer: { => this.drawerOpen = false }
                    )
                }
                .width(100.percent)
                .height(100.percent)
                .onAppear({ => this.syncUiState() })
                .onAreaChange({ _, newArea =>
                    this.updateWindowWidth(newArea.width.value)
                })
            }
            .span(12)
        }
        .width(100.percent)
        .height(100.percent)
        .backgroundColor(REPLY_BACKGROUND)
        .onBreakpointChange({ bp =>
            this.updateBreakpoint(bp)
        })
    }
}