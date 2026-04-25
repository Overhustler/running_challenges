-- +goose Up
CREATE TABLE challenge_members(
    challenge_id UUID NOT NULL REFERENCES challenges(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    PRIMARY KEY (challenge_id, user_id)
);

-- +goose Down
DROP TABLE IF EXISTS challenge_members;