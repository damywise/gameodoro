import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gameodoro/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'tune.g.dart';

part 'tune.freezed.dart';

const tunes = <String, String>{
  '': 'Disabled',
  'sound001_positive_notification.mp3': 'Positive Notification',
  'sound002_notification.mp3': 'Notification',
  'sound003_full_alert.mp3': 'Full Alert',
  'sound004_cullingham.mp3': 'Cullingham',
  'sound005_beep_beep.mp3': 'Beep Beep',
};

@riverpod
class Tune extends _$Tune {
  @override
  List<TuneData> build() {
    _prefs = ref.read(sharedPreferences);
    final dataRaw = _prefs.getStringList('tunedata');
    final data = (dataRaw?.map(
              (e) => TuneData.fromJson(json.decode(e) as Map<String, dynamic>),
            ) ??
            tunes
                .map(
                  (key, value) => MapEntry(
                    key,
                    TuneData(
                      path: key,
                      title: value,
                    ),
                  ),
                )
                .values)
        .toList();
    if (data.where((element) => element.selected).isEmpty) {
      data[0] = data[0].copyWith(selected: true);
    }

    return data;
  }

  void select(int index) {
    final newState = [...state];
    final selectedIndex = state.indexWhere((element) => element.selected);
    newState[selectedIndex] = newState[selectedIndex].copyWith(selected: false);
    newState[index] = newState[index].copyWith(selected: true);
    state = newState;
    _prefs.setStringList(
      'tunedata',
      state.map((e) => json.encode(e.toJson())).toList(),
    );
  }

  late SharedPreferences _prefs;
}

@freezed
class TuneData with _$TuneData {
  const factory TuneData({
    required String title,
    required String path,
    @Default(false) bool selected,
  }) = _TuneData;

  factory TuneData.fromJson(Map<String, dynamic> json) =>
      _$TuneDataFromJson(json);
}
