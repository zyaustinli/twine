import 'dart:async';
import 'dart:ui' as ui;

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'create_outfit_model.dart';
export 'create_outfit_model.dart';

import './../../../components/create_outfit_search_widget.dart';
import 'outfit_manager.dart';

class CreateOutfitWidget extends StatefulWidget {
  const CreateOutfitWidget({super.key});

  @override
  State<CreateOutfitWidget> createState() => _CreateOutfitWidgetState();
}


class DraggableImage {
  final String url;
  final String productId;
  Offset position;
  ui.Image? image;
  List<List<bool>>? hitMap;
  bool isDragging = false;
  double scale = 1.0;
  
  DraggableImage(this.url, this.productId, this.position);
}

class _CreateOutfitWidgetState extends State<CreateOutfitWidget> {
  late CreateOutfitModel _model;
  final GlobalKey stackKey = GlobalKey();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<DraggableImage> draggableImages = [];
  String? draggedImageUrl;
  bool isImageBeingDragged = false;
  Offset? currentDragPosition;
  late Rect trashArea;
  Color trashIconColor = Colors.black;

  Color backgroundColor = Colors.white; // Default background color
  final double _lastScale = 1.0;

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

  void deleteImage(String imageUrl) {
    setState(() {
      draggableImages.removeWhere((image) => image.url == imageUrl);
    });
  }

  Future<List<List<bool>>> computeHitMap(ui.Image image) async {
    try {
      // Get the image data as raw RGBA bytes
      final byteData =
          await image.toByteData(format: ui.ImageByteFormat.rawRgba);
      if (byteData == null) {
        // If ByteData is null, return a hit map filled with true
        print("ByteData is null");
        return List.generate(
            image.height, (_) => List.filled(image.width, true));
      }

      // Convert ByteData to a Uint8List for easier processing
      final buffer = byteData.buffer;
      final uint8List = buffer.asUint8List();

      // Initialize the hit map with the same dimensions as the image, all values set to false
      List<List<bool>> hitMap = List.generate(
        image.height,
        (_) => List.filled(image.width, false),
      );

      // Calculate the number of bytes per row (4 bytes per pixel for RGBA)
      int bytesPerRow = image.width * 4;

      // Iterate over each pixel in the image
      for (int y = 0; y < image.height; y++) {
        for (int x = 0; x < image.width; x++) {
          // Calculate the index for the alpha channel
          final int index =
              y * bytesPerRow + x * 4 + 3; // +3 to get the alpha channel

          // Ensure the index is within bounds of the Uint8List
          if (index < uint8List.length) {
            // Set hitMap to true if the alpha value is greater than 0 (not fully transparent)
            hitMap[y][x] = uint8List[index] > 0;
          }
        }
      }

      // Return the completed hit map
      return hitMap;
    } catch (e) {
      // Print the error and return a hit map filled with true in case of failure
      print("Error in computeHitMap: $e");
      return List.generate(image.height, (_) => List.filled(image.width, true));
    }
  }

  void addImage(String imageUrl, String productId) async {
  print("Adding image: $imageUrl with productId: $productId");
  try {
    final completer = Completer<ui.Image>();
    final imageStream = NetworkImage(imageUrl).resolve(const ImageConfiguration());
    imageStream.addListener(ImageStreamListener((info, _) {
      completer.complete(info.image);
    }));

    final image = await completer.future;
    final hitMap = await computeHitMap(image);

    setState(() {
      draggableImages.add(DraggableImage(
        imageUrl,
        productId,
        Offset(MediaQuery.of(context).size.width / 2 - 100,
            MediaQuery.of(context).size.height * 0.375 - 100),
      )
        ..image = image
        ..hitMap = hitMap
        ..scale = 1.0); // Initialize scale
    });
    print("Image added. Total images: ${draggableImages.length}");
  } catch (e) {
    print("Error adding image: $e");
  }
}

  void moveImageToTop(String imageUrl) {
    setState(() {
      int index = draggableImages.indexWhere((image) => image.url == imageUrl);
      if (index != -1 && index != draggableImages.length - 1) {
        DraggableImage image = draggableImages.removeAt(index);
        draggableImages.add(image);
      }
    });
  }

