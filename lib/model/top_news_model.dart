import 'package:json_annotation/json_annotation.dart';

part 'top_news_model.g.dart'; // This is the generated file

@JsonSerializable()
class TopNewsModel {
  String? status;
  int? totalResults;
  List<Articles>? articles;
  TopNewsModel({this.status, this.totalResults, this.articles});

  factory TopNewsModel.fromJson(Map<String, dynamic> json) =>
      _$TopNewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$TopNewsModelToJson(this);
}

@JsonSerializable()
class Articles {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  Articles(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  factory Articles.fromJson(Map<String, dynamic> json) =>
      _$ArticlesFromJson(json);

  Map<String, dynamic> toJson() => _$ArticlesToJson(this);
}

@JsonSerializable()
class Source {
  String? id;
  String? name;

  Source({this.id, this.name});

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);

  Map<String, dynamic> toJson() => _$SourceToJson(this);
}
