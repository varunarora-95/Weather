import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({
    required this.loading,
    required this.child,
    this.width,
    this.height,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final double? width;
  final double? height;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
      child: loading
          ? ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Shimmer.fromColors(
                baseColor: Colors.black.withOpacity(0.01),
                highlightColor: Colors.black.withOpacity(0.005),
                child: Container(
                  color: Colors.black.withOpacity(0.05),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: height ?? 0,
                      minWidth: width ?? 0,
                    ),
                    child: IgnorePointer(
                      child: Opacity(
                        opacity: 0,
                        child: child,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : child,
    );
  }
}
