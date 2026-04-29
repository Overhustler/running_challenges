-- name: CreateRun :one
INSERT INTO runs(distance, start_time, end_time, perceived_effort, notes, user_id)
VALUES(
    $1,
    $2,
    $3,
    $4,
    $5,
    $6
) RETURNING *;

-- name: GetRun :one
SELECT * FROM runs
WHERE id = $1;

-- name: GetRunsByUserID :many
SELECT * FROM runs
where user_id = $1;

-- name: GetRunsForDateRange :many
SELECT * FROM runs
WHERE start_time BETWEEN $1 AND $2 
ORDER BY start_time DESC;

-- name: GetRecentRuns :many
SELECT * FROM runs 
WHERE start_time > $1
ORDER BY start_time DESC
LIMIT $2;

-- name: GetRunsByDateRangeUserID :many
SELECT * FROM runs
WHERE (start_time BETWEEN $1 AND $2) 
AND user_id = $3 
ORDER BY start_time DESC;

-- name: GetRecentRunsUserID :many
SELECT * FROM runs 
WHERE start_time > $1 AND user_id = $2
ORDER BY start_time DESC
LIMIT $3;

-- name: get_runs_by_distance_range :many
SELECT * FROM runs
WHERE distance BETWEEN $1 AND $2
ORDER BY distance ASC;

-- name: get_runs_by_distance_range_for_user :many
SELECT * FROM runs
WHERE (distance BETWEEN $1 AND $2)
AND user_id = $3
ORDER BY distance ASC;

-- name: update_notes :one
UPDATE runs
SET notes = $1
WHERE id = $2
RETURNING *;

-- name: update_effort :one
UPDATE runs
SET perceived_effort = $1
WHERE id = $2
RETURNING *;

-- name: delete_run :exec
DELETE FROM runs
WHERE id = $1;

