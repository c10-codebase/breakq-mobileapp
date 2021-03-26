import 'package:breakq/configs/constants.dart';
import 'package:breakq/screens/cart/cart_overlay.dart';
import 'package:breakq/screens/cart/widgets/cart_icon.dart';
import 'package:breakq/screens/listing/widgets/search_header.dart';
import 'package:breakq/screens/search/widgets/search_widgets.dart';
import 'package:breakq/widgets/back_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/blocs/home/home_bloc.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/data/models/search_session_model.dart';
import 'package:breakq/data/models/search_tab_model.dart';
import 'package:breakq/data/models/toolbar_option_model.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/main.dart';
import 'package:breakq/screens/listing/widgets/search_filter_drawer.dart';
import 'package:breakq/screens/listing/widgets/search_list_toolbar.dart';
import 'package:breakq/screens/listing/widgets/product_listing.dart';
import 'package:breakq/screens/listing/widgets/search_tabs.dart';
import 'package:breakq/widgets/full_screen_indicator.dart';
import 'package:breakq/widgets/loading_overlay.dart';
import 'package:breakq/screens/listing/widgets/product_list_item.dart';
import 'package:breakq/utils/list.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Listing extends StatefulWidget {
  const Listing({Key key, this.title}) : super(key: key);

  final String title;
  @override
  ListingState createState() => ListingState();
}

