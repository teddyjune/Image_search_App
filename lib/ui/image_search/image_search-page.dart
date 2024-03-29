import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/photo.dart';
import 'package:image_search_app/ui/image_search/image_search_view_model.dart';
import 'package:provider/provider.dart';

import 'main_action.dart';

class ImageSearchApp extends StatefulWidget {
  const ImageSearchApp({Key? key}) : super(key: key);

  @override
  State<ImageSearchApp> createState() => _ImageSearchAppState();
}

class _ImageSearchAppState extends State<ImageSearchApp> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final viewModel = context.read<ImageSearchViewModel>();
      viewModel.eventStream.listen((event) {
        event.when(ShowSnackBar: (message) {
          final snackBar = SnackBar(
            content: Text(message),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }, ShowDialog: (String message) {
          showDialog<void>(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                    title: const Text('AlertDialog Title'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text(message),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Approve'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ]);
              });
        });
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ImageSearchViewModel>();
    final state = viewModel.state;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '이미지 검색',
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 56,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary, width: 2),
                  ),
                  suffixIcon: GestureDetector(
                      onTap: () {
                        viewModel
                            .onAction(MainAction.getImages(_controller.text));
                      },
                      child: const Icon(Icons.search)),
                  hintText: '검색어를 입력하세요',
                ),
              ),
            ),
          ),
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    children: state.photos.map((Photo image) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            image.previewURL,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
