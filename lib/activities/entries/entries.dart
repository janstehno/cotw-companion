import 'package:collection/collection.dart';
import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/search_controller.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/utils.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/model/exportable/exportable.dart';
import 'package:cotwcompanion/widgets/app/bar_app.dart';
import 'package:cotwcompanion/widgets/app/bar_scroll.dart';
import 'package:cotwcompanion/widgets/app/bar_search.dart';
import 'package:cotwcompanion/widgets/app/margin.dart';
import 'package:cotwcompanion/widgets/bar/bar_menu.dart';
import 'package:cotwcompanion/widgets/bar/bar_menu_item.dart';
import 'package:cotwcompanion/widgets/button/button_icon.dart';
import 'package:cotwcompanion/widgets/fullscreen/confirmation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

abstract class ActivityEntries extends StatefulWidget {
  final String _title;

  const ActivityEntries(
    String title, {
    super.key,
  }) : _title = title;

  String get title => _title;
}

abstract class ActivityEntriesState<I extends Exportable> extends State<ActivityEntries> {
  final TextEditingControllerWorkaround _controller = TextEditingControllerWorkaround();
  final double menuHeight = Values.menuBar;

  late ScaffoldMessengerState _scaffoldMessengerState;

  bool _yesNoOpened = false;
  bool fileOptionsOpened = false;

  List<I> _initialItems = [];

  List<I> _filteredItems = [];

  List<I> get items => _initialItems;

  List<I> get filtered => _filteredItems;

  TextEditingControllerWorkaround get controller => _controller;

  @override
  void initState() {
    controller.addListener(() => filter());
    super.initState();
  }

  @override
  void dispose() {
    _scaffoldMessengerState.clearSnackBars();
    super.dispose();
  }

  void focus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  List<I> initialItems();

  List<I> filteredItems();

  void _initialize() {
    _initialItems = initialItems();
  }

  void filter() {
    setState(() {
      _filteredItems = filteredItems();
    });
  }

  void removeAll();

  void showFileOptions() {
    setState(() {
      focus();
      fileOptionsOpened = !fileOptionsOpened;
    });
  }

  fileLoaded() async => false;

  void _loadFile() async {
    final bool loaded = await fileLoaded();
    _buildLoaded(loaded);
  }

  void _buildLoaded(bool loaded) {
    if (loaded) {
      Utils.buildSnackBarMessage(
        tr("FILE_IMPORTED"),
        Process.success,
        context,
      );
    } else {
      Utils.buildSnackBarMessage(
        tr("FILE_NOT_IMPORTED"),
        Process.error,
        context,
      );
    }
  }

  fileSaved() async => false;

  void _saveFile() async {
    final bool saved = await fileSaved();
    _buildSaved(saved);
  }

  void _buildSaved(bool saved) {
    if (saved) {
      Utils.buildSnackBarMessage(
        tr("FILE_EXPORTED"),
        Process.success,
        context,
      );
    } else {
      Utils.buildSnackBarMessage(
        tr("FILE_NOT_EXPORTED"),
        Process.error,
        context,
      );
    }
  }

  WidgetMenuBarItem buildMenuAdd(Widget widget) {
    return _buildMenuAdd(widget);
  }

  WidgetMenuBarItem _buildMenuAdd(Widget widget) {
    return WidgetMenuBarItem(
      barButton: WidgetButtonIcon(
        Assets.graphics.icons.plus,
        color: Interface.alwaysDark,
        background: Interface.primary,
        onTap: () {
          focus();
          Navigator.push(context, MaterialPageRoute(builder: (e) => widget));
        },
      ),
    );
  }

  WidgetMenuBarItem buildMenuDelete() {
    return _buildMenuDelete();
  }

  WidgetMenuBarItem _buildMenuDelete() {
    return WidgetMenuBarItem(
      barButton: WidgetButtonIcon(
        Assets.graphics.icons.removeBin,
        color: Interface.alwaysDark,
        background: Interface.red,
        onTap: () {
          setState(() {
            focus();
            _yesNoOpened = true;
          });
        },
      ),
    );
  }

  WidgetMenuBarItem buildMenuHelp(Widget widget) {
    return _buildMenuHelp(widget);
  }

