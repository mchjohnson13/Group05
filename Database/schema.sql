CREATE TABLE game_title_genre (
    game_title varchar(100) NOT NULL,
    game_genre varchar(20) NOT NULL,
    PRIMARY KEY (game_title)
);

CREATE TABLE game_platform_release (
    game_title varchar(100) NOT NULL,
    game_platform varchar(10) NOT NULL,
    game_publisher varchar(50),
    game_developer varchar,
    maturity_rating varchar(5),
    player_number varchar(30),
    release_date varchar,
    release_year float,
    release_month float,
    is_handheld varchar(5),
    is_retro varchar(5),
    is_deprecated varchar(5),
    FOREIGN KEY (game_title) REFERENCES game_title_genre (game_title) ON DELETE CASCADE,
    PRIMARY KEY (game_title, game_platform)
);

CREATE TABLE game_platform_ratings (
    game_title varchar(100) NOT NULL,
    game_platform varchar(10) NOT NULL,
    user_score float,
    user_positive float,
    user_neutral float,
    user_negative float,
    critics_metascore float,
    critics_positive float,
    critics_neutral float,
    critics_negative float,
    FOREIGN KEY (game_title, game_platform) REFERENCES game_platform_release (game_title, game_platform) ON DELETE CASCADE
);

CREATE TABLE game_platform_sales (
    game_title varchar(100) NOT NULL,
    game_platform varchar(10) NOT NULL,
    sales_NA float,
    sales_EU float,
    sales_JP float,
    sales_other float,
    sales_global float,
    FOREIGN KEY (game_title, game_platform) REFERENCES game_platform_release (game_title, game_platform) ON DELETE CASCADE    
);

CREATE TABLE game_platform_reviews (
    review_ID serial PRIMARY KEY,
    game_title varchar(100) NOT NULL,
    game_platform varchar(10) NOT NULL,
    critic_name varchar(50),
    critic_score float,
    critic_review_summary varchar,
    FOREIGN KEY (game_title, game_platform) REFERENCES game_platform_release (game_title, game_platform) ON DELETE CASCADE    
);