import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'package:jisho/cubit/word_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool permissionGranted = false;

  Future _getStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      setState(() {
        permissionGranted = true;
      });
    } else if (await Permission.storage.request().isPermanentlyDenied) {
      await openAppSettings();
    } else if (await Permission.storage.request().isDenied) {
      setState(() {
        permissionGranted = false;
      });
    }
  }

  final _controller = StreamController<String>();

  @override
  void initState() {
    _getStoragePermission();
    final bloc = BlocProvider.of<WordCubit>(context);
    _controller.stream
        .debounce((_) => TimerStream(true, Duration(milliseconds: 300)))
        .listen((value) => bloc.getWords(value));
    super.initState();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        appBar: null,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildCustomAppBar(),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  BlocBuilder<WordCubit, WordsState>(builder: (context, state) {
                    if (state is WordsInitial) {
                      return const Center(
                        child: Text("Init"),
                      );
                    } else if (state is WordsLoading) {
                      return const Center(
                        child: Text("Loading..."),
                      );
                    } else if (state is WordsLoaded) {
                      return _buildWordList(context, state);
                    }
                    return const Text("Unknown");
                  }),
                  const Center(child: Text("Kanji")),
                  const Center(child: Text("Names")),
                  const Center(child: Text("Sentences")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWordList(context, WordsLoaded state) {
    var words = state.words;

    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: words.length,
      itemBuilder: (context, index) {
        var kanji = words.elementAt(index).kanji;
        String? text;

        if (kanji.isNotEmpty) {
          text = kanji[0].text;
        } else {
          text = words.elementAt(index).reading[0].text;
        }

        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(text),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(thickness: 0.5, height: 0);
      },
    );
  }

  Widget _buildCustomAppBar() {
    final height = MediaQuery.of(context).viewPadding.top;

    return Material(
      color: Colors.red,
      elevation: 2,
      child: Container(
        padding: EdgeInsets.only(top: height + 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMenu(),
            _buildTabs(),
          ],
        ),
      ),
    );
  }

  Widget _buildMenu() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(child: _buildSearchBar()),
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            tooltip: "Menu",
            onPressed: (() => print("")),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFe9eaec),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 5, // 25
              offset: const Offset(0, 2), // 0, 10
            )
          ],
        ),
        child: TextField(
          onChanged: _controller.sink.add,
          cursorColor: const Color(0xFF000000),
          cursorRadius: const Radius.circular(8.0),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(top: 12.0),
            isCollapsed: true,
            isDense: true,
            hintText: "Search",
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
              // color: const Color(0xFF000000).withOpacity(0.5),
            ),
            suffixIcon: Icon(Icons.close),
          ),
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Theme(
      // remove highlight effect from tabs
      data: ThemeData(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      child: Container(
        child: TabBar(
          tabs: const [
            Tab(text: "Words"),
            Tab(text: "Kanji"),
            Tab(text: "Names"),
            Tab(text: "Sentences"),
          ],
          isScrollable: true,
          labelStyle: const TextStyle(fontWeight: FontWeight.w400),
          labelPadding: const EdgeInsets.symmetric(horizontal: 24.0),
          labelColor: Colors.white,
          indicator: MaterialIndicator(
            height: 3,
            topLeftRadius: 4,
            topRightRadius: 4,
            horizontalPadding: 16,
            tabPosition: TabPosition.bottom,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
