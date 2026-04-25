-- name: create_user :one 
INSERT INTO users (username, first_name, last_name, email, hashed_password)
VALUES(
    $1,
    $2,
    $3,
    $4,
    $5
) RETURNING *;

-- name: get_user_by_id :one
SELECT *
FROM users
WHERE id = $1;

-- name: get_user_by_email :one
SELECT *
FROM users
WHERE email = $1;

-- name: get_user_by_username :one
SELECT *
FROM users
WHERE username = $1;

-- name: update_email :one
UPDATE users
SET email = $1
WHERE id = $2
RETURNING *;
-- name: update_password :one
UPDATE users
SET hashed_password = $1
WHERE id = $2
RETURNING *;
-- name: delete_user :exec
DELETE FROM users
WHERE id = $1;