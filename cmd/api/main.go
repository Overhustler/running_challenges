package main

import (
	"context"
	"log"
	"os"
	"github.com/jackc/pgx/v5"
	"github.com/joho/godotenv"
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
	dbConn, err := pgx.Connect(context.Background(), db_url)
	if err != nil {
		log.Fatalf("problem creating database connection: %v", err)
	}
	defer dbConn.Close(context.Background())
	log.Println("Connected to database")
}

