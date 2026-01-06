-- Join explosion check
SELECT
  COUNT(*) AS joined_rows,
  COUNT(DISTINCT video_id) AS distinct_videos
FROM base_videos;

-- Metric reconciliation
SELECT
  SUM(total_comments) AS sum_comments,
  SUM(comment_count) AS reported_comments
FROM base_videos;
