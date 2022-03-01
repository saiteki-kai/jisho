import os

from load_data import load_words, load_tags
from schema import *

if __name__ == "__main__":
    if os.path.exists("database.db"):
        os.remove("database.db")

    db.connect()
    db.create_tables([Kanji, Reading, Word, Tag, KanjiInfo, ReadingInfo, ReadingRestrictedTo])

    load_tags()
    load_words()

