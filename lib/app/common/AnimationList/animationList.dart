import 'package:cloudmusic/app/services/enum/data.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AnimationListView extends StatelessWidget {
  final List<Widget> children;
  final bool? shrinkWrap;
  final double? verticalOffset;
  final double? horizontalOffset;
  final EdgeInsetsGeometry? padding;
  final EasyRefreshController? controller;
  final Function()? fn;

  const AnimationListView(
      {super.key,
      required this.children,
      this.verticalOffset,
      this.horizontalOffset,
      this.shrinkWrap = false,
      this.padding,
      this.controller,
      this.fn});

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: EasyRefresh.builder(
          controller: controller,
          onLoad: () async {
            DataStatus status = await fn!();
            print(status);
            switch (status) {
              case DataStatus.SUCCESS:
                controller!.finishLoad(IndicatorResult.success);
                break;
              case DataStatus.FAIL:
                controller!.finishLoad(IndicatorResult.fail);
                break;
              case DataStatus.NODATA:
                controller!.finishLoad(IndicatorResult.noMore);
                break;
            }
          },
          childBuilder: (context, physics) {
            return ListView(
                physics: physics,
                shrinkWrap: shrinkWrap!,
                padding: padding,
                children: AnimationConfiguration.toStaggeredList(
                    childAnimationBuilder: (widget) => SlideAnimation(
                          verticalOffset: verticalOffset,
                          horizontalOffset: horizontalOffset,
                          child: FadeInAnimation(
                            child: widget,
                          ),
                        ),
                    children: children));
          }),
    );
  }
}
