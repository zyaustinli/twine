//import '/backend/backend.dart';
import 'package:redthread/flutter_flow/form_field_controller.dart';

import '/components/rate_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'singleview_widget.dart' show SingleviewWidget;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SingleviewModel extends FlutterFlowModel<SingleviewWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for Carousel widget.
  CarouselController? carouselController;
  int carouselCurrentIndex = 1;

  // Model for rate component.
  late RateModel rateModel;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;

  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;

  @override
  void initState(BuildContext context) {
    rateModel = createModel(context, () => RateModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    rateModel.dispose();
  }
}
