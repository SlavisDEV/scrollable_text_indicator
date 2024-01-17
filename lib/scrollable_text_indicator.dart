import 'package:flutter/material.dart';
import 'package:scrollable_text_indicator/size_reporting_widget.dart';

class ScrollableTextIndicator extends StatefulWidget {
  // The text to display
  final Text text;

  // The width of the thumb
  final double indicatorThumbWidth;

  // The height of the thumb
  final double indicatorThumbHeight;

  // The width of the vertical line
  final double indicatorBarWidth;

  // The spacing between the text and the scroll indicator
  final double indicatorSpacing;

  // The color of the thumb
  final Color indicatorThumbColor;

  // The color of the vertical line
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

  bool isScrollable = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setIsScrollable();
    });
  }

  _setIsScrollable() {
    if (_scrollController.hasClients) {
      setState(() {
        isScrollable = _scrollController.position.maxScrollExtent > 0;
      });
    }
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
                  _setIsScrollable();
                },
              ),
            ),
          ),
          if (isScrollable)
            SizedBox(
              width: widget.indicatorSpacing,
            ),
          if (isScrollable)
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
                      _setIsScrollable();
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
    _scrollController.dispose();
    super.dispose();
  }
}
