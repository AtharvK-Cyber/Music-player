import 'package:flutter/material.dart';
import '../constants/performance_config.dart';

// Optimized list view for better scrolling performance on OnePlus Nord
class OptimizedListView extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final ScrollController? controller;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const OptimizedListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.controller,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: physics ?? const BouncingScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      // Optimize for 90Hz display
      cacheExtent: 500, // Cache more items for smooth scrolling
      addAutomaticKeepAlives: true,
      addRepaintBoundaries: true,
      addSemanticIndexes: false, // Disable for better performance
    );
  }
}

// Optimized grid view for album/artist views
class OptimizedGridView extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final int crossAxisCount;
  final double childAspectRatio;
  final ScrollController? controller;
  final EdgeInsetsGeometry? padding;

  const OptimizedGridView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.crossAxisCount = 2,
    this.childAspectRatio = 1.0,
    this.controller,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: controller,
      padding: padding ?? const EdgeInsets.all(8),
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      cacheExtent: 500,
      addAutomaticKeepAlives: true,
      addRepaintBoundaries: true,
    );
  }
}

// Optimized animated widget wrapper
class OptimizedAnimatedWidget extends StatelessWidget {
  final Widget child;
  final Duration? duration;

  const OptimizedAnimatedWidget({
    super.key,
    required this.child,
    this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: duration ?? PerformanceConfig.animationDuration,
      curve: PerformanceConfig.animationCurve,
      child: child,
    );
  }
}

// Repaint boundary wrapper for expensive widgets
class OptimizedRepaintBoundary extends StatelessWidget {
  final Widget child;

  const OptimizedRepaintBoundary({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(child: child);
  }
}
