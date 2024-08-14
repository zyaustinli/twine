//import '/backend/backend.dart';
import '/components/rate_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'test_widget.dart' show TestWidget;
import 'package:flutter/material.dart';

class TestModel extends FlutterFlowModel<TestWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for rate component.
  late RateModel rateModel;

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
