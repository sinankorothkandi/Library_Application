
  import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 236, 235, 235),
      highlightColor: const Color.fromARGB(255, 255, 255, 255),
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              border:
                  Border.all(color: Colors.black.withOpacity(0.1), width: 0.5),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Color getAvatarColor(String name) {
    final colors = [
      Colors.red[100]!,
      Colors.blue[100]!,
      Colors.green[100]!,
      Colors.yellow[100]!,
      Colors.purple[100]!,
      Colors.orange[100]!,
    ];
    return colors[name.hashCode % colors.length];
  }