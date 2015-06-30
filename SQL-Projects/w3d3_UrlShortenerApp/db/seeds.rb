# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

c = User.create(email: "hi@google.com")
d = User.create(email: "hi@yahoo.com")
TagTopic.create(topic: 'Sports')
TagTopic.create(topic: 'Finance')
TagTopic.create(topic: 'Leisure')
TagTopic.create(topic: 'Drugs')
z1 = ShortenedUrl.create_for_user_and_long_url!(c, 'http://google.com')
z2 = ShortenedUrl.create_for_user_and_long_url!(c, 'http://facebook.com')
Visit.record_visit!(c, z1)
Visit.record_visit!(c, z2)
Visit.record_visit!(d, z2)
Tagging.create(tag_topic_id: 1, shortened_url_id: 1)
Tagging.create(tag_topic_id: 1, shortened_url_id: 2)
Tagging.create(tag_topic_id: 2, shortened_url_id: 2)
