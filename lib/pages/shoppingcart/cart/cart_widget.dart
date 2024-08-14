import '/flutter_flow/flutter_flow_autocomplete_options_list.dart';
import '/flutter_flow/flutter_flow_count_controller.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'cart_model.dart';
export 'cart_model.dart';
import 'cart_item.dart';

import '../../../components/cart_item_widget.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  late CartModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CartModel());

    _model.textController ??= TextEditingController();

    _model.cartItems = [
      //just a test model
      CartItem(
        image:
            'https://m.media-amazon.com/images/I/51ulmT3YUZL._AC_UY1000_.jpg',
        brandName: 'Brand 1',
        productName: 'Product 1',
        price: 29.99,
        size: 'M',
        color: 'Red',
        discount: 0,
        quantity: 1
      )
    ];
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  double _calculateSubtotal() {
    return _model.cartItems
        .fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      0.0, 10.0, 0.0, 10.0),
                  child: Container(
                    width: 340.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      ),
                    ),
                    child: Autocomplete<String>(
                      initialValue: const TextEditingValue(),
                      optionsBuilder: (textEditingValue) {
                        if (textEditingValue.text == '') {
                          return const Iterable<String>.empty();
                        }
                        return ['Option 1'].where((option) {
                          final lowercaseOption = option.toLowerCase();
                          return lowercaseOption
                              .contains(textEditingValue.text.toLowerCase());
                        });
                      },
                      optionsViewBuilder: (context, onSelected, options) {
                        return AutocompleteOptionsList(
                          textFieldKey: _model.textFieldKey,
                          textController: _model.textController!,
                          options: options.toList(),
                          onSelected: onSelected,
                          textStyle:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                          textHighlightStyle: const TextStyle(),
                          elevation: 4.0,
                          optionBackgroundColor:
                              FlutterFlowTheme.of(context).primaryBackground,
                          optionHighlightColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          maxHeight: 200.0,
                        );
                      },
                      onSelected: (String selection) {
                        setState(
                            () => _model.textFieldSelectedOption = selection);
                        FocusScope.of(context).unfocus();
                      },
                      fieldViewBuilder: (
                        context,
                        textEditingController,
                        focusNode,
                        onEditingComplete,
                      ) {
                        _model.textFieldFocusNode = focusNode;

                        _model.textController = textEditingController;
                        return TextFormField(
                          key: _model.textFieldKey,
                          controller: textEditingController,
                          focusNode: focusNode,
                          onEditingComplete: onEditingComplete,
                          autofocus: false,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: ' Search',
                            labelStyle:
                                FlutterFlowTheme.of(context).bodySmall.override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Inter',
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 12.0,
                                  letterSpacing: 0.0,
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
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                  ),
                          validator: _model.textControllerValidator
                              .asValidator(context),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-1.0, 0.0),
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(25.0, 5.0, 0.0, 0.0),
                  child: Text(
                    'Subtotal: \$${_calculateSubtotal().toStringAsFixed(2)}',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          fontSize: 22.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
              ),
              _model.cartItems.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 15.0, 0.0, 5.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            text: 'PROCEED TO CHECKOUT',
                            options: FFButtonOptions(
                              width: 245.0,
                              height: 45.0,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).primaryText,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                  ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            text: 'Gift',
                            options: FFButtonOptions(
                              width: 80.0,
                              height: 45.0,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                  ),
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              Align(
                alignment: const AlignmentDirectional(-1.0, 0.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      25.0, 10.0, 0.0, 0.0),
                  child: Text(
                    'Spend x more dollars to qualify for free shipping!',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(25, 10, 10, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).primaryText,
                          ),
                        ),
                        child: LinearPercentIndicator(
                          percent: 0,
                          width: 300,
                          lineHeight: 15,
                          animation: true,
                          animateFromLastPercent: true,
                          progressColor: Color(0xFFFF0000),
                          backgroundColor: FlutterFlowTheme.of(context).accent4,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 10.0, 0.0, 0.0),
                    child: Text(
                      '\$0',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            fontSize: 18.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: _model.cartItems.isEmpty
                    ? Center(
                        child: Text(
                          'Your cart is empty',
                          style: FlutterFlowTheme.of(context).headlineMedium,
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: _model.cartItems.length,
                        itemBuilder: (context, index) {
                          final cartItem = _model.cartItems[index];
                          return CartItemWidget(
                            item: cartItem,
                            onQuantityChanged: (newQuantity) {
                              setState(() {
                                if (newQuantity == 0) {
                                  _model.cartItems.removeAt(index);
                                } else {
                                  cartItem.quantity = newQuantity;
                                }
                              });
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
