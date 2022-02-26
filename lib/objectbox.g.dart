// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'data/model/word.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 5465389464763670641),
      name: 'Gloss',
      lastPropertyId: const IdUid(3, 8207188119227123443),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 2201652406963449024),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 199321494178089412),
            name: 'text',
            type: 9,
            flags: 2048,
            indexId: const IdUid(1, 2239603432638709468)),
        ModelProperty(
            id: const IdUid(3, 8207188119227123443),
            name: 'type',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 6795119589062125692),
      name: 'Kanji',
      lastPropertyId: const IdUid(4, 1427312206460182407),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 557559483226203806),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 290906095629450178),
            name: 'text',
            type: 9,
            flags: 2048,
            indexId: const IdUid(2, 1035453860399978253)),
        ModelProperty(
            id: const IdUid(3, 3193979056744236345),
            name: 'info',
            type: 30,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 1427312206460182407),
            name: 'common',
            type: 1,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(3, 9067311017714686474),
      name: 'Reading',
      lastPropertyId: const IdUid(5, 2868518844698070274),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 732351382141466127),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 5696991321750584842),
            name: 'text',
            type: 9,
            flags: 2048,
            indexId: const IdUid(3, 1086156369267436292)),
        ModelProperty(
            id: const IdUid(3, 5894972871940959002),
            name: 'info',
            type: 30,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 4538148117300009945),
            name: 'restrictedTo',
            type: 30,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 2868518844698070274),
            name: 'common',
            type: 1,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(4, 572959809601206590),
      name: 'Sense',
      lastPropertyId: const IdUid(10, 7665057755056875639),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 3987952687589469546),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 2769809858212234524),
            name: 'pos',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 1713153040726161419),
            name: 'related',
            type: 30,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 5721425407940827990),
            name: 'antonym',
            type: 30,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 3980747825953468483),
            name: 'field',
            type: 30,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 8435788726515734466),
            name: 'dialect',
            type: 30,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 398675864466282560),
            name: 'misc',
            type: 30,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 2563014079544963812),
            name: 'info',
            type: 30,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 2510042711457747249),
            name: 'stagk',
            type: 30,
            flags: 0),
        ModelProperty(
            id: const IdUid(10, 7665057755056875639),
            name: 'stagr',
            type: 30,
            flags: 0)
      ],
      relations: <ModelRelation>[
        ModelRelation(
            id: const IdUid(1, 6184392229858297114),
            name: 'gloss',
            targetId: const IdUid(1, 5465389464763670641))
      ],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(5, 6056800021693025944),
      name: 'WordEntry',
      lastPropertyId: const IdUid(1, 6499450520459820979),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 6499450520459820979),
            name: 'id',
            type: 6,
            flags: 129)
      ],
      relations: <ModelRelation>[
        ModelRelation(
            id: const IdUid(2, 4313437004292146637),
            name: 'kanji',
            targetId: const IdUid(2, 6795119589062125692)),
        ModelRelation(
            id: const IdUid(3, 969599822351203182),
            name: 'reading',
            targetId: const IdUid(3, 9067311017714686474)),
        ModelRelation(
            id: const IdUid(4, 8753702223357579575),
            name: 'sense',
            targetId: const IdUid(4, 572959809601206590))
      ],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(5, 6056800021693025944),
      lastIndexId: const IdUid(3, 1086156369267436292),
      lastRelationId: const IdUid(4, 8753702223357579575),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Gloss: EntityDefinition<Gloss>(
        model: _entities[0],
        toOneRelations: (Gloss object) => [],
        toManyRelations: (Gloss object) => {},
        getId: (Gloss object) => object.id,
        setId: (Gloss object, int id) {
          object.id = id;
        },
        objectToFB: (Gloss object, fb.Builder fbb) {
          final textOffset =
              object.text == null ? null : fbb.writeString(object.text!);
          final typeOffset =
              object.type == null ? null : fbb.writeString(object.type!);
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, textOffset);
          fbb.addOffset(2, typeOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Gloss(
              text: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              type: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8))
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);

          return object;
        }),
    Kanji: EntityDefinition<Kanji>(
        model: _entities[1],
        toOneRelations: (Kanji object) => [],
        toManyRelations: (Kanji object) => {},
        getId: (Kanji object) => object.id,
        setId: (Kanji object, int id) {
          object.id = id;
        },
        objectToFB: (Kanji object, fb.Builder fbb) {
          final textOffset =
              object.text == null ? null : fbb.writeString(object.text!);
          final infoOffset = object.info == null
              ? null
              : fbb.writeList(
                  object.info!.map(fbb.writeString).toList(growable: false));
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, textOffset);
          fbb.addOffset(2, infoOffset);
          fbb.addBool(3, object.common);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Kanji(
              text: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              info: const fb.ListReader<String>(
                      fb.StringReader(asciiOptimization: true),
                      lazy: false)
                  .vTableGetNullable(buffer, rootOffset, 8),
              common: const fb.BoolReader()
                  .vTableGet(buffer, rootOffset, 10, false))
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);

          return object;
        }),
    Reading: EntityDefinition<Reading>(
        model: _entities[2],
        toOneRelations: (Reading object) => [],
        toManyRelations: (Reading object) => {},
        getId: (Reading object) => object.id,
        setId: (Reading object, int id) {
          object.id = id;
        },
        objectToFB: (Reading object, fb.Builder fbb) {
          final textOffset =
              object.text == null ? null : fbb.writeString(object.text!);
          final infoOffset = object.info == null
              ? null
              : fbb.writeList(
                  object.info!.map(fbb.writeString).toList(growable: false));
          final restrictedToOffset = object.restrictedTo == null
              ? null
              : fbb.writeList(object.restrictedTo!
                  .map(fbb.writeString)
                  .toList(growable: false));
          fbb.startTable(6);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, textOffset);
          fbb.addOffset(2, infoOffset);
          fbb.addOffset(3, restrictedToOffset);
          fbb.addBool(4, object.common);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Reading(
              text: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              info: const fb.ListReader<String>(
                      fb.StringReader(asciiOptimization: true),
                      lazy: false)
                  .vTableGetNullable(buffer, rootOffset, 8),
              restrictedTo: const fb.ListReader<String>(
                      fb.StringReader(asciiOptimization: true),
                      lazy: false)
                  .vTableGetNullable(buffer, rootOffset, 10),
              common: const fb.BoolReader()
                  .vTableGet(buffer, rootOffset, 12, false))
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);

          return object;
        }),
    Sense: EntityDefinition<Sense>(
        model: _entities[3],
        toOneRelations: (Sense object) => [],
        toManyRelations: (Sense object) =>
            {RelInfo<Sense>.toMany(1, object.id): object.gloss},
        getId: (Sense object) => object.id,
        setId: (Sense object, int id) {
          object.id = id;
        },
        objectToFB: (Sense object, fb.Builder fbb) {
          final posOffset =
              object.pos == null ? null : fbb.writeString(object.pos!);
          final relatedOffset = object.related == null
              ? null
              : fbb.writeList(
                  object.related!.map(fbb.writeString).toList(growable: false));
          final antonymOffset = object.antonym == null
              ? null
              : fbb.writeList(
                  object.antonym!.map(fbb.writeString).toList(growable: false));
          final fieldOffset = object.field == null
              ? null
              : fbb.writeList(
                  object.field!.map(fbb.writeString).toList(growable: false));
          final dialectOffset = object.dialect == null
              ? null
              : fbb.writeList(
                  object.dialect!.map(fbb.writeString).toList(growable: false));
          final miscOffset = object.misc == null
              ? null
              : fbb.writeList(
                  object.misc!.map(fbb.writeString).toList(growable: false));
          final infoOffset = object.info == null
              ? null
              : fbb.writeList(
                  object.info!.map(fbb.writeString).toList(growable: false));
          final stagkOffset = object.stagk == null
              ? null
              : fbb.writeList(
                  object.stagk!.map(fbb.writeString).toList(growable: false));
          final stagrOffset = object.stagr == null
              ? null
              : fbb.writeList(
                  object.stagr!.map(fbb.writeString).toList(growable: false));
          fbb.startTable(11);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, posOffset);
          fbb.addOffset(2, relatedOffset);
          fbb.addOffset(3, antonymOffset);
          fbb.addOffset(4, fieldOffset);
          fbb.addOffset(5, dialectOffset);
          fbb.addOffset(6, miscOffset);
          fbb.addOffset(7, infoOffset);
          fbb.addOffset(8, stagkOffset);
          fbb.addOffset(9, stagrOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Sense(
              pos: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              related: const fb.ListReader<String>(fb.StringReader(asciiOptimization: true), lazy: false)
                  .vTableGetNullable(buffer, rootOffset, 8),
              antonym: const fb.ListReader<String>(fb.StringReader(asciiOptimization: true), lazy: false)
                  .vTableGetNullable(buffer, rootOffset, 10),
              field: const fb.ListReader<String>(fb.StringReader(asciiOptimization: true), lazy: false)
                  .vTableGetNullable(buffer, rootOffset, 12),
              dialect: const fb.ListReader<String>(fb.StringReader(asciiOptimization: true), lazy: false)
                  .vTableGetNullable(buffer, rootOffset, 14),
              misc: const fb.ListReader<String>(fb.StringReader(asciiOptimization: true), lazy: false)
                  .vTableGetNullable(buffer, rootOffset, 16),
              info: const fb.ListReader<String>(fb.StringReader(asciiOptimization: true), lazy: false)
                  .vTableGetNullable(buffer, rootOffset, 18),
              stagk: const fb.ListReader<String>(fb.StringReader(asciiOptimization: true), lazy: false).vTableGetNullable(buffer, rootOffset, 20),
              stagr: const fb.ListReader<String>(fb.StringReader(asciiOptimization: true), lazy: false).vTableGetNullable(buffer, rootOffset, 22))
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          InternalToManyAccess.setRelInfo(object.gloss, store,
              RelInfo<Sense>.toMany(1, object.id), store.box<Sense>());
          return object;
        }),
    WordEntry: EntityDefinition<WordEntry>(
        model: _entities[4],
        toOneRelations: (WordEntry object) => [],
        toManyRelations: (WordEntry object) => {
              RelInfo<WordEntry>.toMany(2, object.id): object.kanji,
              RelInfo<WordEntry>.toMany(3, object.id): object.reading,
              RelInfo<WordEntry>.toMany(4, object.id): object.sense
            },
        getId: (WordEntry object) => object.id,
        setId: (WordEntry object, int id) {
          if (object.id != id) {
            throw ArgumentError('Field WordEntry.id is read-only '
                '(final or getter-only) and it was declared to be self-assigned. '
                'However, the currently inserted object (.id=${object.id}) '
                "doesn't match the inserted ID (ID $id). "
                'You must assign an ID before calling [box.put()].');
          }
        },
        objectToFB: (WordEntry object, fb.Builder fbb) {
          fbb.startTable(2);
          fbb.addInt64(0, object.id);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = WordEntry(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0));
          InternalToManyAccess.setRelInfo(object.kanji, store,
              RelInfo<WordEntry>.toMany(2, object.id), store.box<WordEntry>());
          InternalToManyAccess.setRelInfo(object.reading, store,
              RelInfo<WordEntry>.toMany(3, object.id), store.box<WordEntry>());
          InternalToManyAccess.setRelInfo(object.sense, store,
              RelInfo<WordEntry>.toMany(4, object.id), store.box<WordEntry>());
          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Gloss] entity fields to define ObjectBox queries.
