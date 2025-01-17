import 'package:flutter/material.dart';

class Div extends StatelessWidget {
  final Widget child;

  /// Small screen `< 600.0`
  ///
  /// input range [0 -12]
  ///
  /// `0` ~ 0.0 width / gone
  ///i
  /// `12` ~ full width
  ///
  /// default `12`
  final int colS;

  /// Medium screen `600.0 to 990.0`
  ///
  /// input range [0 -12]
  ///
  /// `0` ~ 0.0 width / gone
  ///
  /// `12` ~ full width
  ///
  /// `null` / `default` ~ takes [ColS] value
  final int? colM;

  /// Large screen `990.0 to 1380.0`
  ///
  /// input range [0 -12]
  ///
  /// `0` ~ 0.0 width / gone
  ///
  /// `12` ~ full width
  ///
  /// `null` / `default` ~  takes [ColM] value
  final int? colL;

  /// Very Large screen `> 1380`
  ///
  /// input range [0 -12]
  ///
  /// `0` ~ 0.0 width / gone
  ///
  /// `12` ~ full width
  ///
  /// `null` / `default` ~  takes [ColL] value
  final int? colXL;

  /// input range [0 -12]
  ///
  /// default `0`
  final int offsetS;

  /// input range [0 -12]
  ///
  /// default `0`
  final int offsetM;

  /// input range [0 -12]
  ///
  /// default `0`
  final int offsetL;

  /// input range [0 -12]
  ///
  /// default `0`
  final int offsetXL;

  final double _widthMobile = 600.0;

  final double _widthTab = 990;

  final double _widthLargeTab = 1380;

  Div({
    this.colS = 12,
    this.colM,
    this.colL,
    this.colXL,
    required this.child,
    this.offsetS = 0,
    this.offsetM = 0,
    this.offsetL = 0,
    this.offsetXL = 0,
  })  : assert(colS >= 0 && colS <= 12),
        assert(colM == null || (colM >= 0 && colM <= 12)),
        assert(colL == null || (colL >= 0 && colL <= 12)),
        assert(colXL == null || (colXL >= 0 && colXL <= 12)),
        assert(offsetS >= 0 && offsetS <= 11),
        assert(offsetM >= 0 && offsetM <= 11),
        assert(offsetL >= 0 && offsetL <= 11),
        assert(offsetXL >= 0 && offsetXL <= 11),
        assert((colS + offsetS <= 12),
            "sum of the colS and the respective offsetS should be less than or equal to 12"),
        assert(colM == null || (colM + offsetM <= 12),
            "sum of the colM and the respective offsetM should be less than or equal to 12"),
        assert(colL == null || (colL + offsetL <= 12),
            "sum of the colL and the respective offsetL should be less than or equal to 12"),
        assert(colXL == null || (colXL + offsetXL <= 12),
            "sum of the colXL and the respective offsetXL should be less than or equal to 12");

  @override
  Widget build(BuildContext context) {
    return _createDivWidget(child, context);
  }

  Widget _createDivWidget(Widget child, BuildContext context) {
    int _col = 0;
    int _offsetWithCol = 0;
    final double width = MediaQuery.of(context).size.width;
    if (width < _widthMobile) {
      _col = colS;
      _offsetWithCol = (offsetS + _col >= 12) ? 12 : offsetS + _col;
    } else if (width < _widthTab) {
      _col = colM ?? colS;
      _offsetWithCol = (offsetM + _col >= 12) ? 12 : offsetM + _col;
    } else if (width < _widthLargeTab) {
      _col = colL ?? colM ?? colS;
      _offsetWithCol = (offsetL + _col >= 12) ? 12 : offsetL + _col;
    } else {
      _col = colXL ?? colL ?? colM ?? colS;
      _offsetWithCol = (offsetXL + _col >= 12) ? 12 : offsetXL + _col;
    }
    return LayoutBuilder(builder: (ctx, box) {
      final double width = (box.maxWidth / 12) * _offsetWithCol;
      return width == 0
          ? SizedBox.shrink()
          : SizedBox(
              width: width,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(width: (box.maxWidth / 12) * _col, child: child),
                ],
              ),
            );
    });
  }
}
