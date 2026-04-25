-- +goose Up
ALTER TABLE challenges
ADD COLUMN is_active BOOLEAN NOT NULL DEFAULT TRUE;


-- +goose Down
ALTER TABLE challenges DROP COLUMN is_active;
