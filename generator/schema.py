from peewee import SqliteDatabase, Model, TextField, BooleanField, IntegerField, ForeignKeyField, CompositeKey, \
    PrimaryKeyField

db = SqliteDatabase("database.db", pragmas={'journal_mode': 'wal', 'synchronous': 0, 'locking_mode': 'exclusive'})


class BaseTable(Model):
    class Meta:
        database = db


class Word(BaseTable):
    word_id = IntegerField(primary_key=True)


class Tag(BaseTable):
    tag_id = PrimaryKeyField()
    text = TextField()
    description = TextField()


class Kanji(BaseTable):
    kanji_id = PrimaryKeyField()
    text = TextField(null=True, index=True)
    common = BooleanField()
    word = ForeignKeyField(Word, backref='kanji', null=True)


class Reading(BaseTable):
    reading_id = PrimaryKeyField()
    text = TextField(index=True)
    common = BooleanField()
    word = ForeignKeyField(Word, backref='reading', null=True)


class KanjiInfo(BaseTable):
    kanji_id = ForeignKeyField(Kanji)
    tag_id = ForeignKeyField(Tag)

    class Meta:
        primary_key = CompositeKey('kanji_id', 'tag_id')
        db_table = 'kanji_info'


class ReadingInfo(BaseTable):
    reading_id = ForeignKeyField(Reading)
    tag_id = ForeignKeyField(Tag)

    class Meta:
        primary_key = CompositeKey('reading_id', 'tag_id')
        db_table = 'reading_info'


class ReadingRestrictedTo(BaseTable):
    reading_id = ForeignKeyField(Reading)
    kanji_id = ForeignKeyField(Kanji)

    class Meta:
        primary_key = CompositeKey('reading_id', 'kanji_id')
        db_table = 'reading_restrictedto'