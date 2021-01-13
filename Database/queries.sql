-- Join game_platform_release and game_platform_ratings and game_platform_sales and game_title_genre and create table for ML
SELECT release.game_title AS "Name", 
    release.game_platform AS "Platform",
    gg.game_genre AS "Genre",
    release.game_publisher AS "Publisher",
    sales.sales_NA AS "NA_Sales",
    sales.sales_EU AS "EU_Sales",
    sales.sales_JP AS "JP_Sales",
    sales.sales_other AS "Other_Sales",
    sales.sales_global AS "Global_Sales",
    ratings.critics_metascore AS "metascore",
	ratings.user_score,	
    release.release_date,	
    ratings.critics_positive AS "positive_critics",
    ratings.critics_neutral AS "neutral_critics",
    ratings.critics_negative AS "negative_critics",
    ratings.user_positive AS "positive_users",
    ratings.user_neutral AS "neutral_users",
    ratings.user_negative AS "negative_users",
	release.game_developer AS "developer",
    release.player_number AS "number_players",
    release.maturity_rating AS "rating",
    release.is_handheld,
    release.is_deprecated,
	release.is_retro,
    release.release_year AS "year",
    release.release_month AS "month"
	
	INTO ML_data

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
    COUNT(reviews.critic_name) AS "total_reviews"
    FROM game_platform_release as release
    LEFT JOIN game_platform_sales as sales
    ON (release.game_title, release.game_platform) = (sales.game_title, sales.game_platform)
    LEFT JOIN critic_review_summary as reviews
    ON (release.game_title, release.game_platform) = (reviews.game_title, reviews.game_platform)
    GROUP BY release.game_title, release.game_platform, sales.sales_NA, sales.sales_EU, sales.sales_JP, sales.sales_other, sales.sales_global
	ORDER BY total_reviews DESC;