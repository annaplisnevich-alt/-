CREATE TABLE boyfriend (
bf_id bigserial PRIMARY KEY,
name varchar(50) NOT NULL,
birth_date timestamp NOT NULL,
score_id bigint not null unique,
bank_loan bigint not null 
);

create table matches (
score_id bigint primary key,
form_score int,
date_score int,
act_score int,
gift_score int,
interest_score int,
total_score    int GENERATED ALWAYS AS (
        COALESCE(date_score, 0) +
        COALESCE(act_score, 0) +
        COALESCE(form_score, 0) +
        COALESCE(interest_score, 0) +
        COALESCE(gift_score, 0)
    ) stored,
foreign key (score_id) references boyfriend(score_id)
)

CREATE TABLE date (
date_id bigint PRIMARY KEY,
bf_id bigint NOT NULL,
when_ timestamp,
FOREIGN KEY (bf_id) REFERENCES boyfriend(bf_id)
);

CREATE TABLE date_details (
details_id bigint NOT NULL PRIMARY KEY,
bf_id bigint NOT NULL,
date_id bigint NOT NULL,
place text NOT NULL,
activity text,
FOREIGN KEY (date_id) REFERENCES date(date_id)
);

CREATE TABLE gifts (
details_id bigint NOT NULL PRIMARY KEY,
date_id bigint NOT NULL UNIQUE,
gift text NOT NULL,
price bigint,
FOREIGN KEY (details_id) REFERENCES date_details(details_id)
);

CREATE TABLE accept (
details_id bigint NOT NULL PRIMARY KEY,
is_liked boolean NOT NULL DEFAULT FALSE,
FOREIGN KEY (details_id) REFERENCES date_details(details_id)
);