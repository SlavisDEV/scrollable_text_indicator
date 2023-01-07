import 'package:flutter/material.dart';
import 'package:scrollable_text_indicator/size_reporting_widget.dart';

class ScrollableTextIndicator extends StatefulWidget {
  final Text text;
  final double indicatorThumbWidth;
  final double indicatorThumbHeight;
  final double indicatorBarWidth;
  final double indicatorSpacing;
  final Color indicatorThumbColor;
  final Color indicatorBarColor;

  const ScrollableTextIndicator({
    super.key,
    required this.text,
    this.indicatorThumbWidth = 6.0,
    this.indicatorThumbHeight = 20.0,
    this.indicatorBarWidth = 1.0,
    this.indicatorSpacing = 10.0,
    this.indicatorThumbColor = Colors.black,
    this.indicatorBarColor = Colors.black,
  });

  @override
  _ScrollableTextIndicatorState createState() =>
      _ScrollableTextIndicatorState();
}

class _ScrollableTextIndicatorState extends State<ScrollableTextIndicator> {
  final ScrollController _scrollController = ScrollController();

  double _scrollTopOffset = 0.0;
  double? _scrollBarHeight;
  double? _textHeight;
  double get _scrollMaxPosition => _scrollBarHeight == null
      ? 0
      : _scrollBarHeight! - widget.indicatorThumbHeight;
  double get _scrollRange => (_textHeight ?? 0.0) > (_scrollBarHeight ?? 0.0)
      ? _textHeight! - _scrollBarHeight!
      : 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    final double factor =
        _scrollMaxPosition / (_scrollRange > 0.0 ? _scrollRange : 1.0);
    if (!mounted) {
      return;
    }
    setState(() {
      _scrollTopOffset = _scrollController.offset * factor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: SizeReportingWidget(
                child: widget.text,
                onSizeChange: (size) {
                  if (!mounted) {
                    return;
                  }
                  setState(() {
                    _textHeight = size.height;
                  });
                },
              ),
            ),
          ),
          SizedBox(
            width: widget.indicatorSpacing,
          ),
          SizedBox(
            width: widget.indicatorThumbWidth,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                SizeReportingWidget(
                  child: Container(
                    width: widget.indicatorBarWidth,
                    color: widget.indicatorBarColor,
                  ),
                  onSizeChange: (size) {
                    if (!mounted) {
                      return;
                    }
                    setState(() {
                      _scrollBarHeight = size.height;
                    });
                  },
                ),
                Positioned(
                  top: _scrollTopOffset,
                  left: 0.0,
                  right: 0.0,
                  height: widget.indicatorThumbHeight,
                  child: Container(
                    width: widget.indicatorThumbWidth,
                    height: widget.indicatorThumbHeight,
                    color: widget.indicatorThumbColor,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }
}
