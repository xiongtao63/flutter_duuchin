import 'package:flutter/material.dart';
import 'package:flutter_duuchin/components/immersive_app_bar/ImmersiveAppBar.dart';

// 全屏组件
class FullScreenPage extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;

  // 标题
  final double appBarHeight;
  final Widget appBarTitle;

  // 左侧图标
  final double leadingWidth;
  final Widget leadingIcon;
  final bool showLeading;
  final VoidCallback onLeadingTap;

  // 右侧图标
  final double actionWidth;
  final Widget actionIcon;
  final bool showAction;
  final VoidCallback onActionTap;

  const FullScreenPage({
    Key key,
    this.child,
    this.backgroundColor,
    this.leadingWidth,
    this.leadingIcon,
    this.showLeading = true,
    this.onLeadingTap,
    this.actionWidth,
    this.actionIcon,
    this.showAction = true,
    this.onActionTap,
    this.appBarHeight = kToolbarHeight,
    this.appBarTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: backgroundColor ?? Colors.transparent,
          child: child,
        ),
        ImmersiveAppBar(
          appBarHeight: appBarHeight,
          title: appBarTitle,
          leadingWidth: leadingWidth,
          leadingIcon: leadingIcon,
          showLeading: showLeading,
          actionWidth: actionWidth,
          actionIcon: actionIcon,
          showAction: showAction,
          onLeadingTap: onLeadingTap,
          onActionTap: onActionTap,
        ),
      ],
    );
  }
}
