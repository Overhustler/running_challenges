-- +goose Up
ALTER TABLE challenges
ADD CONSTRAINT unique_name UNIQUE (name);


-- +goose Down
ALTER TABLE challenges 
DROP CONSTRAINT IF EXISTS unique_name;
