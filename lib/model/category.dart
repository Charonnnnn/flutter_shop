/*
class CategoryModel{
  String mallCategoryId;
  String mallCategoryName;
  List<dynamic> bxMallSubDto;
  Null comments;
  String image;

  CategoryModel({
    this.bxMallSubDto,
    this.comments,
    this.image,
    this.mallCategoryId,
    this.mallCategoryName,
  });

  // 工厂模式, 最常用的实例化对象模式, 用工厂方法代替new操作的一种模式
  // 在工厂模式中，我们在创建对象时不会对客户端暴露创建逻辑，
  // 并且是通过使用一个共同的接口来指向新创建的对象
  // 意图：定义一个创建对象的接口，让其子类自己决定实例化哪一个工厂类，工厂模式使其创建过程延迟到子类进行。
  // 主要解决：主要解决接口选择的问题。
  // 何时使用：我们明确地计划不同条件下创建不同实例时。
  // 如何解决：让其子类实现工厂接口，返回的也是一个抽象的产品。
  // 关键代码：创建过程在其子类执行

  //factory 关键字的功能，当实现构造函数但是不想每次都创建该类的一个实例的时候使用。
  factory CategoryModel.fromJson(dynamic json){  //formJson是自定义的方法

    return CategoryModel(
      mallCategoryId: json['mallCategoryId'],
      mallCategoryName: json['mallCategoryName'],
      bxMallSubDto: json['bxMallSubDto'],
      comments: json['comments'],
      image: json['image'],
    );
  }
}

class CategoryListModel{
  List<CategoryModel> data;
  CategoryListModel(this.data);

  factory CategoryListModel.fromJson(List json){
    return CategoryListModel(
      json.map((i)=>CategoryModel.fromJson((i))).toList()
    );
  }
}
*/



/// https://javiercbk.github.io/json_to_dart/
class CategoryModel {
  String code;
  String message;
  List<Data> data;

  CategoryModel({this.code, this.message, this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String mallCategoryId;
  String mallCategoryName;
  List<BxMallSubDto> bxMallSubDto;
  Null comments;
  String image;

  Data(
      {this.mallCategoryId,
      this.mallCategoryName,
      this.bxMallSubDto,
      this.comments,
      this.image});

  Data.fromJson(Map<String, dynamic> json) {
    mallCategoryId = json['mallCategoryId'];
    mallCategoryName = json['mallCategoryName'];
    if (json['bxMallSubDto'] != null) {
      bxMallSubDto = new List<BxMallSubDto>();
      json['bxMallSubDto'].forEach((v) {
        bxMallSubDto.add(new BxMallSubDto.fromJson(v));
      });
    }
    comments = json['comments'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mallCategoryId'] = this.mallCategoryId;
    data['mallCategoryName'] = this.mallCategoryName;
    if (this.bxMallSubDto != null) {
      data['bxMallSubDto'] = this.bxMallSubDto.map((v) => v.toJson()).toList();
    }
    data['comments'] = this.comments;
    data['image'] = this.image;
    return data;
  }
}

class BxMallSubDto {
  String mallSubId;
  String mallCategoryId;
  String mallSubName;
  String comments;

  BxMallSubDto(
      {this.mallSubId, this.mallCategoryId, this.mallSubName, this.comments});

  BxMallSubDto.fromJson(Map<String, dynamic> json) {
    mallSubId = json['mallSubId'];
    mallCategoryId = json['mallCategoryId'];
    mallSubName = json['mallSubName'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mallSubId'] = this.mallSubId;
    data['mallCategoryId'] = this.mallCategoryId;
    data['mallSubName'] = this.mallSubName;
    data['comments'] = this.comments;
    return data;
  }
}
