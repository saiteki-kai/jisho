import json
from schema import *
from tqdm import tqdm


def load_tags():
    with open('./data/tags.json') as f:
        data = json.load(f)
        for key, value in data.items():
            Tag.create(text=key, description=value)


def load_words():
    with open('./data/words.json') as f:
        data = json.load(f)

    for entry in tqdm(data, total=len(data)):
        word_id = int(entry["ent_seq"][0])
        Word.create(word_id=word_id)

        kanji_ids = {}

        if "k_ele" in entry:
            for k_ele in entry["k_ele"]:
                common = False

                if "ke_pri" in k_ele:
                    ke_pri = k_ele["ke_pri"]
                    if ke_pri is not None and isinstance(ke_pri, list):
                        common = len(ke_pri) > 0

                text = k_ele["keb"][0]
                kanji = Kanji.create(text=text, common=common, word=word_id)
                kanji_ids[text] = kanji.kanji_id

                if "ke_inf" in k_ele:
                    for tag in k_ele["ke_inf"]:
                        tag_id = Tag.get(Tag.text == tag).tag_id
                        KanjiInfo.create(kanji_id=kanji.kanji_id, tag_id=tag_id)

        for r_ele in entry["r_ele"]:
            common = False
            if "re_pri" in r_ele:
                re_pri = r_ele["re_pri"]
                if re_pri is not None and isinstance(re_pri, list):
                    common = len(re_pri) > 0

            text = r_ele["reb"][0]
            reading = Reading.create(text=text, common=common, word=word_id)

            if "re_inf" in r_ele:
                for tag in r_ele["re_inf"]:
                    tag_id = Tag.get(Tag.text == tag).tag_id
                    ReadingInfo.create(reading_id=reading.reading_id, tag_id=tag_id)

            if "re_restr" in r_ele:
                for k in r_ele["re_restr"]:
                    pass
                    # TODO: decide how to store this

