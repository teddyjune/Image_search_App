import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo.freezed.dart';

part 'photo.g.dart';

@freezed
class Photo with _$Photo {
  const factory Photo({
    required String previewURL,
    required String tags,
  }) = _Photo;

  factory Photo.fromJson(Map<String, Object?> json) => _$PhotoFromJson(json);
}


// import 'package:json_annotation/json_annotation.dart';
//
// part 'photo.g.dart';
//
// @JsonSerializable(explicitToJson: true)
// class Photo {
//   final
//   final
//
//   Photo({
//
//   });
//
//   factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
//
//   Map<String, dynamic> toJson() => _$PhotoToJson(this);
// }
