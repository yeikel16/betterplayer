import 'package:better_player/better_player.dart';
import 'package:better_player/src/dash/better_player_dash_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late final BetterPlayerAsmsDataHolder betterPlayerAsmsDataHolder;

  setUpAll(() async {
    betterPlayerAsmsDataHolder = await BetterPlayerDashUtils.parse(
      mainfest,
      'https://myurl.com/videos/53e4ce8377664d859becd1db87e5b97e/manifest.mpd',
    );
  });
  testWidgets('get all parameters', (tester) async {
    expect(betterPlayerAsmsDataHolder.audios?.length, equals(2));
    expect(betterPlayerAsmsDataHolder.subtitles?.length, equals(2));
    expect(betterPlayerAsmsDataHolder.tracks?.length, equals(5));
  });

  testWidgets('check subtitle values', (tester) async {
    expect(
      betterPlayerAsmsDataHolder.subtitles?.first,
      isA<BetterPlayerAsmsSubtitle>()
          .having((sub) => sub.name, 'name', equals('en'))
          .having((sub) => sub.language, 'language', equals('en'))
          .having(
            (sub) => sub.url,
            'url',
            'https://myurl.com/videos/53e4ce8377664d859becd1db87e5b97e/text/text-eng-2.vtt',
          ),
    );
  });
}

const mainfest = '''
<?xml version="1.0" encoding="UTF-8"?>
<!--Generated with https://github.com/google/shaka-packager version v2.6.1-634af65-release-->
<MPD xmlns="urn:mpeg:dash:schema:mpd:2011" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="urn:mpeg:dash:schema:mpd:2011 DASH-MPD.xsd" profiles="urn:mpeg:dash:profile:isoff-on-demand:2011" minBufferTime="PT2S" type="static" mediaPresentationDuration="PT3525.125S">
    <Period id="0">
        <AdaptationSet id="9" contentType="text" lang="en" subsegmentAlignment="true">
            <Role schemeIdUri="urn:mpeg:dash:role:2011" value="subtitle"/>
            <Representation id="9" bandwidth="855" codecs="wvtt" mimeType="application/mp4">
                <BaseURL>text/text-eng-2.mp4</BaseURL>
                <SegmentBase indexRange="731-7386" timescale="1000">
                    <Initialization range="0-730"/>
                </SegmentBase>
            </Representation>
        </AdaptationSet>
        <AdaptationSet id="22" contentType="video" maxWidth="1720" maxHeight="720" frameRate="12288/512" subsegmentAlignment="true" par="43:18">
            <Representation id="22" bandwidth="307294" codecs="avc1.64001e" mimeType="video/mp4" sar="2880:2881" width="860" height="360">
                <BaseURL>video/h264_360p.mp4</BaseURL>
                <SegmentBase indexRange="894-7981" timescale="12288">
                    <Initialization range="0-893"/>
                </SegmentBase>
            </Representation>
            <Representation id="34" bandwidth="211843" codecs="avc1.640015" mimeType="video/mp4" sar="662:663" width="574" height="240">
                <BaseURL>video/h264_240p.mp4</BaseURL>
                <SegmentBase indexRange="892-7979" timescale="12288">
                    <Initialization range="0-891"/>
                </SegmentBase>
            </Representation>
            <Representation id="35" bandwidth="109063" codecs="avc1.64000c" mimeType="video/mp4" sar="2880:2881" width="344" height="144">
                <BaseURL>video/h264_144p.mp4</BaseURL>
                <SegmentBase indexRange="892-7979" timescale="12288">
                    <Initialization range="0-891"/>
                </SegmentBase>
            </Representation>
            <Representation id="42" bandwidth="515170" codecs="avc1.64001f" mimeType="video/mp4" sar="4096:4095" width="1146" height="480">
                <BaseURL>video/h264_480p.mp4</BaseURL>
                <SegmentBase indexRange="894-7981" timescale="12288">
                    <Initialization range="0-893"/>
                </SegmentBase>
            </Representation>
            <Representation id="44" bandwidth="1363300" codecs="avc1.640020" mimeType="video/mp4" sar="2880:2881" width="1720" height="720">
                <BaseURL>video/h264_720p.mp4</BaseURL>
                <SegmentBase indexRange="893-7980" timescale="12288">
                    <Initialization range="0-892"/>
                </SegmentBase>
            </Representation>
        </AdaptationSet>
        <AdaptationSet id="1" contentType="audio" lang="en" subsegmentAlignment="true">
            <Representation id="29" bandwidth="142784" codecs="mp4a.40.2" mimeType="audio/mp4" audioSamplingRate="44100">
                <AudioChannelConfiguration schemeIdUri="urn:mpeg:dash:23003:3:audio_channel_configuration:2011" value="2"/>
                <BaseURL>audio/audio-1-eng.mp4</BaseURL>
                <SegmentBase indexRange="826-7913" timescale="44100">
                    <Initialization range="0-825"/>
                </SegmentBase>
            </Representation>
        </AdaptationSet>
        <AdaptationSet id="2" contentType="audio" lang="es">
            <Role schemeIdUri="urn:mpeg:dash:role:2011" value="main"/>
            <Representation id="1" bandwidth="300000" codecs="mp4a.40.2" mimeType="audio/mp4" audioSamplingRate="44100">
                <AudioChannelConfiguration schemeIdUri="urn:mpeg:dash:23003:3:audio_channel_configuration:2011" value="2"/>
                <BaseURL>audio/audio-1-spa-128k.mp4</BaseURL>
                <SegmentBase indexRange="826-6557" timescale="44100">
                    <Initialization range="0-825"/>
                </SegmentBase>
            </Representation>
        </AdaptationSet>
        <AdaptationSet id="2" contentType="text" lang="es" subsegmentAlignment="true">
            <Role schemeIdUri="urn:mpeg:dash:role:2011" value="subtitle"/>
            <Representation id="31" bandwidth="648" codecs="wvtt" mimeType="application/mp4">
                <BaseURL>text/text-spa-11.mp4</BaseURL>
                <SegmentBase indexRange="731-7398" timescale="1000">
                    <Initialization range="0-730"/>
                </SegmentBase>
            </Representation>
            <Representation id="41" bandwidth="690" codecs="wvtt" mimeType="application/mp4">
                <BaseURL>text/text-external-spa.mp4</BaseURL>
                <SegmentBase indexRange="731-7146" timescale="1000">
                    <Initialization range="0-730"/>
                </SegmentBase>
            </Representation>
            <Representation id="46" bandwidth="648" codecs="wvtt" mimeType="application/mp4">
                <BaseURL>text/text-spa-27.mp4</BaseURL>
                <SegmentBase indexRange="731-7398" timescale="1000">
                    <Initialization range="0-730"/>
                </SegmentBase>
            </Representation>
        </AdaptationSet>
        
    </Period>
</MPD>''';
