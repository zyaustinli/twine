import '/flutter_flow/flutter_flow_count_controller.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'cart_item_model.dart';
export 'cart_item_model.dart';
import '../pages/shoppingcart/cart/cart_item.dart';

//TO DO: reflect the data from the cartItem class inside the text boxes, like widget.item.brandName, etc

class CartItemWidget extends StatefulWidget {
  final CartItem item;
  final Function(int) onQuantityChanged;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.onQuantityChanged,
  });

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  late CartItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CartItemModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(25, 5, 25, 0),
      child: Container(
        width: 100,
        height: 200,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        widget.item.image,
                        width: 145,
                        height: 180,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Container(
                    width: 190,
                    height: 180,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 190,
                          height: 125,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.item.productName,
                                    maxLines: 2,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  Align(
                                    alignment: const AlignmentDirectional(0, 0),
                                    child: Text(
                                      widget.item.price.toString(),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: const AlignmentDirectional(-1, 0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Text(
                                    widget.item.size,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0,
                                        ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Applied discounts',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                    Align(
                                      alignment: const AlignmentDirectional(0, 0),
                                      child: Text(
                                        widget.item.discount.toString(),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: const AlignmentDirectional(-1, 0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Text(
                                    widget.item.brandName,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 190,
                          height: 40,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: const AlignmentDirectional(-1, 1),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 0, 0),
                                  child: Container(
                                    width: 100,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF5F7FC),
                                      borderRadius: BorderRadius.circular(8),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                        color: const Color(0xFFF5F7FC),
                                        width: 0,
                                      ),
                                    ),
                                    child: FlutterFlowCountController(
                                      decrementIconBuilder: (enabled) => FaIcon(
                                        FontAwesomeIcons.minus,
                                        color: enabled
                                            ? FlutterFlowTheme.of(context)
                                                .primaryText
                                            : FlutterFlowTheme.of(context)
                                                .alternate,
                                        size: 15,
                                      ),
                                      incrementIconBuilder: (enabled) => FaIcon(
                                        FontAwesomeIcons.plus,
                                        color: enabled
                                            ? FlutterFlowTheme.of(context)
                                                .primaryText
                                            : FlutterFlowTheme.of(context)
                                                .alternate,
                                        size: 15,
                                      ),
                                      countBuilder: (count) => Text(
                                        count.toString(),
                                        style: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .override(
                                              fontFamily: 'Outfit',
                                              fontSize: 16,
                                              letterSpacing: 0,
                                            ),
                                      ),
                                      count: widget.item.quantity,
                                      updateCount: (count) {
                                        setState(() {
                                          widget.item.quantity =
                                              count; // Update the quantity in the model.
                                        });
                                        widget.onQuantityChanged(
                                            count); // Notify parent widget of the change.
                                      },
                                      stepSize: 1,
                                      contentPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              10, 0, 10, 0),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: const AlignmentDirectional(1, 1),
                                child: FlutterFlowIconButton(
                                  borderRadius: 20,
                                  borderWidth: 1,
                                  buttonSize: 40,
                                  icon: Icon(
                                    Icons.keyboard_control,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 24,
                                  ),
                                  onPressed: () {
                                    print('IconButton pressed ...');
                                  },
                                ),
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
          ],
        ),
      ),
    );
  }
}
