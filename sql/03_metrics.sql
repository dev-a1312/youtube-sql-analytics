WITH base AS (
  SELECT
    *,
    (likes + total_comments)::FLOAT / NULLIF(views, 0) AS engagement_rate,
    total_comments::FLOAT / NULLIF(views, 0) AS comment_intensity
  FROM base_videos
)

SELECT
  channel_title,
  COUNT(*) AS video_count,
  AVG(engagement_rate) AS avg_engagement_rate,
  PERCENTILE_CONT(0.95) 
    WITHIN GROUP (ORDER BY engagement_rate) AS p95_engagement_rate
FROM base
GROUP BY channel_title
HAVING COUNT(*) >= 5;
