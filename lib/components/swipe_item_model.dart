// File path: models/swipe_item_model.dart

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:redthread/flutter_flow/form_field_controller.dart';
import '/components/rate_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SwipeItemModel extends FlutterFlowModel {
  // Carousel controller to manage carousel states
  CarouselController? carouselController;
  // Index to track the current carousel item
  int carouselCurrentIndex = 0;

  // Controller for the dropdown to manage its state
  FormFieldController<String>? dropDownValueController;

  // RateModel to manage rating-related logic
  late RateModel rateModel;

  // Initialize the model, setting up controllers and other initial values
  void initState(BuildContext context) {
    // Initialize RateModel instance using createModel function
    rateModel = createModel(context, () => RateModel());

    // Initialize the carousel controller if it's null
    carouselController ??= CarouselController();
  }

  // Dispose method to clean up resources
  void dispose() {
    // Dispose of RateModel when the SwipeItemModel is disposed
    rateModel.dispose();
  }
}