class ListingState extends State<Listing> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _customScrollViewController = ScrollController();

  /// Faking user's position as a CityModel
  /// ignore: prefer_const_literals_to_create_immutables

  List<SearchTabModel> categoryTabs = <SearchTabModel>[];

  HomeBloc _homeBloc;

  /// Search sort types.
  List<ToolbarOptionModel> searchSortTypes;

  /// Search list types.
  List<ToolbarOptionModel> searchListTypes;

  /// Search filter by gender.
  List<ToolbarOptionModel> sortbyFilter;

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    getIt.get<AppGlobals>().globalKeySearchTabs = GlobalKey<SearchTabsState>();
  }

  /// Init globals that require access to BuildContext for translation.
  void _initGlobals(context) {
    searchSortTypes = <dynamic>[
      <String, dynamic>{
        'code': 'rating',
        'label': L10n.of(context).commonSearchSortTypeRating,
        'icon': Icons.star,
      },
      <String, dynamic>{
        'code': 'popularity',
        'label': L10n.of(context).commonSearchSortTypePopularity,
        'icon': Icons.remove_red_eye,
      },
      <String, dynamic>{
        'code': 'htl',
        'label': L10n.of(context).commonSortHTL,
        'icon': Icons.attach_money,
      },
      <String, dynamic>{
        'code': 'lth',
        'label': L10n.of(context).commonSortLTL,
        'icon': Icons.attach_money,
      },
    ]
        .map((dynamic item) =>
            ToolbarOptionModel.fromJson(item as Map<String, dynamic>))
        .toList();

    searchListTypes = <dynamic>[
      <String, dynamic>{
        'code': describeEnum(ProductListItemViewType.grid),
        'label': '',
        'icon': Ionicons.ios_list,
      },
      <String, dynamic>{
        'code': describeEnum(ProductListItemViewType.list),
        'label': '',
        'icon': Icons.view_comfy,
      },
      // <String, dynamic>{
      //   'code': describeEnum(ProductListItemViewType.block),
      //   'label': '',
      //   'icon': Icons.view_array,
      // },
    ]
        .map((dynamic item) =>
            ToolbarOptionModel.fromJson(item as Map<String, dynamic>))
        .toList();

    /// The tabs are for Sub categories
    categoryTabs.addAll(List.generate(
        5,
        (index) => SearchTabModel.fromJson(<String, dynamic>{
              'id': index,
              'globalKey': GlobalKey(debugLabel: 'subCat-$index'),
              'label': "Sub Category",
            })));
  }

  bool _initglobal = true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (HomeState previousState, HomeState currentState) {
        /// Return true/false to determine whether or not to rebuild the widget
        /// with state.
        return currentState is InitialHomeState ||
            (currentState is RefreshSuccessHomeState &&
                currentState.session.searchType == SearchType.full);
      },
      builder: (BuildContext context, HomeState state) {
        // While the screen state is initializing we shall show a full screen
        // progress indicator and init the search session.
        if (_initglobal) {
          _initGlobals(context);
          _initglobal = false;
        }
        if (state is InitialHomeState) {
          /// Initialize the search session.
          _homeBloc.add(SessionInitedHomeEvent(
            activeSearchTab: categoryTabs.first.id,
            currentSort: searchSortTypes.first, // default is the first one
            currentListType: searchListTypes.first, // default is the first one
          ));

          // Show the full screen indicator until we return here.
          return FullScreenIndicator(
            color: Theme.of(context).cardColor,
            backgroundColor: Theme.of(context).cardColor,
          );
        }

        /// Session is initialized and/or refreshed.
        final SearchSessionModel session =
            (state as RefreshSuccessHomeState).session;

        return Scaffold(
          key: _scaffoldKey,
          endDrawerEnableOpenDragGesture: false,
          endDrawer: SearchFilterDrawer(),
          floatingActionButton: ScanFloatingButtonExtended(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: SafeArea(
            child: LoadingOverlay(
              isLoading: session.isLoading,
              child: CustomScrollView(
                controller: _customScrollViewController,
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: kWhite,
                    primary: true,
                    title: Text(widget.title ?? "Category Name",
                        style: Theme.of(context).textTheme.headline6.fs16.w600),
                    automaticallyImplyLeading: true,
                    leading: BackButtonCircle(),
                    expandedHeight: kToolbarHeight * 2,
                    snap: true,
                    flexibleSpace: Stack(
                      children: [
                        Column(
                          children: [
                            Spacer(),
                            SearchTabs(
                              activeSearchTab: session.activeSearchTab,
                              searchTabs: categoryTabs,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(color: kWhite, height: kToolbarHeight),
                            Spacer(),
                          ],
                        ),
                      ],
                    ),
                    actions: [
                      SearchIconButton(),
                      VoiceIconButton(),
                      CartIconButton(),
                      SizedBox(width: 10.0),
                    ],
                    floating: true,
                  ),
                  // SliverPersistentHeader(
                  //   pinned: true,
                  //   // floating: true,
                  //   delegate: SearchHeader(
                  //     expandedHeight: 60,
                  //   ),
                  // ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: SearchHeader(
                      expandedHeight: 45,
                      child: SearchListToolbar(
                        searchSortTypes: searchSortTypes,
                        currentSort: session.currentSort,
                        onFilterTap: () {
                          _scaffoldKey.currentState.openEndDrawer();
                        },
                        onSortChange: (ToolbarOptionModel newSort) {
                          _homeBloc.add(SortOrderChangedHomeEvent(newSort));
                        },
                        products: session.products,
                        currentListType: session.currentListType,
                        searchListTypes: searchListTypes,
                        onListTypeChange: (ToolbarOptionModel newListType) =>
                            _homeBloc
                                .add(ListTypeChangedHomeEvent(newListType)),
                      ),
                    ),
                  ),
                  // SliverAppBar(
                  //   primary: false,
                  //   // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  //   toolbarHeight: 45,
                  //   floating: true,
                  //   titleSpacing: 0.0,
                  //   leadingWidth: 0.0,
                  //   title: SearchListToolbar(
                  //     searchSortTypes: searchSortTypes,
                  //     currentSort: session.currentSort,
                  //     onFilterTap: () {
                  //       _scaffoldKey.currentState.openEndDrawer();
                  //     },
                  //     onSortChange: (ToolbarOptionModel newSort) {
                  //       _homeBloc.add(SortOrderChangedHomeEvent(newSort));
                  //     },
                  //     products: session.products,
                  //     currentListType: session.currentListType,
                  //     searchListTypes: searchListTypes,
                  //     onListTypeChange: (ToolbarOptionModel newListType) =>
                  //         _homeBloc.add(ListTypeChangedHomeEvent(newListType)),
                  //   ),
                  //   actions: <Widget>[Container()], // remove the hamburger menu
                  //   leading: Container(), // remove back button
                  // ),
                  SliverList(
                    delegate: SliverChildListDelegate(<Widget>[
                      if (session.products.isNotNullOrEmpty)
                        ProductListing(
                          products: session.products,
                          currentListType: session.currentListType,
                        ),
                    ]),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: 120.0),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Future<String> _quickSearch(SearchSessionModel session) async {
  //   final String queryString = await showSearch(
  //     context: context,
  //     delegate: SearchLocationsDelegate(
  //         hintText: L10n.of(context).searchPlaceholderQuickSearchLocations),
  //     query: session.q,
  //   );

  //   if (queryString == null) {
  //     _homeBloc.add(FilteredListRequestedHomeEvent());
  //   } else {
  //     _homeBloc.add(KeywordChangedHomeEvent(queryString));
  //   }

  //   return queryString;
  // }
}
