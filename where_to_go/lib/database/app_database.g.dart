// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DreamPlacesTable extends DreamPlaces with TableInfo<$DreamPlacesTable, DreamPlace> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DreamPlacesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionTitleMeta = const VerificationMeta('descriptionTitle');
  @override
  late final GeneratedColumn<String> descriptionTitle = GeneratedColumn<String>(
    'description_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("is_favorite" IN (0, 1))'),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, title, descriptionTitle, description, imageUrl, isFavorite];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dream_places';
  @override
  VerificationContext validateIntegrity(Insertable<DreamPlace> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(_titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description_title')) {
      context.handle(
        _descriptionTitleMeta,
        descriptionTitle.isAcceptableOrUnknown(data['description_title']!, _descriptionTitleMeta),
      );
    } else if (isInserting) {
      context.missing(_descriptionTitleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(_descriptionMeta, description.isAcceptableOrUnknown(data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta, imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(_isFavoriteMeta, isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DreamPlace map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DreamPlace(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      descriptionTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_title'],
      )!,
      description: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      imageUrl: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}image_url'])!,
      isFavorite: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!,
    );
  }

  @override
  $DreamPlacesTable createAlias(String alias) {
    return $DreamPlacesTable(attachedDatabase, alias);
  }
}

class DreamPlace extends DataClass implements Insertable<DreamPlace> {
  final int id;
  final String title;
  final String descriptionTitle;
  final String description;
  final String imageUrl;
  final bool isFavorite;
  const DreamPlace({
    required this.id,
    required this.title,
    required this.descriptionTitle,
    required this.description,
    required this.imageUrl,
    required this.isFavorite,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['description_title'] = Variable<String>(descriptionTitle);
    map['description'] = Variable<String>(description);
    map['image_url'] = Variable<String>(imageUrl);
    map['is_favorite'] = Variable<bool>(isFavorite);
    return map;
  }

  DreamPlacesCompanion toCompanion(bool nullToAbsent) {
    return DreamPlacesCompanion(
      id: Value(id),
      title: Value(title),
      descriptionTitle: Value(descriptionTitle),
      description: Value(description),
      imageUrl: Value(imageUrl),
      isFavorite: Value(isFavorite),
    );
  }

  factory DreamPlace.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DreamPlace(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      descriptionTitle: serializer.fromJson<String>(json['descriptionTitle']),
      description: serializer.fromJson<String>(json['description']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'descriptionTitle': serializer.toJson<String>(descriptionTitle),
      'description': serializer.toJson<String>(description),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'isFavorite': serializer.toJson<bool>(isFavorite),
    };
  }

  DreamPlace copyWith({
    int? id,
    String? title,
    String? descriptionTitle,
    String? description,
    String? imageUrl,
    bool? isFavorite,
  }) => DreamPlace(
    id: id ?? this.id,
    title: title ?? this.title,
    descriptionTitle: descriptionTitle ?? this.descriptionTitle,
    description: description ?? this.description,
    imageUrl: imageUrl ?? this.imageUrl,
    isFavorite: isFavorite ?? this.isFavorite,
  );
  DreamPlace copyWithCompanion(DreamPlacesCompanion data) {
    return DreamPlace(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      descriptionTitle: data.descriptionTitle.present ? data.descriptionTitle.value : this.descriptionTitle,
      description: data.description.present ? data.description.value : this.description,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      isFavorite: data.isFavorite.present ? data.isFavorite.value : this.isFavorite,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DreamPlace(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('descriptionTitle: $descriptionTitle, ')
          ..write('description: $description, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, descriptionTitle, description, imageUrl, isFavorite);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DreamPlace &&
          other.id == this.id &&
          other.title == this.title &&
          other.descriptionTitle == this.descriptionTitle &&
          other.description == this.description &&
          other.imageUrl == this.imageUrl &&
          other.isFavorite == this.isFavorite);
}

class DreamPlacesCompanion extends UpdateCompanion<DreamPlace> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> descriptionTitle;
  final Value<String> description;
  final Value<String> imageUrl;
  final Value<bool> isFavorite;
  const DreamPlacesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.descriptionTitle = const Value.absent(),
    this.description = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.isFavorite = const Value.absent(),
  });
  DreamPlacesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String descriptionTitle,
    required String description,
    required String imageUrl,
    this.isFavorite = const Value.absent(),
  }) : title = Value(title),
       descriptionTitle = Value(descriptionTitle),
       description = Value(description),
       imageUrl = Value(imageUrl);
  static Insertable<DreamPlace> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? descriptionTitle,
    Expression<String>? description,
    Expression<String>? imageUrl,
    Expression<bool>? isFavorite,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (descriptionTitle != null) 'description_title': descriptionTitle,
      if (description != null) 'description': description,
      if (imageUrl != null) 'image_url': imageUrl,
      if (isFavorite != null) 'is_favorite': isFavorite,
    });
  }

  DreamPlacesCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? descriptionTitle,
    Value<String>? description,
    Value<String>? imageUrl,
    Value<bool>? isFavorite,
  }) {
    return DreamPlacesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      descriptionTitle: descriptionTitle ?? this.descriptionTitle,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (descriptionTitle.present) {
      map['description_title'] = Variable<String>(descriptionTitle.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DreamPlacesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('descriptionTitle: $descriptionTitle, ')
          ..write('description: $description, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DreamPlacesTable dreamPlaces = $DreamPlacesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables => allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [dreamPlaces];
}

typedef $$DreamPlacesTableCreateCompanionBuilder = DreamPlacesCompanion Function({
  Value<int> id,
  required String title,
  required String descriptionTitle,
  required String description,
  required String imageUrl,
  Value<bool> isFavorite,
});
typedef $$DreamPlacesTableUpdateCompanionBuilder = DreamPlacesCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<String> descriptionTitle,
  Value<String> description,
  Value<String> imageUrl,
  Value<bool> isFavorite,
});

class $$DreamPlacesTableFilterComposer extends Composer<_$AppDatabase, $DreamPlacesTable> {
  $$DreamPlacesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descriptionTitle =>
      $composableBuilder(column: $table.descriptionTitle, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description =>
      $composableBuilder(column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isFavorite =>
      $composableBuilder(column: $table.isFavorite, builder: (column) => ColumnFilters(column));
}

class $$DreamPlacesTableOrderingComposer extends Composer<_$AppDatabase, $DreamPlacesTable> {
  $$DreamPlacesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descriptionTitle =>
      $composableBuilder(column: $table.descriptionTitle, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description =>
      $composableBuilder(column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isFavorite =>
      $composableBuilder(column: $table.isFavorite, builder: (column) => ColumnOrderings(column));
}

class $$DreamPlacesTableAnnotationComposer extends Composer<_$AppDatabase, $DreamPlacesTable> {
  $$DreamPlacesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title => $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get descriptionTitle =>
      $composableBuilder(column: $table.descriptionTitle, builder: (column) => column);

  GeneratedColumn<String> get description =>
      $composableBuilder(column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get imageUrl => $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(column: $table.isFavorite, builder: (column) => column);
}

class $$DreamPlacesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DreamPlacesTable,
          DreamPlace,
          $$DreamPlacesTableFilterComposer,
          $$DreamPlacesTableOrderingComposer,
          $$DreamPlacesTableAnnotationComposer,
          $$DreamPlacesTableCreateCompanionBuilder,
          $$DreamPlacesTableUpdateCompanionBuilder,
          (DreamPlace, BaseReferences<_$AppDatabase, $DreamPlacesTable, DreamPlace>),
          DreamPlace,
          PrefetchHooks Function()
        > {
  $$DreamPlacesTableTableManager(_$AppDatabase db, $DreamPlacesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$DreamPlacesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$DreamPlacesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$DreamPlacesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> descriptionTitle = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
              }) => DreamPlacesCompanion(
                id: id,
                title: title,
                descriptionTitle: descriptionTitle,
                description: description,
                imageUrl: imageUrl,
                isFavorite: isFavorite,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String descriptionTitle,
                required String description,
                required String imageUrl,
                Value<bool> isFavorite = const Value.absent(),
              }) => DreamPlacesCompanion.insert(
                id: id,
                title: title,
                descriptionTitle: descriptionTitle,
                description: description,
                imageUrl: imageUrl,
                isFavorite: isFavorite,
              ),
          withReferenceMapper: (p0) => p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DreamPlacesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DreamPlacesTable,
      DreamPlace,
      $$DreamPlacesTableFilterComposer,
      $$DreamPlacesTableOrderingComposer,
      $$DreamPlacesTableAnnotationComposer,
      $$DreamPlacesTableCreateCompanionBuilder,
      $$DreamPlacesTableUpdateCompanionBuilder,
      (DreamPlace, BaseReferences<_$AppDatabase, $DreamPlacesTable, DreamPlace>),
      DreamPlace,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DreamPlacesTableTableManager get dreamPlaces => $$DreamPlacesTableTableManager(_db, _db.dreamPlaces);
}
