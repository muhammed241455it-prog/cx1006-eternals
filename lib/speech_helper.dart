import 'package:flutter_tts/flutter_tts.dart';

class SpeechHelper {
  static final FlutterTts _tts = FlutterTts();

  static bool _initialized = false;

  static Future<void> _initialize() async {
    if (_initialized) {
      return;
    }

    await _tts.setLanguage('en-IN');
    await _tts.setSpeechRate(0.45);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);

    await _tts.awaitSpeakCompletion(true);

    _initialized = true;
  }

  static Future<void> speak(String text) async {
    try {
      await _initialize();

      // Stop anything that is currently being spoken.
      await _tts.stop();

      // Small delay prevents two announcements from overlapping.
      await Future.delayed(
        const Duration(milliseconds: 100),
      );

      await _tts.speak(text);
    } catch (e) {
      print('TTS error: $e');
    }
  }

  static Future<void> stop() async {
    try {
      await _tts.stop();
    } catch (e) {
      print('TTS stop error: $e');
    }
  }
}