-- name: JoinChallenge :one
INSERT INTO challenge_members(challenge_id, user_id)
VALUES(
    $1,
    $2
) RETURNING *;

-- name: GetUserChallenge :many
SELECT * FROM challenge_members
WHERE user_id = $1;

-- name: GetAlllCHallengesMembers :many
SELECT * FROM challenge_members
WHERE challenge_id = $1;

-- name: GetLeaderBoard :many
SELECT cm.user_id, SUM(r.distance) AS total_km
FROM challenge_members AS cm
JOIN runs AS r ON cm.user_id = r.user_id
JOIN challenges AS c ON cm.challenge_id = c.id
WHERE cm.challenge_id = $1
AND r.start_time BETWEEN c.start_at AND c.ends_at
GROUP BY cm.user_id
ORDER BY total_km DESC
LIMIT $2;

-- name: LeaveChallenge :exec
DELETE FROM challenge_members
WHERE user_id = $1 AND challenge_id = $2;
