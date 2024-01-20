import 'package:flutter/material.dart';

class KeepAliveWidget extends StatefulWidget {
  const KeepAliveWidget({
    super.key,
    this.keepAlive = true,
    required this.child,
  });

  final bool keepAlive;
  final Widget child;

  @override
  State<KeepAliveWidget> createState() => _KeepAliveWidgetState();
}

class _KeepAliveWidgetState extends State<KeepAliveWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => widget.keepAlive;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
