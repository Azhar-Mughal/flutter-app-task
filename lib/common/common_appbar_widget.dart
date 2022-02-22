import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String mTitle;
  final bool mShowLeading;

  const CommonAppBarWidget({
    Key? key,
    required this.mTitle,
    required this.mShowLeading,
  }) : super(key: key);

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      elevation: 0,
      leading: mShowLeading
          ? IconButton(
              icon: const Icon(
                CupertinoIcons.left_chevron,
                size: 20,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : const SizedBox(),
      iconTheme: IconThemeData(color: IconTheme.of(context).color),
      title: Text(mTitle),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
