-- Comment-level aggregation to video grain
WITH comment_agg AS (
  SELECT
    video_id,
    COUNT(*)                AS total_comments,
    SUM(like_count)         AS total_comment_likes,
    COUNT(DISTINCT comment_id) AS distinct_comments
  FROM comments
  GROUP BY video_id
)

SELECT
  v.video_id,
  v.channel_title,
  v.category_id,
  DATE_TRUNC('day', v.publish_time) AS publish_date,
  v.views,
  v.likes,
  v.comment_count,
  COALESCE(c.total_comments, 0) AS total_comments,
  COALESCE(c.total_comment_likes, 0) AS total_comment_likes
FROM videos_stats v
LEFT JOIN comment_agg c
  ON v.video_id = c.video_id;
