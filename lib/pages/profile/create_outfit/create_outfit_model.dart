import '/flutter_flow/flutter_flow_util.dart';
import 'create_outfit_widget.dart' show CreateOutfitWidget;
import 'package:flutter/material.dart';

class CreateOutfitModel extends FlutterFlowModel<CreateOutfitWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
