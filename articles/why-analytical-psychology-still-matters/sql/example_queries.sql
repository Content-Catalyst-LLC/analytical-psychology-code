-- Example queries for the synthetic conceptual schema.

SELECT
    tradition_type,
    AVG(contemporary_relevance) AS mean_relevance,
    AVG(depth_psychological_need) AS mean_depth_need
FROM symbolic_relevance_scores
GROUP BY tradition_type
ORDER BY mean_relevance DESC;

SELECT
    tradition_type,
    contemporary_relevance,
    depth_psychological_need
FROM symbolic_relevance_scores
WHERE contemporary_relevance > depth_psychological_need
ORDER BY contemporary_relevance DESC;
