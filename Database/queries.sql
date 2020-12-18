-- Join game_platform_release and game_platform_ratings and game_platform_sales and game_title_genre
SELECT release.game_title, 
    release.game_platform,
    gg.game_genre,
    release.game_publisher,
    release.game_developer,
    release.maturity_rating,
    release.player_number,
    release.release_date,
    release.release_year,
    release.release_month,
    release.is_handheld,
    release.is_retro,
    release.is_depricated,
    ratings.user_score,
    ratings.user_positive,
    ratings.user_neutral,
    ratings.user_negative,
    ratings.critics_metascore,
    ratings.critics_positive,
    ratings.critics_neutral,
    ratings.critics_negative,
    sales.sales_NA,
    sales.sales_EU,
    sales.sales_JP,
    sales.sales_other,
    sales.sales_global

    FROM game_title_genre as gg
    LEFT JOIN game_platform_release as release
    ON gg.game_title = release.game_title
    LEFT JOIN game_platform_ratings as ratings
    ON (release.game_title, release.game_platform) = (ratings.game_title, ratings.game_platform)
    LEFT JOIN game_platform_sales as sales
    ON (release.game_title, release.game_platform) = (sales.game_title, sales.game_platform);

-- Join game_platform_sales with game_platform_reviews
SELECT release.game_title, 
    release.game_platform,
    sales.sales_NA,
    sales.sales_EU,
    sales.sales_JP,
    sales.sales_other,
    sales.sales_global,
    reviews.critic_name,
    reviews.critic_score,
    reviews.critic_review_summary
    FROM game_platform_release as release
    LEFT JOIN game_platform_sales as sales
    ON (release.game_title, release.game_platform) = (sales.game_title, sales.game_platform)
    LEFT JOIN game_platform_reviews as reviews
    ON (release.game_title, release.game_platform) = (reviews.game_title, reviews.game_platform);

-- Join game_platform_sales with game_platform_reviews group by and count total reviews
SELECT release.game_title, 
    release.game_platform,
    sales.sales_NA,
    sales.sales_EU,
    sales.sales_JP,
    sales.sales_other,
    sales.sales_global,
    COUNT(reviews.critic_name) AS "total_reviews",
    FROM game_platform_release as release
    LEFT JOIN game_platform_sales as sales
    ON (release.game_title, release.game_platform) = (sales.game_title, sales.game_platform)
    LEFT JOIN game_platform_reviews as reviews
    ON (release.game_title, release.game_platform) = (reviews.game_title, reviews.game_platform)
    GROUP BY release.game_title, release.game_platform, sales.sales_NA, sales.sales_EU, sales.sales_JP, sales.sales_other, sales.sales_global;