-- Row counts
SELECT COUNT(*) AS video_rows FROM videos_stats;
SELECT COUNT(*) AS comment_rows FROM comments;

-- Primary key validation
SELECT video_id, COUNT(*) 
FROM videos_stats
GROUP BY video_id
HAVING COUNT(*) > 1;

-- Orphan comments (comments without videos)
SELECT COUNT(*) AS orphan_comments
FROM comments c
LEFT JOIN videos_stats v
  ON c.video_id = v.video_id
WHERE v.video_id IS NULL;

-- Null sanity checks
SELECT
  COUNT(*) FILTER (WHERE views IS NULL) AS null_views,
  COUNT(*) FILTER (WHERE likes IS NULL) AS null_likes,
  COUNT(*) FILTER (WHERE comment_count IS NULL) AS null_comment_count
FROM videos_stats;
