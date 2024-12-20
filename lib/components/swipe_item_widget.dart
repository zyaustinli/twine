import 'package:redthread/flutter_flow/form_field_controller.dart';

import '/components/rate_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sizer/sizer.dart';
//import 'package:go_router/go_router.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';

class SwipeItemModel extends FlutterFlowModel {
  CarouselController? carouselController;
  int carouselCurrentIndex = 1;

  FormFieldController<String>? dropDownValueController;

  late RateModel rateModel;

  void initState(BuildContext context) {
    rateModel = createModel(context, () => RateModel());
  }

  void dispose() {
    rateModel.dispose();
  }
}

class SwipeItemWidget extends StatefulWidget {
  const SwipeItemWidget({Key? key}) : super(key: key);

  @override
  _SwipeItemWidgetState createState() => _SwipeItemWidgetState();
}

class _SwipeItemWidgetState extends State<SwipeItemWidget> {
  late SwipeItemModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SwipeItemModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: const BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 325.0,
            height: 275.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              border: Border.all(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                width: 0.0,
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 180.0,
              child: CarouselSlider(
                items: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(0.0),
                    child: Image.network(
                      'https://picsum.photos/seed/926/600',
                      width: 300.0,
                      height: 200.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(0.0),
                    child: Image.network(
                      'https://picsum.photos/seed/793/600',
                      width: 300.0,
                      height: 200.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(0.0),
                    child: Image.network(
                      'https://picsum.photos/seed/868/600',
                      width: 300.0,
                      height: 200.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(0.0),
                    child: Image.network(
                      'https://picsum.photos/seed/893/600',
                      width: 300.0,
                      height: 200.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
                carouselController: _model.carouselController ??= CarouselController(),
                options: CarouselOptions(
                  initialPage: 1,
                  viewportFraction: 0.8,
                  disableCenter: true,
                  enlargeCenterPage: false,
                  enlargeFactor: 0.0,
                  enableInfiniteScroll: true,
                  scrollDirection: Axis.horizontal,
                  autoPlay: false,
                  onPageChanged: (index, _) => _model.carouselCurrentIndex = index,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
            child: Container(
              width: 325.0,
              height: 110.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                border: Border.all(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  width: 0.0,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 30.w,
                        height: 40,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Align(
                          alignment: const AlignmentDirectional(-1, 0),
                          child: AutoSizeText(
                            'item_name',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Inter',
                              fontSize: 22,
                              letterSpacing: 0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      FlutterFlowDropDown<String>(
                        controller: _model.dropDownValueController ??= FormFieldController<String>(null),
                        options: ['Share', 'Report', 'Not Interested'],
                        onChanged: (val) => print(val),
                        width: 100,
                        height: 5.9.h,
                        textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0,
                        ),
                        icon: Icon(
                          Icons.keyboard_control,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 24,
                        ),
                        fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                        elevation: 2,
                        borderColor: Colors.transparent,
                        borderWidth: 2,
                        borderRadius: 8,
                        margin: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                        hidesUnderline: true,
                        isOverButton: true,
                        isSearchable: false,
                        isMultiSelect: false,
                        labelText: "",
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                    child: Container(
                      width: 90,
                      height: 25,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryText,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(-1, 0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: Image.network(
                                  'https://picsum.photos/seed/592/600',
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(3, 0, 2, 0),
                            child: Text(
                              'BRAND',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context).primaryBackground,
                                fontSize: 10,
                                letterSpacing: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: Container(
                      decoration: const BoxDecoration(),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '\$795.99',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Bebas Neue',
                              fontSize: 18,
                              letterSpacing: 0,
                            ),
                          ),
                          wrapWithModel(
                            model: _model.rateModel,
                            updateCallback: () => setState(() {}),
                            updateOnChange: true,
                            child: RateWidget(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(0.0, 1.0),
            child: Container(
              width: 370.0,
              height: 35.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                border: Border.all(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  width: 0.0,
                ),
              ),
              child: Align(
                alignment: const AlignmentDirectional(0.0, 1.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                          child: ListView(
                            padding: const EdgeInsets.fromLTRB(
                              24.0,
                              0,
                              0,
                              0,
                            ),
                            scrollDirection: Axis.horizontal,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
                                child: FFButtonWidget(
                                  onPressed: () {
                                    print('Button pressed ...');
                                  },
                                  text: 'FREE SHIPPING',
                                  icon: const FaIcon(
                                    FontAwesomeIcons.truck,
                                    size: 15.0,
                                  ),
                                  options: FFButtonOptions(
                                    height: 20.0,
                                    padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                                    iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                      fontFamily: 'Oswald',
                                      color: const Color(0xFF026F01),
                                      fontSize: 1.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                    elevation: 0.0,
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                ),
                              ),
                              // Add more buttons as needed
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(0.0, 1.0),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
              child: Container(
                width: 370.0,
                height: 30.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    width: 0.0,
                  ),
                ),
                child: Align(
                  alignment: const AlignmentDirectional(0.0, 1.0),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
                            child: ListView(
                              padding: const EdgeInsets.fromLTRB(
                                24.0,
                                0,
                                0,
                                0,
                              ),
                              scrollDirection: Axis.horizontal,
                              children: [
                                FlutterFlowIconButton(
                                  borderColor: FlutterFlowTheme.of(context).primary,
                                  borderRadius: 20.0,
                                  borderWidth: 0.0,
                                  buttonSize: 20.0,
                                  fillColor: FlutterFlowTheme.of(context).accent1,
                                  icon: Icon(
                                    Icons.add,
                                    color: FlutterFlowTheme.of(context).primaryText,
                                ),
                                  onPressed: () {
                                    print('IconButton pressed ...');
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 325.0,
            height: 100.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              border: Border.all(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                width: 0.0,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ShaderMask(
                    shaderCallback: (Rect rect) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black,
                          Colors.black.withOpacity(0.1)
                        ],
                        stops: const [0, 1],
                      ).createShader(rect);
                    },
                    blendMode: BlendMode.dstIn,
                    child: SingleChildScrollView(
                      child: Text(
                        'Introducing our exquisite collection of sunglasses, a pinnacle of luxury and style. Crafted for the discerning individuals who appreciate the finer things in life, our high-end brand seamlessly blends fashion with functionality. Each pair is meticulously designed with precision, using premium materials that embody sophistication. The lenses offer unparalleled clarity and UV protection, ensuring not just a fashion statement but also optimal eye care.',
                        maxLines: 4,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0.0,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}