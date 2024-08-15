import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'create_outfit_model.dart';
export 'create_outfit_model.dart';

import './../../../components/create_outfit_search_widget.dart';
import 'draggable_image.dart';

class CreateOutfitWidget extends StatefulWidget {
  const CreateOutfitWidget({super.key});

  @override
  State<CreateOutfitWidget> createState() => _CreateOutfitWidgetState();
}

class _CreateOutfitWidgetState extends State<CreateOutfitWidget> {
  late CreateOutfitModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<DraggableImage> draggableImages = [];
  bool isDragging = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateOutfitModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  void addImage(String imageUrl) {
    setState(() {
      // Add new image at the center of the container
      draggableImages.add(DraggableImage(
          imageUrl,
          Offset(MediaQuery.of(context).size.width / 2 - 50,
              MediaQuery.of(context).size.height * 0.375 - 50)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height * 0.80,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Stack(
                        children: draggableImages.map((draggableImage) {
                          return Positioned(
                            left: draggableImage.position.dx,
                            top: draggableImage.position.dy,
                            child: Draggable<String>(
                              data: draggableImage.url,
                              onDragStarted: () {
                                setState(() {
                                  isDragging = true;
                                });
                              },
                              onDraggableCanceled: (_, __) {
                                setState(() {
                                  isDragging = false;
                                });
                              },
                              feedback: Image.network(
                                draggableImage.url,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                              childWhenDragging: Container(),
                              onDragEnd: (details) {
                                setState(() {
                                  draggableImage.position = details.offset;
                                  isDragging = false;
                                });
                              },
                              child: Image.network(
                                draggableImage.url,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (!isDragging)
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15, 0, 0, 0),
                                  child: FlutterFlowIconButton(
                                    borderRadius: 24,
                                    borderWidth: 1,
                                    buttonSize: 50,
                                    fillColor: Color(0xB214181B),
                                    icon: Icon(
                                      Icons.chevron_left,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      size: 34,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                Container(
                                  width: 195,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.0),
                                  ),
                                ),
                                FlutterFlowIconButton(
                                  borderRadius: 24,
                                  borderWidth: 1,
                                  buttonSize: 50,
                                  fillColor: Color(0xB214181B),
                                  icon: FaIcon(
                                    FontAwesomeIcons.pencilAlt,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    size: 24,
                                  ),
                                  onPressed: () {
                                    print('IconButton pressed ...');
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15, 0, 10, 0),
                                  child: FlutterFlowIconButton(
                                    borderRadius: 24,
                                    borderWidth: 1,
                                    buttonSize: 50,
                                    fillColor: Color(0xB214181B),
                                    icon: Icon(
                                      Icons.add,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (BuildContext context) {
                                          return Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .9,
                                            child: CreateOutfitSearchWidget(
                                              onImageSelected: addImage,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Divider(
                      thickness: 1,
                      color: FlutterFlowTheme.of(context).primaryText,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                            child: FFButtonWidget(
                              onPressed: () {
                                print('Button pressed ...');
                              },
                              text: 'Save',
                              icon: Icon(
                                Icons.save_alt,
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                size: 24,
                              ),
                              options: FFButtonOptions(
                                width: 100,
                                height: 50,
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                iconPadding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                color: FlutterFlowTheme.of(context).primaryText,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      fontSize: 12,
                                      letterSpacing: 0,
                                    ),
                                borderSide: BorderSide(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                            child: FlutterFlowIconButton(
                              borderColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              borderRadius: 24,
                              borderWidth: 1,
                              buttonSize: 50,
                              fillColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              icon: Icon(
                                Icons.chevron_right,
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                size: 34,
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
      ),
    );
  }
}