class Gloss_ {
  /// see [Gloss.id]
  static final id = QueryIntegerProperty<Gloss>(_entities[0].properties[0]);

  /// see [Gloss.text]
  static final text = QueryStringProperty<Gloss>(_entities[0].properties[1]);

  /// see [Gloss.type]
  static final type = QueryStringProperty<Gloss>(_entities[0].properties[2]);
}

/// [Kanji] entity fields to define ObjectBox queries.
class Kanji_ {
  /// see [Kanji.id]
  static final id = QueryIntegerProperty<Kanji>(_entities[1].properties[0]);

  /// see [Kanji.text]
  static final text = QueryStringProperty<Kanji>(_entities[1].properties[1]);

  /// see [Kanji.info]
  static final info =
      QueryStringVectorProperty<Kanji>(_entities[1].properties[2]);

  /// see [Kanji.common]
  static final common = QueryBooleanProperty<Kanji>(_entities[1].properties[3]);
}

/// [Reading] entity fields to define ObjectBox queries.
class Reading_ {
  /// see [Reading.id]
  static final id = QueryIntegerProperty<Reading>(_entities[2].properties[0]);

  /// see [Reading.text]
  static final text = QueryStringProperty<Reading>(_entities[2].properties[1]);

  /// see [Reading.info]
  static final info =
      QueryStringVectorProperty<Reading>(_entities[2].properties[2]);

