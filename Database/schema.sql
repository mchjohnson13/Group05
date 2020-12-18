CREATE TABLE game_title_genre (
    game_title varchar(100) NOT NULL,
    game_genre varchar(20) NOT NULL,
    PRIMARY KEY (game_title)
);

CREATE TABLE game_platform_release (
    game_title varchar(100) NOT NULL,
    game_platform varchar(10) NOT NULL,
    game_publisher varchar(50) NOT NULL,
    game_developer varchar NOT NULL,
    maturity_rating varchar(5) NOT NULL,
    player_number varchar(30) NOT NULL,
    release_date varchar NOT NULL,
    release_year float NOT NULL,
    release_month float NOT NULL,
    is_handheld varchar(5) NOT NULL,
    is_retro varchar(5) NOT NULL,
    is_depricated varchar(5) NOT NULL,
    FOREIGN KEY (game_title) REFERENCES game_title_genre (game_title),
    PRIMARY KEY (game_title, game_platform)
);

CREATE TABLE game_platform_ratings (
    game_title varchar(100) NOT NULL,
    game_platform varchar(10) NOT NULL,
    user_score float NOT NULL,
    user_positive float NOT NULL,
    user_neutral float NOT NULL,
    user_negative float NOT NULL,
    critics_metascore float NOT NULL,
    critics_positive float NOT NULL,
    critics_neutral float NOT NULL,
    critics_negative float NOT NULL,
    FOREIGN KEY (game_title, game_platform) REFERENCES game_platform_release (game_title, game_platform)
);

CREATE TABLE game_platform_sales (
    game_title varchar(100) NOT NULL,
    game_platform varchar(10) NOT NULL,
    sales_NA float NOT NULL,
    sales_EU float NOT NULL,
    sales_JP float NOT NULL,
    sales_other float NOT NULL,
    sales_global float NOT NULL,
    FOREIGN KEY (game_title, game_platform) REFERENCES game_platform_release (game_title, game_platform)    
);

CREATE TABLE game_platform_reviews (
    review_ID serial PRIMARY KEY,
    game_title varchar(100) NOT NULL,
    game_platform varchar(10) NOT NULL,
    critic_name varchar(50),
    critic_score float NOT NULL,
    critic_review_summary varchar NOT NULL,
    FOREIGN KEY (game_title, game_platform) REFERENCES game_platform_release (game_title, game_platform)    
);