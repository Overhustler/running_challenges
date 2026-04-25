-- name: create_challenge :one
INSERT INTO challenges(name, description, goal_km, ends_at, created_by)
VALUES(
    $1,
    $2,
    $3,
    $4,
    $5
) RETURNING *;

-- name: get_challenge_by_id :one
SELECT * FROM challenges
WHERE id = $1;

-- name: get_active_challenges :many
SELECT * FROM challenges
WHERE is_active = TRUE;

-- name: get_challenges_ending_before :many
SELECT * FROM challenges
WHERE is_active = TRUE AND start_at >= NOW() AND ends_at <= $1;

-- name: get_challenges_created_by_user_id :many
SELECT * FROM challenges
WHERE created_by = $1
ORDER BY start_at DESC;

-- name: delete_challenge :exec
DELETE FROM challenges 
WHERE id = $1;

-- name: end_challenge :one
UPDATE challenges
SET is_active = FALSE
WHERE id = $1
RETURNING *;

-- name: update_description :one
UPDATE challenges
SET description = $1
WHERE id = $2
RETURNING *;