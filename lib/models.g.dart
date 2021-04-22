// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class gradeEnumAdapter extends TypeAdapter<gradeEnum> {
  @override
  final int typeId = 4;

  @override
  gradeEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return gradeEnum.DAISY;
      case 1:
        return gradeEnum.BROWNIE;
      case 2:
        return gradeEnum.JUNIOR;
      case 3:
        return gradeEnum.CADETTE;
      case 4:
        return gradeEnum.SENIOR;
      case 5:
        return gradeEnum.AMBASSADOR;
      case 6:
        return gradeEnum.ALL;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, gradeEnum obj) {
    switch (obj) {
      case gradeEnum.DAISY:
        writer.writeByte(0);
        break;
      case gradeEnum.BROWNIE:
        writer.writeByte(1);
        break;
      case gradeEnum.JUNIOR:
        writer.writeByte(2);
        break;
      case gradeEnum.CADETTE:
        writer.writeByte(3);
        break;
      case gradeEnum.SENIOR:
        writer.writeByte(4);
        break;
      case gradeEnum.AMBASSADOR:
        writer.writeByte(5);
        break;
      case gradeEnum.ALL:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is gradeEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MemberAdapter extends TypeAdapter<Member> {
  @override
  final int typeId = 0;

  @override
  Member read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Member(
      fields[0] as String,
      (fields[1] as HiveList)?.castHiveList(),
      fields[2] as String,
      fields[3] as DateTime,
      fields[4] as String,
      (fields[5] as HiveList)?.castHiveList(),
      (fields[6] as HiveList)?.castHiveList(),
      (fields[7] as HiveList)?.castHiveList(),
      isArchived: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Member obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.grade)
      ..writeByte(2)
      ..write(obj.team)
      ..writeByte(3)
      ..write(obj.birthday)
      ..writeByte(4)
      ..write(obj.photoPath)
      ..writeByte(5)
      ..write(obj.badgeTags)
      ..writeByte(6)
      ..write(obj.seasons)
      ..writeByte(7)
      ..write(obj.sales)
      ..writeByte(8)
      ..write(obj.isArchived);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemberAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BadgeTagAdapter extends TypeAdapter<BadgeTag> {
  @override
  final int typeId = 1;

  @override
  BadgeTag read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BadgeTag(
      (fields[3] as HiveList)?.castHiveList(),
      (fields[4] as HiveList)?.castHiveList(),
      (fields[5] as Map)?.cast<String, String>(),
      status: fields[0] as String,
      completedRequirements: fields[1] as String,
    )..dateAcquired = fields[2] as DateTime;
  }

  @override
  void write(BinaryWriter writer, BadgeTag obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.completedRequirements)
      ..writeByte(2)
      ..write(obj.dateAcquired)
      ..writeByte(3)
      ..write(obj.badge)
      ..writeByte(4)
      ..write(obj.member)
      ..writeByte(5)
      ..write(obj.requirementsMet);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BadgeTagAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BadgeAdapter extends TypeAdapter<Badge> {
  @override
  final int typeId = 2;

  @override
  Badge read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Badge(
      fields[0] as String,
      fields[2] as String,
      (fields[3] as HiveList)?.castHiveList(),
      (fields[5] as List)?.cast<String>(),
      fields[6] as String,
      (fields[7] as HiveList)?.castHiveList(),
      isArchived: fields[8] as String,
    )
      ..subtitle = fields[1] as String
      ..type = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, Badge obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.subtitle)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.grade)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.requirements)
      ..writeByte(6)
      ..write(obj.photoPath)
      ..writeByte(7)
      ..write(obj.badgeTags)
      ..writeByte(8)
      ..write(obj.isArchived);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BadgeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GradeAdapter extends TypeAdapter<Grade> {
  @override
  final int typeId = 3;

  @override
  Grade read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Grade(
      fields[0] as gradeEnum,
      (fields[1] as HiveList)?.castHiveList(),
      (fields[2] as HiveList)?.castHiveList(),
    );
  }

  @override
  void write(BinaryWriter writer, Grade obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.members)
      ..writeByte(2)
      ..write(obj.badges);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GradeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CookieAdapter extends TypeAdapter<Cookie> {
  @override
  final int typeId = 5;

  @override
  Cookie read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cookie(
      fields[0] as String,
      fields[1] as double,
      fields[2] as int,
      /*
      fields[3] as String,
      (fields[4] as HiveList)?.castHiveList(),
      (fields[5] as HiveList)?.castHiveList(),
      (fields[6] as HiveList)?.castHiveList(),
      (fields[7] as HiveList)?.castHiveList(),
      isArchived: fields[8] as String,

       */
    );
  }

  @override
  void write(BinaryWriter writer, Cookie obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.quantity);
      /*
      ..writeByte(3)
      ..write(obj.photoPath)
      ..writeByte(4)
      ..write(obj.seasons)
      ..writeByte(5)
      ..write(obj.sales)
      ..writeByte(6)
      ..write(obj.orders)
      ..writeByte(7)
      ..write(obj.transfers)
      ..writeByte(8)
      ..write(obj.isArchived);

       */
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CookieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SaleAdapter extends TypeAdapter<Sale> {
  @override
  final int typeId = 6;

  @override
  Sale read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Sale(
      fields[0] as int,
      fields[1] as DateTime,
      fields[2] as double,
      (fields[3] as HiveList)?.castHiveList(),
      (fields[4] as HiveList)?.castHiveList(),
      (fields[5] as HiveList)?.castHiveList(),
    );
  }

  @override
  void write(BinaryWriter writer, Sale obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.quantity)
      ..writeByte(1)
      ..write(obj.dateOfSale)
      ..writeByte(2)
      ..write(obj.salesPrice)
      ..writeByte(3)
      ..write(obj.season)
      ..writeByte(4)
      ..write(obj.member)
      ..writeByte(5)
      ..write(obj.cookie);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OrderAdapter extends TypeAdapter<Order> {
  @override
  final int typeId = 7;

  @override
  Order read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Order(
      fields[0] as int,
      fields[1] as DateTime,
      (fields[2] as HiveList)?.castHiveList(),
      (fields[3] as HiveList)?.castHiveList(),
    );
  }

  @override
  void write(BinaryWriter writer, Order obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.quantity)
      ..writeByte(1)
      ..write(obj.dateOfSale)
      ..writeByte(2)
      ..write(obj.season)
      ..writeByte(3)
      ..write(obj.cookie);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TransferAdapter extends TypeAdapter<Transfer> {
  @override
  final int typeId = 8;

  @override
  Transfer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Transfer(
      fields[0] as int,
      fields[1] as DateTime,
      fields[2] as String,
      (fields[3] as HiveList)?.castHiveList(),
      (fields[4] as HiveList)?.castHiveList(),
    );
  }

  @override
  void write(BinaryWriter writer, Transfer obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.quantity)
      ..writeByte(1)
      ..write(obj.dateOfTransfer)
      ..writeByte(2)
      ..write(obj.receivingTroop)
      ..writeByte(3)
      ..write(obj.season)
      ..writeByte(4)
      ..write(obj.cookie);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransferAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SeasonAdapter extends TypeAdapter<Season> {
  @override
  final int typeId = 9;

  @override
  Season read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Season(
      fields[0] as int,
      fields[1] as DateTime,
      (fields[2] as HiveList)?.castHiveList(),
      (fields[3] as HiveList)?.castHiveList(),
      (fields[4] as HiveList)?.castHiveList(),
      (fields[5] as HiveList)?.castHiveList(),
      (fields[6] as HiveList)?.castHiveList(),
    );
  }

  @override
  void write(BinaryWriter writer, Season obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.year)
      ..writeByte(1)
      ..write(obj.startDate)
      ..writeByte(2)
      ..write(obj.members)
      ..writeByte(3)
      ..write(obj.cookies)
      ..writeByte(4)
      ..write(obj.sales)
      ..writeByte(5)
      ..write(obj.orders)
      ..writeByte(6)
      ..write(obj.transfers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeasonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
