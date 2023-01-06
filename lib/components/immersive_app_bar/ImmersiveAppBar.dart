import 'package:flutter/material.dart';

// 沉浸式导航栏
class ImmersiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double appBarHeight;

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

  // 标题
  final Widget title;

  const ImmersiveAppBar({
    Key key,
    this.appBarHeight = kToolbarHeight,
    this.leadingWidth,
    this.leadingIcon,
    this.showLeading = true,
    this.onLeadingTap,
    this.actionWidth,
    this.actionIcon,
    this.showAction = true,
    this.onActionTap,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _leading = SizedBox.shrink();
    Widget _action = SizedBox.shrink();
    Widget _title = SizedBox.shrink();

    // 左侧按钮
    if (leadingIcon == null && showLeading) {
      _leading = ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: leadingWidth ?? appBarHeight,
          maxWidth: leadingWidth ?? appBarHeight,
        ),
        child: BackButton(onPressed: onLeadingTap),
      );
    }
    if (leadingIcon != null) {
      _leading = ConstrainedBox(
        constraints: BoxConstraints.tightFor(
          width: leadingWidth ?? appBarHeight,
          height: leadingWidth ?? appBarHeight,
        ),
        child: IconButton(
          icon: leadingIcon,
          onPressed: onLeadingTap,
        ),
      );
    }

    // 右侧按钮
    if (actionIcon != null && showAction) {
      _action = ConstrainedBox(
        constraints: BoxConstraints.tightFor(
          width: actionWidth ?? appBarHeight,
          height: actionWidth ?? appBarHeight,
        ),
        child: IconButton(
          icon: actionIcon,
          onPressed: onActionTap,
        ),
      );
    }

    // 标题
    if (title != null) {
      _title = Expanded(
        child: Container(
          child: title,
        ),
      );
    }

    return SafeArea(
      child: PreferredSize(
        preferredSize: Size.fromHeight(appBarHeight),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _leading,
            _title,
            _action,
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}
