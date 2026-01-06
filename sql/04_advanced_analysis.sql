WITH creator_metrics AS (
  SELECT
    channel_title,
    video_id,
    engagement_rate,
    ROW_NUMBER() OVER (
      PARTITION BY channel_title
      ORDER BY publish_date
    ) AS video_seq
  FROM base_videos
),

lagged AS (
  SELECT
    *,
    LAG(engagement_rate) OVER (
      PARTITION BY channel_title
      ORDER BY video_seq
    ) AS prev_engagement
  FROM creator_metrics
)

SELECT
  channel_title,
  AVG(ABS(engagement_rate - prev_engagement)) AS engagement_volatility
FROM lagged
WHERE prev_engagement IS NOT NULL
GROUP BY channel_title;
