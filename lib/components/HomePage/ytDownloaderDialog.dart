import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/dialogPadding.dart';
import 'package:musicalization/Widgets/standardSpace.dart';
import 'package:musicalization/logic/youtubeDownloader.dart';
import 'package:musicalization/utils/showSuccessDialog.dart';
import 'package:musicalization/utils/showWarnDialog.dart';

class YtDownloaderDialog extends StatefulWidget {
  final Function() onDownloadFinished;

  const YtDownloaderDialog({super.key, required this.onDownloadFinished});

  @override
  State<StatefulWidget> createState() => YtDownloaderDialogState();
}

class YtDownloaderDialogState extends State<YtDownloaderDialog> {
  final YtDownloader _downloader = YtDownloader();
  bool _isDownloading = false;
  String? _selectedUrl;
  String? _urlError = "";

  void _startDownload(String url) async {
    setState(() {
      _isDownloading = true;
      _selectedUrl = url;
    });

    try {
      final result = await _downloader.downloadMp3FromYt(url);
      if(result.isSucceeded){
        showSuccessDialog(
          "ダウンロードに成功しました",
          onOkTapped: () {
            widget.onDownloadFinished();
            print("ok");
          },
        );
      }else{
        showWarnDialog(result.errorMsg);
      }
      
    } catch (e) {
      showWarnDialog("ダウンロードに失敗しました。 -> ${e.toString()}");
    } finally {
      if(!mounted) return;
      setState(() {
        _isDownloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DialogPadding(
        child: Card(
          elevation: 8,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildUrlInputField(),
                buildBtns(),
                if (_isDownloading) buildProgressIndicator(),
                const StandardSpace()
              ],
            ),
          ),
        ),
      ),
    );
  }

Widget buildUrlInputField() {
  final RegExp youtubeRegex = RegExp(
    r'^(?:https?:\/\/)?'
    r'(?:www\.)?'
    r'(?:youtube\.com|youtu\.be)'
    r'\/(?:watch\?v=)?'
    r'([\w-]+)'
    r'(?:(?:\?|\&)[\w-]+=[\w-]+)*$'
  );

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: 'YouTube URL',
        suffixIcon: const Icon(Icons.link),
        errorText: _urlError,
      ),
      onChanged: (value) {
        setState(() {
          if (youtubeRegex.hasMatch(value)) {
            _selectedUrl = value;
            _urlError = null;
          } else {
            _selectedUrl = null;
            _urlError = '無効なYouTube URLです\n例 : ) https://www.youtube.com/watch?v=eXamPleUtUBEUrL';
          }
        });
      },
    ),
  );
}

  Widget buildBtns() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            child: const Text("戻る"),
            onPressed: () => Navigator.pop(context),
          ),
          const StandardSpace(),
          ElevatedButton(
            onPressed: _selectedUrl != null && !_isDownloading
                ? () => _startDownload(_selectedUrl!)
                : null,
            child: const Text("ダウンロード"),
          ),
        ],
      ),
    );
  }

  Widget buildProgressIndicator() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: CircularProgressIndicator(),
    );
  }
}
