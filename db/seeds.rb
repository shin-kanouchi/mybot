# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Topic.where(topic_name: "ご飯").first_or_create
Topic.where(topic_name: "運動").first_or_create
Topic.where(topic_name: "旅行").first_or_create
Topic.where(topic_name: "自由").first_or_create

Sentence.where(sentence: "甘いお菓子が好き", source_flag: "3", topic_id: "1").first_or_create
Sentence.where(sentence: "お腹がすきました", source_flag: "3", topic_id: "1").first_or_create
Sentence.where(sentence: "お寿司が食べたいです", source_flag: "3", topic_id: "1").first_or_create
Sentence.where(sentence: "お肉が食べたいです", source_flag: "3", topic_id: "1").first_or_create
Sentence.where(sentence: "おやつが食べたいです", source_flag: "3", topic_id: "1").first_or_create
Sentence.where(sentence: "和菓子は高いですね", source_flag: "3", topic_id: "1").first_or_create
Sentence.where(sentence: "グリーンカレー美味しかった", source_flag: "3", topic_id: "1").first_or_create
Sentence.where(sentence: "やっぱりカレーは豚肉かな", source_flag: "3", topic_id: "1").first_or_create
Sentence.where(sentence: "激辛カレー食べたい", source_flag: "3", topic_id: "1").first_or_create
Sentence.where(sentence: "カレーは正義", source_flag: "3", topic_id: "1").first_or_create
Sentence.where(sentence: "カレードリア食べてみたい", source_flag: "3", topic_id: "1").first_or_create
Sentence.where(sentence: "レトルトカレー美味しい〜", source_flag: "3", topic_id: "1").first_or_create
Sentence.where(sentence: "カレーは寝かせるもんだよ？", source_flag: "3", topic_id: "1").first_or_create
Sentence.where(sentence: "お洒落なラーメンやって何？！", source_flag: "3", topic_id: "1").first_or_create
Sentence.where(sentence: "ラーメンにニンニクは入れない派", source_flag: "3", topic_id: "1").first_or_create
Sentence.where(sentence: "暖かいもの食べたい", source_flag: "3", topic_id: "1").first_or_create
Sentence.where(sentence: "一人ラーメンわず", source_flag: "3", topic_id: "1").first_or_create
Sentence.where(sentence: "ラーメンいこう", source_flag: "3", topic_id: "1").first_or_create
Sentence.where(sentence: "ラーメンの中毒性は異常", source_flag: "3", topic_id: "1").first_or_create
Sentence.where(sentence: "アサリラーメンにハマってます", source_flag: "3", topic_id: "1").first_or_create
Sentence.where(sentence: "〆のラーメンっていいよね", source_flag: "3", topic_id: "1").first_or_create
Sentence.where(sentence: "ラーメン奢って", source_flag: "3", topic_id: "1").first_or_create
Sentence.where(sentence: "塩ラーメン食べたい", source_flag: "3", topic_id: "1").first_or_create
Sentence.where(sentence: "豚骨ラーメン食べたい", source_flag: "3", topic_id: "1").first_or_create
Sentence.where(sentence: "ラーメン屋でチャーハン食べた", source_flag: "3", topic_id: "1").first_or_create
Sentence.where(sentence: "ラーメンが命なので", source_flag: "3", topic_id: "1").first_or_create
Sentence.where(sentence: "得意な料理は何ですか？", source_flag: "3", topic_id: "1").first_or_create
Sentence.where(sentence: "好きな料理は何ですか？", source_flag: "3", topic_id: "1").first_or_create
Sentence.where(sentence: "好きなスポーツは？", source_flag: "3", topic_id: "2").first_or_create
Sentence.where(sentence: "サッカーは好きですか？", source_flag: "3", topic_id: "2").first_or_create
Sentence.where(sentence: "野球は好きですか？", source_flag: "3", topic_id: "2").first_or_create
Sentence.where(sentence: "バスケは好きですか？", source_flag: "3", topic_id: "2").first_or_create
Sentence.where(sentence: "サッカーしたいね", source_flag: "3", topic_id: "2").first_or_create
Sentence.where(sentence: "ダーツが得意です", source_flag: "3", topic_id: "2").first_or_create
Sentence.where(sentence: "海外行きたいですね", source_flag: "3", topic_id: "3").first_or_create
Sentence.where(sentence: "沖縄の海は綺麗ですよね", source_flag: "3", topic_id: "3").first_or_create
Sentence.where(sentence: "沖縄って雨が多くない？", source_flag: "3", topic_id: "3").first_or_create
Sentence.where(sentence: "ジンギスカンが食べたいです", source_flag: "3", topic_id: "3").first_or_create
Sentence.where(sentence: "温泉っていいですよね", source_flag: "3", topic_id: "3").first_or_create
Sentence.where(sentence: "温泉に入ってのんびりしたいですね", source_flag: "3", topic_id: "3").first_or_create
Sentence.where(sentence: "登山は命がけって言いますよね", source_flag: "3", topic_id: "3").first_or_create
Sentence.where(sentence: "登山は好きですか？", source_flag: "3", topic_id: "3").first_or_create
Sentence.where(sentence: "海へ行きたいです", source_flag: "3", topic_id: "3").first_or_create
Sentence.where(sentence: "こんにちは", source_flag: "3", topic_id: "4").first_or_create
Sentence.where(sentence: "元気ですか？", source_flag: "3", topic_id: "4").first_or_create
Sentence.where(sentence: "お話しませんか", source_flag: "3", topic_id: "4").first_or_create
Sentence.where(sentence: "お疲れ様です", source_flag: "3", topic_id: "4").first_or_create
Sentence.where(sentence: "どうかしました？", source_flag: "3", topic_id: "4").first_or_create
Sentence.where(sentence: "調子はどうですか？", source_flag: "3", topic_id: "4").first_or_create
Sentence.where(sentence: "趣味はなんですか？", source_flag: "3", topic_id: "4").first_or_create
Sentence.where(sentence: "何をしていますか？", source_flag: "3", topic_id: "4").first_or_create
Sentence.where(sentence: "仕事はどうですか？", source_flag: "3", topic_id: "4").first_or_create
Sentence.where(sentence: "休日は何をしていますか？", source_flag: "3", topic_id: "4").first_or_create
Sentence.where(sentence: "旅行は好きですか？", source_flag: "3", topic_id: "4").first_or_create
Sentence.where(sentence: "眠いです", source_flag: "3", topic_id: "4").first_or_create
Sentence.where(sentence: "今日は眠たいですね", source_flag: "3", topic_id: "4").first_or_create
Sentence.where(sentence: "休憩ですか？", source_flag: "3", topic_id: "4").first_or_create
Sentence.where(sentence: "今日も疲れましたね", source_flag: "3", topic_id: "4").first_or_create
Sentence.where(sentence: "進捗どうですか", source_flag: "3", topic_id: "4").first_or_create
Sentence.where(sentence: "進捗ありません", source_flag: "3", topic_id: "4").first_or_create
Sentence.where(sentence: "仕事はもういいんですか？", source_flag: "3", topic_id: "4").first_or_create
Sentence.where(sentence: "息してますか？", source_flag: "3", topic_id: "4").first_or_create
