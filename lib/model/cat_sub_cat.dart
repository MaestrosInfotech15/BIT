class CatSubCat {
  List<CategoryList>? category;
  String? result;
  String? apiStatus;

  CatSubCat({this.category, this.result, this.apiStatus});

  CatSubCat.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = <CategoryList>[];
      json['category'].forEach((v) {
        category!.add(CategoryList.fromJson(v));
      });
    }
    result = json['result'];
    apiStatus = json['api_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (category != null) {
      data['category'] = category!.map((v) => v.toJson()).toList();
    }
    data['result'] = result;
    data['api_status'] = apiStatus;
    return data;
  }
}

class CategoryList {
  String? id;
  String? name;
  bool? isCat = false;
  List<SubCategoryList>? subcategory;

  CategoryList({this.id, this.name, this.subcategory,this.isCat=false});

  CategoryList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['subcategory'] != null) {
      subcategory = <SubCategoryList>[];
      json['subcategory'].forEach((v) {
        subcategory!.add(SubCategoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (subcategory != null) {
      data['subcategory'] = subcategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategoryList {
  String? id;
  String? subName;
  bool? isSelected = false;

  SubCategoryList({this.id, this.subName,this.isSelected = false});

  SubCategoryList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subName = json['sub_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['sub_name'] = subName;
    return data;
  }
}
