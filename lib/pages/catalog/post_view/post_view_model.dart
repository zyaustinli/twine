import '/flutter_flow/flutter_flow_util.dart';
import 'post_view_widget.dart' show PostViewWidget;
import 'package:flutter/material.dart';

class PostViewModel extends FlutterFlowModel<PostViewWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
