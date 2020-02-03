drop table if exists photos_users;
drop table if exists articles_photos;
drop table if exists articles_users;
drop table if exists articles;
drop table if exists photos;
drop table if exists users;

CREATE TABLE users(
    id              serial       not null primary key,
    first_name      varchar(50)  not null default '',
    last_name       varchar(50)  not null default '',
    nick_name       varchar(100) not null default '',
    email           varchar(255) not null,
    password_digest text         not null,
    created_at      timestamp    not null default now(),
    updated_at      timestamp    not null default now(),
    CONSTRAINT validate_name CHECK((first_name != '' AND last_name != '') OR nick_name != '')
);

CREATE TABLE articles(
    id serial            not null primary key,
    title varchar(255)   not null default '',
    content text         not null default '',
    created_at timestamp not null default now(),
    updated_at timestamp not null default now()
);

CREATE TABLE photos(
    id         serial       not null primary key,
    url        text         not null default 'http://faceaweek.bettermyths.com/wp-content/uploads/2016/08/stub.jpg',
    title      varchar(200) not null default '',
    is_avatar  boolean      not null default false,
    created_at timestamp    not null default now(),
    updated_at timestamp    not null default now()
    CONSTRAINT photo_url_protocol CHECK (url ILIKE 'http%://%')
);

CREATE TABLE photos_users(
    id       serial not null primary key,
    photo_id bigint not null REFERENCES photos(id) ON DELETE CASCADE,
    user_id  bigint not null REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE (photo_id, user_id)
);

create table articles_users(
    id         serial not null primary key,
    article_id bigint not null REFERENCES articles(id) ON DELETE CASCADE,
    user_id    bigint not null REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE (article_id, user_id)
);

create table articles_photos(
    id         serial not null primary key,
    article_id bigint not null REFERENCES articles(id) ON DELETE CASCADE,
    photo_id   bigint not null REFERENCES photos(id) ON DELETE CASCADE,
    UNIQUE (article_id, photo_id)
);