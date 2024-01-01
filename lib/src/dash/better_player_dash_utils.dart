import 'package:better_player/src/asms/better_player_asms_audio_track.dart';
import 'package:better_player/src/asms/better_player_asms_data_holder.dart';
import 'package:better_player/src/asms/better_player_asms_subtitle.dart';
import 'package:better_player/src/asms/better_player_asms_track.dart';
import 'package:better_player/src/core/better_player_utils.dart';
import 'package:better_player/src/hls/hls_parser/mime_types.dart';
import 'package:xml/xml.dart';

///DASH helper class
class BetterPlayerDashUtils {
  static Future<BetterPlayerAsmsDataHolder> parse(
      String data, String masterPlaylistUrl) async {
    List<BetterPlayerAsmsTrack> tracks = [];
    final List<BetterPlayerAsmsAudioTrack> audios = [];
    final List<BetterPlayerAsmsSubtitle> subtitles = [];
    try {
      int audiosCount = 0;
      final document = XmlDocument.parse(data);
      final adaptationSets = document.findAllElements('AdaptationSet');
      adaptationSets.forEach((node) {
        String? type = node.getAttribute('contentType');
        final mimeType = node.getAttribute('mimeType');

        if (mimeType != null && type == null) {
          if (MimeTypes.isVideo(mimeType)) {
            type = "video";
          } else if (MimeTypes.isAudio(mimeType)) {
            type = "audio";
          } else if (MimeTypes.isText(mimeType)) {
            type = "text";
          }
        }

        if (type != null) {
          if (type == "video") {
            tracks = tracks + parseVideo(node);
          } else if (type == "audio") {
            audios.add(parseAudio(node, audiosCount));
            audiosCount += 1;
          } else if (type == "text") {
            subtitles.add(parseSubtitle(masterPlaylistUrl, node));
          }
        }
      });
    } catch (exception) {
      BetterPlayerUtils.log("Exception on dash parse: $exception");
    }
    return BetterPlayerAsmsDataHolder(
        tracks: tracks, audios: audios, subtitles: subtitles);
  }

  static List<BetterPlayerAsmsTrack> parseVideo(XmlElement node) {
    final List<BetterPlayerAsmsTrack> tracks = [];

    final representations = node.findAllElements('Representation');

    representations.forEach((representation) {
      final String? id = representation.getAttribute('id');
      final int width = int.parse(representation.getAttribute('width') ?? '0');
      final int height =
          int.parse(representation.getAttribute('height') ?? '0');
      final int bitrate =
          int.parse(representation.getAttribute('bandwidth') ?? '0');
      final int frameRate =
          int.parse(representation.getAttribute('frameRate') ?? '0');
      final String? codecs = representation.getAttribute('codecs');
      final String? mimeType = MimeTypes.getMediaMimeType(codecs ?? '');
      tracks.add(BetterPlayerAsmsTrack(
          id, width, height, bitrate, frameRate, codecs, mimeType));
    });

    return tracks;
  }

  static BetterPlayerAsmsAudioTrack parseAudio(XmlElement node, int index) {
    final String segmentAlignmentStr =
        node.getAttribute('segmentAlignment') ?? '';
    String? label = node.getAttribute('label');
    final String? language = node.getAttribute('lang');
    final String? mimeType = node.getAttribute('mimeType');

    label ??= language;

    return BetterPlayerAsmsAudioTrack(
        id: index,
        segmentAlignment: segmentAlignmentStr.toLowerCase() == 'true',
        label: label,
        language: language,
        mimeType: mimeType);
  }

  static BetterPlayerAsmsSubtitle parseSubtitle(
      String masterPlaylistUrl, XmlElement node) {
    final String segmentAlignmentStr =
        node.getAttribute('segmentAlignment') ?? '';
    String? name = node.getAttribute('label');
    final String? language = node.getAttribute('lang');
    final String? mimeType = node.getAttribute('mimeType');

    final representationElement = node.getElement('Representation');
    final baseUrlElement = representationElement?.getElement('BaseURL');
    String? url = baseUrlElement?.innerText;

    if (url?.contains("http") == false) {
      final Uri masterPlaylistUri = Uri.parse(masterPlaylistUrl);
      final pathSegments = <String>[...masterPlaylistUri.pathSegments];
      print('pathSegments: ${pathSegments}');
      pathSegments[pathSegments.length - 1] = url!;
      final urlUri = Uri(
              scheme: masterPlaylistUri.scheme,
              host: masterPlaylistUri.host,
              port: masterPlaylistUri.port,
              pathSegments: pathSegments)
          .toString();

      url = Uri.decodeFull(urlUri);
    }

    if (url != null && url.startsWith('//')) {
      url = 'https:$url';
    }

    name ??= language;

    return BetterPlayerAsmsSubtitle(
        name: name,
        language: language,
        mimeType: mimeType,
        segmentAlignment: segmentAlignmentStr.toLowerCase() == 'true',
        url: url,
        realUrls: [url ?? '']);
  }
}
