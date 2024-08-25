import 'package:redthread/pages/catalog/search_results/search_database_service.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

import 'search_results_model.dart';
export 'search_results_model.dart';
import '../../../classes/post_class.dart';
import '../../../classes/product_class.dart';
import '../../../classes/user_class.dart';
import '../../../components/product_widget.dart';
import '../../../components/user_list_widget.dart';

class SearchResultsWidget extends StatefulWidget {
  final String initialQuery;

  const SearchResultsWidget({Key? key, this.initialQuery = ''})
      : super(key: key);

  @override
  State<SearchResultsWidget> createState() => _SearchResultsWidgetState();
}

class _SearchResultsWidgetState extends State<SearchResultsWidget>
    with TickerProviderStateMixin {
  late SearchResultsModel _model;
  final SearchDatabaseService _searchDatabaseService = SearchDatabaseService();
  List<Product> filteredProducts = [];
  List<Post> filteredPosts = [];
  List<User> filteredUsers = [];
  bool isLoading = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchResultsModel());

    _model.textController ??= TextEditingController(text: widget.initialQuery);
    _model.textFieldFocusNode ??= FocusNode();

    _model.tabBarController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
    _performSearch(widget.initialQuery);
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) return;
    setState(() {
      isLoading = true;
    });

    try {
      final products =
          await _searchDatabaseService.getProducts(searchQuery: query);
      final posts = await _searchDatabaseService.getPosts();
      final users = await _searchDatabaseService.getUsers(searchQuery: query);

      setState(() {
        filteredProducts = products;
        filteredPosts = posts;
        filteredUsers = users;
        isLoading = false;
      });
    } catch (e) {
      // Handle any errors here
      print('Error performing search: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(10),
          child: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            automaticallyImplyLeading: false,
            actions: const [],
            centerTitle: false,
            elevation: 0,
          ),
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: const AlignmentDirectional(0, 1),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        width: 0,
                      ),
                    ),
                    child: Align(
                      alignment: const AlignmentDirectional(0, 1),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 30,
                            borderWidth: 1,
                            buttonSize: 40,
                            icon: Icon(
                              Icons.arrow_back_rounded,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              //pop twice to go back to search and then back to whatever was before
                            },
                          ),
                          Container(
                            width: 325,
                            height: 100,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0),
                              ),
                              shape: BoxShape.rectangle,
                            ),
                            child: TextFormField(
                              controller: _model.textController,
                              focusNode: _model.textFieldFocusNode,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelStyle: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0,
                                    ),
                                hintStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      fontSize: 12,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                prefixIcon: const Icon(
                                  Icons.search_sharp,
                                ),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    fontSize: 12,
                                    letterSpacing: 0,
                                  ),
                              onFieldSubmitted: (value) {
                                if (value.trim().isNotEmpty) {
                                  _performSearch(value.trim());
                                }
                                // If value is empty, do nothing
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Align(
                      alignment: const Alignment(0, 0),
                      child: TabBar(
                        labelColor: FlutterFlowTheme.of(context).primaryText,
                        unselectedLabelColor:
                            FlutterFlowTheme.of(context).secondaryText,
                        labelStyle:
                            FlutterFlowTheme.of(context).titleMedium.override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 12,
                                  letterSpacing: 0,
                                ),
                        unselectedLabelStyle: const TextStyle(),
                        indicatorColor:
                            FlutterFlowTheme.of(context).primaryText,
                        padding: const EdgeInsets.all(4),
                        tabs: const [
                          Tab(
                            text: 'Products',
                          ),
                          Tab(
                            text: 'Posts',
                          ),
                          Tab(
                            text: 'Users',
                          ),
                        ],
                        controller: _model.tabBarController,
                        onTap: (i) async {
                          [() async {}, () async {}, () async {}][i]();
                        },
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _model.tabBarController,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10, 0, 10, 0),
                            child: Container(
                              decoration: const BoxDecoration(),
                              child: GridView.builder(
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 0.75,
                                ),
                                scrollDirection: Axis.vertical,
                                itemCount: filteredProducts.length,
                                itemBuilder: (context, index) {
                                  return ProductWidget(
                                      product: filteredProducts[index],
                                      onTap: () {
                                        //should create a singleview page, and push the product id so that it can retrieve product data from firebase
                                      });
                                },
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 0, 10, 0),
                              child: GridView.builder(
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 0.7,
                                ),
                                itemCount: filteredPosts.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      //navigate to post_view page and pass ni data again
                                    },
                                    child: Image.network(
                                      filteredPosts[index].imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              )),
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: filteredUsers.length,
                            
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 5),
                                child: UserListWidget(
                                user: filteredUsers[index],
                                onTap: () {
                                  //should take you to userprofile page, passing in id so taht it can retrieve user data from firebase
                                },
                              ),
                              );
                              
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
