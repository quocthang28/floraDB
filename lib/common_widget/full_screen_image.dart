import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class FullScreenImage extends StatelessWidget {
  FullScreenImage({required this.imageUrl, required this.tag});

  final String imageUrl;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: tag,
            child: PinchZoom(
              image: Image.network(imageUrl),
              zoomedBackgroundColor: Colors.black.withOpacity(0.5),
              resetDuration: const Duration(milliseconds: 100),
              maxScale: 2.5,
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

// CachedNetworkImage(
// width: MediaQuery.of(context).size.width,
// fit: BoxFit.contain,
// imageUrl: imageUrl,
// )
