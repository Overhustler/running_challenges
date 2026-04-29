-- name: create_challenge :one
INSERT INTO challenges(name, description, goal_km, ends_at, created_by)
VALUES(
    $1,
    $2,
    $3,
    $4,
    $5
) RETURNING *;

-- name: GetChallengeByID :one
SELECT * FROM challenges
WHERE id = $1;

-- name: GetAllActiveChallenges :many
SELECT * FROM challenges
WHERE is_active = TRUE;

-- name: GetChallengesEndingBefore :many
SELECT * FROM challenges
WHERE is_active = TRUE AND start_at >= NOW() AND ends_at <= $1;

-- name: GetChallengesCreatedByUserID :many
SELECT * FROM challenges
WHERE created_by = $1
ORDER BY start_at DESC;

-- name: DeleteChallenge :exec
DELETE FROM challenges 
WHERE id = $1;

-- name: EndChallenge :one
UPDATE challenges
SET is_active = FALSE
WHERE id = $1
RETURNING *;

-- name: UpdateDescription :one
UPDATE challenges
SET description = $1
WHERE id = $2
RETURNING *;