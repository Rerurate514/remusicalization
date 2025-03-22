import 'dart:io';

import 'package:musicalization/utils/Result.dart';
import 'package:musicalization/utils/fetchNowOSDownloadsDir.dart';
import 'package:musicalization/utils/showWarnDialog.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YtDownloader {
  final YoutubeExplode _yt = YoutubeExplode();

  Future<Result> downloadMp3FromYt(String url) async {
    final videoId = VideoId.parseVideoId(url.trim());

    if(videoId == null) {
      return Result(
        isSucceeded: false,
        errorMsg: 'YouTube URLより動画を見つけることができませんでした。'
      );
    }

    final manifest = await _yt.videos.streamsClient.getManifest(videoId);
    final videoTitle = (await _yt.videos.get(videoId)).title;

    final audio = manifest.audioOnly.first;
    final audioStream = _yt.videos.streamsClient.get(audio);

    final directory = await fetchNowOSDownloadsDirectory();
    final filePath = '${directory.path}/${videoTitle.hashCode}.mp3';

    final file = File(filePath);
    final fileStream = file.openWrite();

    try {
      await audioStream.pipe(fileStream);
    } catch (e) {
      showWarnDialog("ダウンロードに失敗しました。 -> ${e.toString()}");
    } finally {
      await fileStream.flush();
      await fileStream.close();
    }

    return Result(isSucceeded: true);
  }
}