  bool isPointNotTransparent(
      DraggableImage draggableImage, Offset localPosition,
      {int radius = 100}) {
    if (draggableImage.hitMap == null || draggableImage.image == null) {
      print("HitMap or Image is null");
      return true;
    }

    final int imageWidth = draggableImage.image!.width;
    final int imageHeight = draggableImage.image!.height;

    // Adjust for scaling
    final double scaledRadius = radius / draggableImage.scale;
    final double scaledX = localPosition.dx / draggableImage.scale;
    final double scaledY = localPosition.dy / draggableImage.scale;

    final int centerX = (scaledX * imageWidth / 200).round();
    final int centerY = (scaledY * imageHeight / 200).round();

    final int startX =
        (centerX - scaledRadius).clamp(0, imageWidth - 1).round();
    final int endX = (centerX + scaledRadius).clamp(0, imageWidth - 1).round();
    final int startY =
        (centerY - scaledRadius).clamp(0, imageHeight - 1).round();
    final int endY = (centerY + scaledRadius).clamp(0, imageHeight - 1).round();

    print("Checking area: ($startX, $startY) to ($endX, $endY)");
    print("Image size: ${imageWidth}x$imageHeight");
    print(
        "HitMap size: ${draggableImage.hitMap!.length}x${draggableImage.hitMap![0].length}");

    for (int y = startY; y <= endY; y++) {
      for (int x = startX; x <= endX; x++) {
        if (draggableImage.hitMap![y][x]) {
          print("Found non-transparent pixel at ($x, $y)");
          return true;
        }
      }
    }

    print("All checked pixels are transparent");
    return false;
  }

