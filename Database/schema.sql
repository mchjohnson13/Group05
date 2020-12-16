CREATE TABLE "Games" (
    "Name" Varchar   NOT NULL,
    "Platform" Varchar   NOT NULL,
    "Publisher" Varchar   NOT NULL,
    "developer" Varchar   NOT NULL,
    "maturity_rating" Varchar   NOT NULL,
    "number_players" Varchar   NOT NULL,
    CONSTRAINT "pk_Games" PRIMARY KEY (
        "Name","Platform"
     )
);

CREATE TABLE "Game_genre" (
    "Name" Varchar   NOT NULL,
    "Genre" Varchar   NOT NULL,
    CONSTRAINT "pk_Game_genre" PRIMARY KEY (
        "Name"
     )
);

CREATE TABLE "Sales" (
    "Name" Varchar   NOT NULL,
    "Platform" Varchar   NOT NULL,
    "NA_Sales" Float   NOT NULL,
    "EU_Sales" Float   NOT NULL,
    "JP_Sales" Float   NOT NULL,
    "Other_Sales" Float   NOT NULL,
    "Global_Sales" Float   NOT NULL,
    CONSTRAINT "pk_Sales" PRIMARY KEY (
        "Name","Platform"
     )
);

CREATE TABLE "Ratings" (
    "Name" Varchar   NOT NULL,
    "Platform" Varchar   NOT NULL,
    "user_score" Float   NOT NULL,
    "positive_users" Float   NOT NULL,
    "neutral_users" Float   NOT NULL,
    "negative_users" Float   NOT NULL,
    "metascore" Float   NOT NULL,
    "positive_critics" Float   NOT NULL,
    "neutral_critics" Float   NOT NULL,
    "negative_critics" Float   NOT NULL,
    CONSTRAINT "pk_Ratings" PRIMARY KEY (
        "Name","Platform"
     )
);

CREATE TABLE "Reviews" (
    "Name" Varchar   NOT NULL,
    "Platform" Varchar   NOT NULL,
    "metacritic_score" Float   NOT NULL,
    "Num_of_comments" Int   NOT NULL,
    "review" Varchar   NOT NULL,
    CONSTRAINT "pk_Reviews" PRIMARY KEY (
        "Name","Platform"
     )
);

CREATE TABLE "release_platform" (
    "Name" Varchar   NOT NULL,
    "Platform" Varchar   NOT NULL,
    "Publisher" Varchar   NOT NULL,
    "release_date" Varchar   NOT NULL,
    "release_year" Varchar   NOT NULL,
    "release_month" Varchar   NOT NULL,
    "is_handheld" Varchar   NOT NULL,
    "is_retro" Varchar   NOT NULL,
    "is_depricated" Varchar   NOT NULL,
    CONSTRAINT "pk_release_platform" PRIMARY KEY (
        "Name","Platform"
     )
);

ALTER TABLE "Games" ADD CONSTRAINT "fk_Games_Name_Platform" FOREIGN KEY("Name", "Platform")
REFERENCES "release_platform" ("Name", "Platform");

ALTER TABLE "Sales" ADD CONSTRAINT "fk_Sales_Name_Platform" FOREIGN KEY("Name", "Platform")
REFERENCES "release_platform" ("Name", "Platform");

ALTER TABLE "Ratings" ADD CONSTRAINT "fk_Ratings_Name_Platform" FOREIGN KEY("Name", "Platform")
REFERENCES "Games" ("Name", "Platform");

ALTER TABLE "Reviews" ADD CONSTRAINT "fk_Reviews_Name_Platform" FOREIGN KEY("Name", "Platform")
REFERENCES "Ratings" ("Name", "Platform");

ALTER TABLE "release_platform" ADD CONSTRAINT "fk_release_platform_Name" FOREIGN KEY("Name")
REFERENCES "Game_genre" ("Name");