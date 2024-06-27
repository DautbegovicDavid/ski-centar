import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';
import 'package:skicentar_desktop/utils/tile_servers.dart';
import 'package:skicentar_desktop/utils/utils.dart';

const satelliteColor = Colors.red;

final paint = Paint()
  ..style = PaintingStyle.fill
  ..strokeWidth = 2;

void _painter(Canvas canvas, List<Offset> points, Object? metadata) {
  const basecolor = satelliteColor;
  final shape = Path()..addPolygon(points, false);

  paint.color = basecolor;
  paint.style = PaintingStyle.stroke;
  canvas.drawPath(shape, paint);
}

class MarkersPage extends StatefulWidget {
  final List<LatLng> initialMarkers;
  final Function(List<LatLng>) onLocationsAdded;
  final int maxNumberOfMarkers;

  const MarkersPage(
      {Key? key,
      required this.onLocationsAdded,
      required this.initialMarkers,
      this.maxNumberOfMarkers = 10})
      : super(key: key);

  @override
  MarkersPageState createState() => MarkersPageState();
}

class MarkersPageState extends State<MarkersPage> {
  final controller = MapController(
    location: const LatLng(Angle.degree(43.85), Angle.degree(18.41)),
  );

  late List<LatLng> markers;
  @override
  void initState() {
    super.initState();
    markers = widget.initialMarkers;
    shape2.points.addAll(markers);
    if (widget.initialMarkers.isNotEmpty) {
      controller.center = LatLng(markers.first.latitude,markers.first.longitude);
    }
  }

  void _onDoubleTap(MapTransformer transformer, Offset position) {
    const delta = 0.5;
    final zoom = clamp(controller.zoom + delta, 2, 18);

    transformer.setZoomInPlace(zoom, position);
    setState(() {});
  }

  var shape2 = Shape(
    points: [],
    painter: _painter,
  );

  Offset? _dragStart;
  double _scaleStart = 1.0;

  void _onScaleStart(ScaleStartDetails details) {
    _dragStart = details.focalPoint;
    _scaleStart = 1.0;
  }

  void _onScaleUpdate(ScaleUpdateDetails details, MapTransformer transformer) {
    final scaleDiff = details.scale - _scaleStart;
    _scaleStart = details.scale;

    if (scaleDiff > 0) {
      controller.zoom += 0.02;
      setState(() {});
    } else if (scaleDiff < 0) {
      controller.zoom -= 0.02;
      setState(() {});
    } else {
      final now = details.focalPoint;
      final diff = now - _dragStart!;
      _dragStart = now;
      transformer.drag(diff.dx, diff.dy);
      setState(() {});
    }
  }

  void _onMarkerTap(LatLng marker) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Marker'),
        content: const Text('Do you want to delete this marker?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                markers.remove(marker);
                shape2.points.remove(marker);
              });
              widget.onLocationsAdded(markers);
              Navigator.of(context).pop();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Widget _buildMarkerWidget(Offset pos, Color color, LatLng marker,
      [IconData icon = Icons.location_on]) {
    return Positioned(
      left: pos.dx - 24,
      top: pos.dy - 24,
      width: 48,
      height: 48,
      child: GestureDetector(
        child: Icon(
          icon,
          color: color,
          size: 48,
        ),
        onTap: () {
          _onMarkerTap(marker);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MapLayout(
        controller: controller,
        builder: (context, transformer) {
          final markerPositions = markers.map(transformer.toOffset).toList();
          shape2.points.clear();
          shape2.points.addAll(markers);
          final markerWidgets = markerPositions.map((pos) {
            final index = markerPositions.indexOf(pos);
            // shape2.points.add(markers[index]);
            return _buildMarkerWidget(pos, Colors.red, markers[index]);
          }).toList();

          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onDoubleTapDown: (details) => _onDoubleTap(
              transformer,
              details.localPosition,
            ),
            onTapUp: (details) {
              if (markers.length == widget.maxNumberOfMarkers) {
                showCustomSnackBar(
                    context,
                    Icons.error_outline_rounded,
                    Colors.red,
                    'Maximum number of markers reached. Click on an existing marker to delete it.');
                return;
              }
              final location = transformer.toLatLng(details.localPosition);
              setState(() {
                markers.add(location);
                shape2.points.add(location);
              });
              widget.onLocationsAdded(markers);
            },
            onScaleStart: _onScaleStart,
            onScaleUpdate: (details) => _onScaleUpdate(details, transformer),
            child: Listener(
              behavior: HitTestBehavior.opaque,
              onPointerSignal: (event) {
                if (event is PointerScrollEvent) {
                  final delta = event.scrollDelta.dy / -1000.0;
                  final zoom = clamp(controller.zoom + delta, 2, 18);

                  transformer.setZoomInPlace(zoom, event.localPosition);
                  setState(() {});
                }
              },
              child: Stack(
                children: [
                  TileLayer(
                    builder: (context, x, y, z) {
                      final tilesInZoom = pow(2.0, z).floor();
                      while (x < 0) {
                        x += tilesInZoom;
                      }
                      while (y < 0) {
                        y += tilesInZoom;
                      }
                      x %= tilesInZoom;
                      y %= tilesInZoom;
                      return CachedNetworkImage(
                        imageUrl: google(z, x, y),
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  ...markerWidgets,
                  ShapeLayer(
                    transformer: transformer,
                    shapes: [shape2],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
