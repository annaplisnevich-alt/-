CREATE TABLE boyfriend (
bf_id bigserial PRIMARY KEY,
name varchar(50) NOT NULL,
birth_date timestamp NOT NULL,
telegram_id bigint UNIQUE 
);

CREATE TABLE messages (
telegram_id bigint NOT NULL,
message varchar(100),
FOREIGN KEY (telegram_id) REFERENCES boyfriend(telegram_id)
)

CREATE TABLE date (
date_id bigserial PRIMARY KEY,
bf_id bigint NOT NULL,
when_ timestamp,
FOREIGN KEY (bf_id) REFERENCES boyfriend(bf_id)
);

CREATE TABLE date_details (
details_id bigserial NOT NULL PRIMARY KEY,
bf_id bigint NOT NULL,
date_id bigint NOT NULL,
place varchar(50) NOT NULL,
activity varchar(100),
FOREIGN KEY (bf_id) REFERENCES boyfriend(bf_id),
FOREIGN KEY (date_id) REFERENCES date(date_id)
);

CREATE TABLE gifts (
details_id bigint NOT NULL PRIMARY KEY,
date_id bigint NOT NULL UNIQUE,
gift varchar(100) NOT NULL,
price bigint,
FOREIGN KEY (details_id) REFERENCES date_details(details_id),
FOREIGN KEY (date_id) REFERENCES date(date_id)
);

CREATE TABLE accept (
details_id bigint NOT NULL PRIMARY KEY,
is_liked boolean NOT NULL DEFAULT FALSE,
FOREIGN KEY (details_id) REFERENCES date_details(details_id)
)


