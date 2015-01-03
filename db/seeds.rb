# -------------------------------------------------------------------------
# Tags
# -------------------------------------------------------------------------
progressive = Tag.create name: 'Progressive'
pop = Tag.create name: 'Pop'
rock = Tag.create name: 'Rock'


# -------------------------------------------------------------------------
# Karaokes
# -------------------------------------------------------------------------
karaoke_1 = Karaoke.create title:'Hello1', youtube_id: '1', tags: [progressive]
karaoke_2 = Karaoke.create title:'Hello2', youtube_id: '2', tags: [pop]
karaoke_3 = Karaoke.create title:'Hello3', youtube_id: '3', tags: [rock]
