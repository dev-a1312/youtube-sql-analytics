# YouTube Content Performance & Engagement Quality Analytics (Advanced SQL)

## Overview
This project is an end-to-end, production-style analytics case study built using **advanced SQL** on shared YouTube datasets.  
The objective is to move beyond vanity metrics (views, likes) and design **defensible, normalized engagement metrics**, handle ambiguity, ensure data quality, and generate decision-grade insights.

The project is intentionally structured to reflect how analytics is performed at **senior (L7/L8) levels** in large tech organizations.

---

## Business Problems Addressed
The datasets do not come with predefined business questions. The analysis focuses on answering the following ambiguity-driven problems:

1. How do we measure **true engagement quality**, not just reach?
2. Which creators show **consistent performance** versus viral, one-off spikes?
3. How does **comment activity scale with views**, and where does it saturate?
4. Are averages hiding **outliers or skewed distributions**?
5. How does engagement evolve **over time** across content cohorts?

These questions support decisions around:
- Creator prioritization
- Content promotion strategy
- Metric trustworthiness
- Risk detection in performance reporting

---

## Datasets Used
### 1. videos-stats.csv
**Grain:** 1 row per video  
Contains video-level metadata and performance signals such as:
- video_id
- channel_title
- category_id
- publish_time
- views
- likes
- comment_count

### 2. comments.csv
**Grain:** 1 row per comment  
Contains audience interaction data linked to videos:
- comment_id
- video_id
- comment_text
- like_count
- published_at

⚠️ Comments are **pre-aggregated** before joining to videos to prevent join explosion.

---

## Analytical Assumptions & Constraints
- Views are treated as exposure; engagement must be normalized by views.
- Comment-level data may arrive late relative to video publish time.
- Viral outliers can heavily skew averages; percentiles are preferred.
- Zero-view videos are excluded from ratio-based metrics.
- Analysis is video-grain unless explicitly stated otherwise.

---

## Metric Definitions (Explicit & Defensible)

| Metric | Definition |
|------|-----------|
| Engagement Rate | (likes + comments) / views |
| Comment Intensity | comments / views |
| Like-to-View Ratio | likes / views |
| Creator Consistency | Avg absolute change in engagement between consecutive videos |
| P95 Engagement | 95th percentile of engagement rate (distribution-aware benchmark) |

All metrics clearly define:
- Numerator
- Denominator
- Grain
- Edge-case handling (NULLs, zero views)

---

## SQL Techniques Used
This project intentionally demonstrates **senior-level SQL usage**, including:

- Multi-layer CTEs for readability and debuggability
- Pre-aggregation to enforce correct grain
- Complex joins with explosion prevention
- Window functions (ROW_NUMBER, LAG, rolling logic)
- Conditional aggregations
- Percentile-based distribution analysis
- Time-based trend analysis
- Data quality & reconciliation checks

---------

## SQL File Responsibilities

### 01_data_validation.sql
- Row counts & volume sanity checks
- Primary key validation
- Orphan record detection
- Null analysis on critical columns

### 02_base_tables.sql
- Comment pre-aggregation
- Safe joins at video grain
- Creation of analysis-ready base tables

### 03_metrics.sql
- Engagement normalization
- Creator-level aggregations
- Percentile-based benchmarking

### 04_advanced_analysis.sql
- Creator consistency using window functions
- Outlier detection
- Time-series trend analysis
- Churn-style engagement decay patterns

### 05_quality_checks.sql
- Join explosion verification
- Metric reconciliation
- Ongoing data trust checks

---

## Key Insights Enabled
- High view count does not necessarily imply high engagement quality.
- A small subset of creators consistently outperform on normalized engagement.
- Engagement intensity plateaus at scale, indicating diminishing marginal interaction.
- Percentile-based metrics provide more reliable benchmarks than averages.

---

## Failure Modes & Mitigations

| Risk | Mitigation |
|----|-----------|
| Viral outliers skew averages | Percentile-based metrics |
| Late-arriving comments | Decoupled comment aggregation |
| Join explosion | Pre-aggregation before joins |
| Zero views | NULLIF guards |
| Partial ingestion | Reconciliation queries |

---

## Performance & Scalability Considerations
While the dataset is small, the SQL is written with scale in mind:
- Pre-aggregation for large joins
- Partitioning by publish date (conceptually)
- Indexing on video_id
- Materialized base tables for reuse
- Modular queries to support incremental refreshes

---

## Limitations
- No user-level watch-time data
- No sentiment analysis on comments
- No experiment/control flags

---

## Next Steps
- Comment sentiment classification
- Creator cohort analysis
- Watch-time–adjusted engagement metrics
- Experimentation & uplift modeling

---

## Final Note
This project is intentionally designed as an **internal analytics case study**, not a Kaggle-style notebook.
All logic, metrics, and trade-offs are written to be **defended in senior-level interviews**.