  void _showColorPicker() {
    Color currentColor = Colors.white; // Default color, change as needed

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentColor,
              onColorChanged: (Color color) {
                setState(() {
                  currentColor = color;
                  backgroundColor = color;
                });
              },
              colorPickerWidth: 300,
              pickerAreaHeightPercent: 0.7,
              enableAlpha: false,
              labelTypes: const [],
              displayThumbColor: false,
              paletteType: PaletteType.hsl,
              pickerAreaBorderRadius: const BorderRadius.only(
                topLeft: Radius.circular(2),
                topRight: Radius.circular(2),
              ),
              hexInputBar: false,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                // Apply the selected color to the background
                setState(() {
                  // Assuming you're changing the scaffold background color
                  // You might need to adjust this based on your app structure
                  backgroundColor = currentColor;
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double trashIconSize = 60;
    double trashIconBottom = 20;
    trashArea = Rect.fromLTWH(
        MediaQuery.of(context).size.width / 2 - trashIconSize / 2,
        MediaQuery.of(context).size.height * 0.85 -
            trashIconSize -
            trashIconBottom,
        trashIconSize,
        trashIconSize);
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
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.85,
                child: Stack(
                  key: stackKey,
                  children: [
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: backgroundColor,
                      ),
                      child: Stack(
                        children: [
                          ...draggableImages.map((draggableImage) {
                            return Positioned(
                              left: draggableImage.position.dx,
                              top: draggableImage.position.dy,
                              child: GestureDetector(
                                onScaleStart: (ScaleStartDetails details) {
                                  setState(() {
                                    draggableImage.isDragging = true;
                                    draggedImageUrl = draggableImage.url;
                                    moveImageToTop(draggableImage.url);
                                    isImageBeingDragged = true;
                                    currentDragPosition = details.focalPoint;
                                  });
                                },
                                onScaleUpdate: (ScaleUpdateDetails details) {
                                  if (draggableImage.isDragging &&
                                      draggedImageUrl == draggableImage.url) {
                                    setState(() {
                                      // Calculate new position
                                      Offset newPosition =
                                          draggableImage.position +
                                              details.focalPointDelta;

                                      // Get the size of the screen
                                      Size screenSize =
                                          MediaQuery.of(context).size;

                                      // Calculate the scaled size of the image
                                      double scaledWidth =
                                          200 * draggableImage.scale;
                                      double scaledHeight =
                                          200 * draggableImage.scale;

                                      

                                      // Update the position
                                      draggableImage.position = newPosition;
                                      currentDragPosition = details.focalPoint;

                                      // Update scale more gradually
                                      if ((details.scale - 1.0).abs() > 0.01) {
                                        double newScale =
                                            _lastScale * details.scale;
                                        draggableImage.scale =
                                            newScale.clamp(0.5, 3.0);
                                      }

                                      if (trashArea
                                          .contains(currentDragPosition!)) {
                                        trashIconColor = Colors.red;
                                      } else {
                                        trashIconColor = Colors.black;
                                      }
                                    });
                                  }
                                },
                                onScaleEnd: (ScaleEndDetails details) {
                                  setState(() {
                                    draggableImage.isDragging = false;
                                    draggedImageUrl = null;
                                    isImageBeingDragged = false;

                                    if (currentDragPosition != null &&
                                        trashArea
                                            .contains(currentDragPosition!)) {
                                      deleteImage(draggableImage.url);
                                    }
                                    draggedImageUrl = null;
                                    currentDragPosition = null;
                                    trashIconColor = Colors.black;
                                  });
                                },
                                child: Transform.scale(
                                  scale: draggableImage.scale,
                                  child: Image.network(
                                    draggableImage.url,
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          }),
                          if (isImageBeingDragged)
                            Positioned(
                              bottom: 20,
                              left: MediaQuery.of(context).size.width / 2 - 30,
                              child: Icon(
                                Icons.delete,
                                color: trashIconColor,
                                size: 50,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (draggedImageUrl == null)
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      15, 0, 0, 0),
                                  child: FlutterFlowIconButton(
                                    borderRadius: 24,
                                    borderWidth: 1,
                                    buttonSize: 50,
                                    fillColor: const Color(0xB214181B),
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
                                  fillColor: const Color(0xB214181B),
                                  icon: FaIcon(
                                    FontAwesomeIcons.pencilAlt,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    size: 24,
                                  ),
                                  onPressed: _showColorPicker,
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      15, 0, 10, 0),
                                  child: FlutterFlowIconButton(
                                    borderRadius: 24,
                                    borderWidth: 1,
                                    buttonSize: 50,
                                    fillColor: const Color(0xB214181B),
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
                                          return SizedBox(
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
                height: MediaQuery.sizeOf(context).height * 0.10,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  border: const Border(top: BorderSide(color: Colors.black)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
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
                                    const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                iconPadding:
                                    const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
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
                                const EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
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
                              onPressed: () async {
                                await OutfitManager.saveOutfit(draggableImages, backgroundColor, stackKey);
                                // You can add a snackbar or navigation here to indicate successful saving
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Outfit saved successfully!')),
                                );
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

/*
Certainly! I'll modify the code to implement the functionality you've described. Here's how we can adapt the _CreateOutfitWidgetState class to include these new features:

First, we'll add necessary imports for Firebase and image manipulation:

dartCopyimport 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';

Next, we'll add a method to capture the current state of the draggable stack as an image:

dartCopyFuture<Uint8List> captureStackAsImage() async {
  RenderRepaintBoundary boundary = context.findRenderObject() as RenderRepaintBoundary;
  ui.Image image = await boundary.toImage(pixelRatio: 3.0);
  ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  return byteData!.buffer.asUint8List();
}

We'll create a method to save the outfit data to Firestore:

dartCopyFuture<void> saveOutfitData(String imageUrl) async {
  final uuid = Uuid();
  final outfitId = uuid.v4();
  
  List<Map<String, dynamic>> imagesData = draggableImages.map((image) => {
    'url': image.url,
    'position': {'dx': image.position.dx, 'dy': image.position.dy},
    'scale': image.scale,
  }).toList();

  await FirebaseFirestore.instance.collection('outfits').doc(outfitId).set({
    'id': outfitId,
    'imageUrl': imageUrl,
    'backgroundColor': backgroundColor.value,
    'images': imagesData,
    'createdAt': FieldValue.serverTimestamp(),
  });
}

Now, let's create a method to handle the saving and uploading process:

dartCopyFuture<void> saveAndUploadOutfit() async {
  try {
    // Capture the stack as an image
    Uint8List imageBytes = await captureStackAsImage();

    // Upload the image to Firebase Storage
    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef.child('outfits/${Uuid().v4()}.png');
    await imageRef.putData(imageBytes);
    String downloadUrl = await imageRef.getDownloadURL();

    // Save the outfit data to Firestore
    await saveOutfitData(downloadUrl);

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Outfit saved successfully!')),
    );
  } catch (e) {
    print('Error saving outfit: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to save outfit. Please try again.')),
    );
  }
}

Finally, we'll update the onPressed callback for the chevron_right button:

dartCopyPadding(
  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
  child: FlutterFlowIconButton(
    borderColor: FlutterFlowTheme.of(context).primaryText,
    borderRadius: 24,
    borderWidth: 1,
    buttonSize: 50,
    fillColor: FlutterFlowTheme.of(context).primaryText,
    icon: Icon(
      Icons.chevron_right,
      color: FlutterFlowTheme.of(context).secondaryBackground,
      size: 34,
    ),
    onPressed: saveAndUploadOutfit,
  ),
),
These modifications will allow users to save their outfits to Firebase, including both the final image and the data necessary to reconstruct the draggable stack for future editing.
To implement this fully, you'll need to:

Set up Firebase in your Flutter project if you haven't already.
Add the necessary Firebase dependencies to your pubspec.yaml file.
Initialize Firebase in your main.dart file.
Handle user authentication to associate outfits with specific users.
Implement a method to load and reconstruct saved outfits for editing.

Remember to handle potential errors and edge cases, such as network issues or insufficient permissions, to ensure a smooth user experience.
*/