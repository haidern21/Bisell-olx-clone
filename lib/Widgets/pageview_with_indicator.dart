import 'package:flutter/material.dart';

class PageViewWithIndicator extends StatefulWidget {
  final List<dynamic> imagesUrlList;
  final Function onViewClicked;

  const PageViewWithIndicator(
      { Key? key, required this.imagesUrlList, required this.onViewClicked})
      : super(key: key);

  @override
  _PageViewWithIndicatorState createState() => _PageViewWithIndicatorState();
}

class _PageViewWithIndicatorState extends State<PageViewWithIndicator> {
  double _currentPage = 0.0;
  final PageController _imagesPageController = PageController();
  List<Widget> _indicators = [];

  final Container _activeContainer = Container(
    width: 10,
    height: 10,
    margin: const EdgeInsets.symmetric(horizontal: 5),
    decoration: BoxDecoration(
      color: Colors.blue,
      border: Border.all(color: Colors.blue),
      borderRadius: BorderRadius.circular(10),
    ),
  );

  final Container _inactiveContainer = Container(
    width: 10,
    height: 10,
    margin: const EdgeInsets.symmetric(horizontal: 5),
    decoration: BoxDecoration(
      color: Colors.transparent,
      border: Border.all(color: Colors.blue),
      borderRadius: BorderRadius.circular(10),
    ),
  );

  @override
  initState() {
    _indicators = _buildIndicators(widget.imagesUrlList.length);
    _imagesPageController.addListener(() {
      setState(() {
        _currentPage = _imagesPageController.page!;
        for (int i = 0; i < _indicators.length; i++) {
          _indicators[i] = _inactiveContainer;
        }

        _indicators[_currentPage.round()] = _activeContainer;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: _imagesPageController,
          children: _buildImagesCarousel(widget.imagesUrlList),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: _indicators,
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildImagesCarousel(List<dynamic> imagesUrlList) {
    List<Widget> list = [];
    for (var imageUrl in imagesUrlList) {
      list.add(
        InkWell(
          onTap: () =>
              widget.onViewClicked(widget.imagesUrlList[_currentPage.round()]),
          child: InteractiveViewer(
            child: Image.network(
              imageUrl,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
        ),
      );
    }
    return list;
  }

  List<Widget> _buildIndicators(int total) {
    for (int i = 0; i < total; i++) {
      _indicators.insert(i, (i == 0) ? _activeContainer : _inactiveContainer);
    }
    return _indicators;
  }
}
