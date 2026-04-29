package service

import "github.com/overhustler/running-challenges/internal/repository/db"

type RunService struct {
	queries *db.Queries
}

func NewRunService(q *db.Queries) *RunService {
	rs := RunService{queries: q}
	return &rs
}