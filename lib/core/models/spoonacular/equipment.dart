class Equipment {
  final String name;
  final String image;
  final int id;
  final String localizedName;
  Equipment({
    this.id,
    this.localizedName,
    this.name,
    this.image,
  });

  factory Equipment.fromJson(Map<String, dynamic> json) {
    return Equipment(
        image: "https://spoonacular.com/cdn/equipment_100x100/${json['image']}",
        name: json['name'],
        localizedName: json['localizedName'],
        id: json['id']);
  }

  toJson() => {
        'id': id,
        'name': name,
        'localizedName': localizedName,
        'image': image,
      };
}

class EquipmentList {
  final List<Equipment> items;
  EquipmentList({
    this.items,
  });
  factory EquipmentList.fromJson(List<dynamic> list) {
    return new EquipmentList(
      items: list.map((data) => Equipment.fromJson(data)).toList(),
    );
  }
}
