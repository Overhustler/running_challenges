-- name: CreateUser :one
INSERT INTO users (username, first_name, last_name, email, hashed_password)
VALUES(
    $1,
    $2,
    $3,
    $4,
    $5
) RETURNING *;

-- name: GetUserByID :one
SELECT *
FROM users
WHERE id = $1;

-- name: GetUserByEmail :one
SELECT *
FROM users
WHERE email = $1;

-- name: GetUserByUsername :one
SELECT *
FROM users
WHERE username = $1;

-- name: UpdateEmail :one
UPDATE users
SET email = $1
WHERE id = $2
RETURNING *;
-- name: UpdatePassword :one
UPDATE users
SET hashed_password = $1
WHERE id = $2
RETURNING *;
-- name: DeleteUser :exec
DELETE FROM users
WHERE id = $1;