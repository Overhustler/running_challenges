-- name: upsert_personal_best :one
INSERT INTO personal_bests(user_id, category, duration_seconds)
VALUES(
    $1,
    $2,
    $3
)
ON CONFLICT (user_id, category)
DO UPDATE SET duration_seconds = $3
RETURNING *;

-- name: get_personal_best_by_category :one
SELECT * FROM personal_bests
WHERE user_id = $1
AND category = $2;

-- name: get_all_personal_bests_for_user :many
SELECT * FROM personal_bests
WHERE user_id = $1;


