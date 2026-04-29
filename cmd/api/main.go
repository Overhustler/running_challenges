package main

import (
	"context"
	"log"
	"os"
	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/joho/godotenv"
	"github.com/overhustler/running-challenges/internal/repository/db"
)

func main() {
	err := godotenv.Load()
	if err != nil {
		log.Fatalf("problem loading env variables: %v", err)
	}
	db_url, exists := os.LookupEnv("DB_URL")

	if !exists {
		log.Fatal("Database url is not set")
	}
	dbPool, err := pgxpool.New(context.Background(), db_url)
	if err != nil {
		log.Fatalf("problem creating database connection: %v", err)
	}
	defer dbPool.Close()
	_ = db.New(dbPool)
	
	log.Println("Connected to database")
}

