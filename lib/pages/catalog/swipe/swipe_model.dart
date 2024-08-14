//import '/backend/backend.dart';
import '/components/rate_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'swipe_widget.dart' show SwipeWidget;
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SwipeModel extends FlutterFlowModel<SwipeWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  CarouselController? carouselController;
  int carouselCurrentIndex = 1;

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Model for rate component.
  late RateModel rateModel;

  @override
  void initState(BuildContext context) {
    rateModel = createModel(context, () => RateModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();

    rateModel.dispose();
  }
}
