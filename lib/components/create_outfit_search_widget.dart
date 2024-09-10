import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'create_outfit_search_model.dart';
import '../components/product_widget.dart';
import '../classes/product_class.dart';

class CreateOutfitSearchWidget extends StatefulWidget {
  final Function(String imageUrl, String productId) onImageSelected;

  const CreateOutfitSearchWidget({
    Key? key,
    required this.onImageSelected,
  }) : super(key: key);

  @override
  State<CreateOutfitSearchWidget> createState() => _CreateOutfitSearchWidgetState();
}

class _CreateOutfitSearchWidgetState extends State<CreateOutfitSearchWidget> {
  late CreateOutfitSearchModel _model;

  @override
  void initState() {
    super.initState();
    _model = CreateOutfitSearchModel();
    _model.loadInitialProducts();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: AlignmentDirectional(0, 1),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
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
                        Icons.keyboard_arrow_down,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _model.textController,
                        focusNode: _model.textFieldFocusNode,
                        autofocus: false,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: FlutterFlowTheme.of(context).bodySmall,
                          hintText: 'Search',
                          hintStyle: FlutterFlowTheme.of(context).labelMedium,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          prefixIcon: Icon(Icons.search_sharp),
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium,
                        onChanged: (value) => _model.searchProducts(value),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
              child: AnimatedBuilder(
                animation: _model,
                builder: (context, child) {
                  if (_model.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return GridView.builder(
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: _model.searchResults.length,
                    itemBuilder: (context, index) {
                      Product product = _model.searchResults[index];
                      return ProductWidget(
                        product: product,
                        onTap: () {
                          widget.onImageSelected(product.imageUrl, product.id);
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}