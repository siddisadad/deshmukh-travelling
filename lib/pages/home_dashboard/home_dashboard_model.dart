import '/components/button/button_widget.dart';
import '/components/popular_route_item/popular_route_item_widget.dart';
import '/components/search_input_row/search_input_row_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'home_dashboard_widget.dart' show HomeDashboardWidget;
import 'package:flutter/material.dart';

class HomeDashboardModel extends FlutterFlowModel<HomeDashboardWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for SearchInputRow.
  late SearchInputRowModel searchInputRowModel1;
  // Model for SearchInputRow.
  late SearchInputRowModel searchInputRowModel2;
  // Model for SearchInputRow.
  late SearchInputRowModel searchInputRowModel3;
  // Model for SearchInputRow.
  late SearchInputRowModel searchInputRowModel4;
  // Model for Button.
  late ButtonModel buttonModel1;
  // Model for PopularRouteItem.
  late PopularRouteItemModel popularRouteItemModel1;
  // Model for PopularRouteItem.
  late PopularRouteItemModel popularRouteItemModel2;
  // Model for PopularRouteItem.
  late PopularRouteItemModel popularRouteItemModel3;
  // Model for Button.
  late ButtonModel buttonModel2;

  @override
  void initState(BuildContext context) {
    searchInputRowModel1 = createModel(context, () => SearchInputRowModel());
    searchInputRowModel2 = createModel(context, () => SearchInputRowModel());
    searchInputRowModel3 = createModel(context, () => SearchInputRowModel());
    searchInputRowModel4 = createModel(context, () => SearchInputRowModel());
    buttonModel1 = createModel(context, () => ButtonModel());
    popularRouteItemModel1 =
        createModel(context, () => PopularRouteItemModel());
    popularRouteItemModel2 =
        createModel(context, () => PopularRouteItemModel());
    popularRouteItemModel3 =
        createModel(context, () => PopularRouteItemModel());
    buttonModel2 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    searchInputRowModel1.dispose();
    searchInputRowModel2.dispose();
    searchInputRowModel3.dispose();
    searchInputRowModel4.dispose();
    buttonModel1.dispose();
    popularRouteItemModel1.dispose();
    popularRouteItemModel2.dispose();
    popularRouteItemModel3.dispose();
    buttonModel2.dispose();
  }
}
