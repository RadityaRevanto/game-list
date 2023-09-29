final String tableFavorite = 'news  ';

class Favorite {
  static final List<String> values = [id, image, name, slug, released];

  static final String id = 'id';
  static final String image = 'image_background';
  static final String name = 'name';
  static final String slug = 'slug';
  static final String released = 'released';
}

class FavoriteModel {
  final int? id;
  final String image;
  final String name;
  final String slug;
  final String released;

  FavoriteModel(
      {this.id,
        required this.image,
        required this.name,
        required this.slug,
        required this.released});

  static FavoriteModel fromJson(Map<String, Object?> json) => FavoriteModel(
    id: json[Favorite.id] as int?,
    image: json[Favorite.image] as String,
    name: json[Favorite.name] as String,
    slug: json[Favorite.slug] as String,
    released: json[Favorite.released] as String,
  );

  Map<String, Object?> toJson() => {
    Favorite.id: id,
    Favorite.image: image,
    Favorite.name: name,
    Favorite.slug: slug,
    Favorite.released: released
  };

  FavoriteModel copy(
      {int? id,
        String? imageUrl,
        String? author,
        String? slug,
        String? released}) =>
      FavoriteModel(
          id: id ?? this.id,
          image: imageUrl ?? this.image,
          name: author ?? this.name,
          slug: slug ?? this.slug,
          released: released ?? this.released);
}