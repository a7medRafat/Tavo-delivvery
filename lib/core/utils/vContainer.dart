import 'package:flutter/cupertino.dart';

class AppContainer extends StatelessWidget {
  const AppContainer({
    super.key,
    this.color,
    this.function,
    this.height,
    this.width,
    this.child,
    this.borderRadius,
    this.padding,
    this.margin,
    this.border,
    this.shadow,
  });

  final Color? color;
  final double? height;
  final double? width;
  final Widget? child;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxBorder? border;
  final Function()? function;
  final List<BoxShadow>? shadow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          boxShadow: shadow,
          borderRadius: borderRadius,
          border: border,
          color: color,
        ),
        height: height,
        width: width,
        child: child,
      ),
    );
  }
}
