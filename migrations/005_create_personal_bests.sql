-- +goose Up
CREATE TYPE category_type AS ENUM ('5k', '10k', 'half_marathon', 'marathon');
CREATE TABLE personal_bests(
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    category  category_type NOT NULL,
    duration_seconds INT NOT NULL,
    PRIMARY KEY (user_id, category)
);

-- +goose Down
DROP TABLE IF EXISTS personal_bests;
DROP TYPE IF EXISTS category_type;