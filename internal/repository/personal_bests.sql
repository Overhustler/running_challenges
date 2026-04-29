-- name: UpsertPersonalBests :one
INSERT INTO personal_bests(user_id, category, duration_seconds)
VALUES(
    $1,
    $2,
    $3
)
ON CONFLICT (user_id, category)
DO UPDATE SET duration_seconds = $3
RETURNING *;

-- name: GetPersonBestByCategory :one
SELECT * FROM personal_bests
WHERE user_id = $1
AND category = $2;

-- name: GetAllPersonalBests :many
SELECT * FROM personal_bests
WHERE user_id = $1;