  /// see [Reading.restrictedTo]
  static final restrictedTo =
      QueryStringVectorProperty<Reading>(_entities[2].properties[3]);

  /// see [Reading.common]
  static final common =
      QueryBooleanProperty<Reading>(_entities[2].properties[4]);
}

/// [Sense] entity fields to define ObjectBox queries.
class Sense_ {
  /// see [Sense.id]
  static final id = QueryIntegerProperty<Sense>(_entities[3].properties[0]);

  /// see [Sense.pos]
  static final pos = QueryStringProperty<Sense>(_entities[3].properties[1]);

  /// see [Sense.related]
  static final related =
      QueryStringVectorProperty<Sense>(_entities[3].properties[2]);

  /// see [Sense.antonym]
  static final antonym =
      QueryStringVectorProperty<Sense>(_entities[3].properties[3]);

  /// see [Sense.field]
  static final field =
      QueryStringVectorProperty<Sense>(_entities[3].properties[4]);

  /// see [Sense.dialect]
  static final dialect =
      QueryStringVectorProperty<Sense>(_entities[3].properties[5]);

  /// see [Sense.misc]
  static final misc =
      QueryStringVectorProperty<Sense>(_entities[3].properties[6]);

  /// see [Sense.info]
  static final info =
      QueryStringVectorProperty<Sense>(_entities[3].properties[7]);

  /// see [Sense.stagk]
  static final stagk =
      QueryStringVectorProperty<Sense>(_entities[3].properties[8]);

  /// see [Sense.stagr]
  static final stagr =
      QueryStringVectorProperty<Sense>(_entities[3].properties[9]);

  /// see [Sense.gloss]
  static final gloss =
      QueryRelationToMany<Sense, Gloss>(_entities[3].relations[0]);
}

/// [WordEntry] entity fields to define ObjectBox queries.
class WordEntry_ {
  /// see [WordEntry.id]
  static final id = QueryIntegerProperty<WordEntry>(_entities[4].properties[0]);

  /// see [WordEntry.kanji]
  static final kanji =
      QueryRelationToMany<WordEntry, Kanji>(_entities[4].relations[0]);

  /// see [WordEntry.reading]
  static final reading =
      QueryRelationToMany<WordEntry, Reading>(_entities[4].relations[1]);

  /// see [WordEntry.sense]
  static final sense =
      QueryRelationToMany<WordEntry, Sense>(_entities[4].relations[2]);
}
