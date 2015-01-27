# -------------------------------------------------------------------------
# Tags
# -------------------------------------------------------------------------
progressive = Tag.create name: 'Progressive'
pop = Tag.create name: 'Pop'
rock = Tag.create name: 'Rock'


# -------------------------------------------------------------------------
# Karaokes
# -------------------------------------------------------------------------
karaoke_1 = Karaoke.create title:'Hello1', youtube_id: '1', tags: [ progressive, pop, rock ]
karaoke_2 = Karaoke.create title:'Hello2', youtube_id: '2', tags: [ pop, rock ]
karaoke_3 = Karaoke.create title:'Hello3', youtube_id: '3', tags: [ rock ]
