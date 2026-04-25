-- +goose Up
CREATE TABLE runs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    distance NUMERIC(6,2) NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    perceived_effort INT NOT NULL CHECK (perceived_effort BETWEEN 1 AND 10),
    notes VARCHAR, 
    user_id UUID  NOT NULL REFERENCES users(id) ON DELETE CASCADE
);

-- +goose Down
DROP TABLE IF EXISTS runs;