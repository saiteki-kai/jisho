import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jisho/cubit/word_cubit.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

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

  @override
  void initState() {
    _getStoragePermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<WordCubit>(context);
    bloc.getWords();

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

  Container _buildCustomAppBar() {
    final height = MediaQuery.of(context).viewPadding.top;

    return Container(
      padding: EdgeInsets.only(top: height),
      decoration: const BoxDecoration(
        color: Colors.red,
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 2.0,
            offset: Offset(0.0, 0.75),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildSearchBar(),
          _buildTabs(),
        ],
      ),
    );
  }

  Widget _buildWordList(context, WordsLoaded state) {
    var words = state.words;
    words = words.skip(777).take(20).toList();

    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
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
          child: Text(text!),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(thickness: 0.5, height: 0);
      },
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 4.0),
      child: TextField(
        // controller: queryController,
        autofocus: true,
        onChanged: (String value) {
          // widget.onChange(value);
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withOpacity(0.9),
          // isDense: true,
          contentPadding: const EdgeInsets.only(top: 12),
          hintText: "Search for words, kanji, names and sentences",
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8.0),
          ),
          // hintStyle: TextStyle(color: widget.mainTextColor.withAlpha(100),),
          prefixIcon: const Icon(Icons.search),
          suffixIcon: GestureDetector(
            child: Icon(
              Icons.clear,
              color: Colors.black.withOpacity(0),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return TabBar(
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
    );
  }
}