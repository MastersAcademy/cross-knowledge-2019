INSERT INTO photos_users(user_id, photo_id)
SELECT users.id as user_id, photos.id as photo_id
from users
left join photos ON users.id NOT IN (SELECT user_id FROM photos_users)
order by random()
LIMIT 10000


INSERT INTO articles_users(user_id, article_id)
SELECT users.id as user_id, articles.id as article_id
from users
left join articles ON users.id NOT IN (SELECT user_id FROM articles_users)
order by random()
LIMIT 1000

INSERT INTO articles_photos(article_id, photo_id)
SELECT articles.id as article_id, photos.id as photo_id
from articles
left join photos ON articles.id NOT IN (SELECT article_id FROM articles_photos)
order by random()
LIMIT 2000