  WidgetMenuBarItem _buildMenuHelp(Widget widget) {
    return WidgetMenuBarItem(
      barButton: WidgetButtonIcon(
        Assets.graphics.icons.about,
        color: Interface.light,
        background: Interface.dark,
        onTap: () {
          setState(() {
            focus();
            Navigator.push(context, MaterialPageRoute(builder: (e) => widget));
          });
        },
      ),
    );
  }

  Widget _buildFileOptions() {
    return WidgetButtonIcon(
      Assets.graphics.icons.file,
      color: Interface.light,
      background: Interface.dark,
      onTap: () {
        setState(() {
          focus();
          showFileOptions();
        });
      },
    );
  }

  Widget _buildFileOptionsExport() {
    return WidgetButtonIcon(
      Assets.graphics.icons.export,
      color: Interface.light,
      background: Interface.dark,
      onTap: () async {
        _saveFile();
        setState(() {
          focus();
          fileOptionsOpened = !fileOptionsOpened;
        });
      },
    );
  }

  Widget _buildFileOptionsImport() {
    return WidgetButtonIcon(
      Assets.graphics.icons.import,
      color: Interface.light,
      background: Interface.dark,
      onTap: () async {
        _loadFile();
        setState(() {
          focus();
          fileOptionsOpened = !fileOptionsOpened;
        });
      },
    );
  }

  Widget _buildFileOptionsDelete() {
    return WidgetButtonIcon(
      Assets.graphics.icons.removeBin,
      color: Interface.alwaysDark,
      background: Interface.red,
      onTap: () {
        setState(() {
          focus();
          showFileOptions();
          _yesNoOpened = true;
        });
      },
    );
  }

  WidgetMenuBarItem buildMenuFileOptions() {
    return _buildMenuFileOptions();
  }

  WidgetMenuBarItem _buildMenuFileOptions() {
    return WidgetMenuBarItem(
      barButton: _buildFileOptions(),
      subButtons: [
        _buildFileOptionsExport(),
        _buildFileOptionsImport(),
        _buildFileOptionsDelete(),
      ],
      height: menuHeight,
      menuOpened: fileOptionsOpened,
    );
  }

  List<WidgetMenuBarItem> listMenuBarItems();

  WidgetMenuBar _buildMenu() {
    return WidgetMenuBar(items: listMenuBarItems());
  }

  Widget _buildConfirmation() {
    if (_yesNoOpened) {
      return WidgetConfirmation(
        text: tr("REMOVE_ALL_ITEMS"),
        onConfirm: () {
          setState(() {
            focus();
            removeAll();
            _yesNoOpened = false;
          });
        },
        onCancel: () {
          setState(() {
            focus();
            _yesNoOpened = false;
          });
        },
      );
    }
    return const SizedBox.shrink();
  }

  List<Widget> listFilters() => [];

  void buildFilter() {}

  WidgetAppBar buildAppBar() {
    return WidgetAppBar(
      tr(widget.title),
      context: context,
    );
  }

  WidgetSearchBar? buildSearchBar() => null;

  Widget buildEntry(int i, dynamic item);

  Widget _buildMenuBar() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          height: menuHeight,
          width: MediaQuery.of(context).size.width,
          color: Interface.search,
        ),
        _buildMenu(),
      ],
    );
  }

  List<Widget> listItems() {
    if (_initialItems.isEmpty) _initialize();
    if (_filteredItems.isEmpty) filter();
    return _filteredItems.mapIndexed((i, item) => buildEntry(i, item)).toList();
  }

  Widget buildItems(List<Widget> widgets) {
    return ListView.builder(
      itemCount: 2 + _filteredItems.length,
      itemBuilder: (context, i) {
        if (i == 0) return buildAppBar();
        if (i == 1) return buildSearchBar() ?? const SizedBox.shrink();
        return widgets.elementAt(i - 2);
      },
    );
  }

  Widget _buildBody() {
    List<Widget> widgets = listItems();
    return Stack(
      children: [
        WidgetMargin.bottom(
          Values.menuBar,
          background: Interface.body,
          alignment: Alignment.topCenter,
          child: WidgetScrollBar(
            child: buildItems(widgets),
          ),
        ),
        Positioned(
          left: 0,
          bottom: 0,
          child: _buildMenuBar(),
        ),
        _buildConfirmation(),
      ],
    );
  }

  Widget _buildWidgets() {
    _scaffoldMessengerState = ScaffoldMessenger.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: _buildBody(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
