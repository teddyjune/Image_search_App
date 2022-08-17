import 'package:json_annotation/json_annotation.dart';
part 'photo.g.dart';

@JsonSerializable(explicitToJson: true)
class Photo {
  final String previewURL;
  final String tags;

  Photo({
    required this.previewURL,
    required this.tags,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}