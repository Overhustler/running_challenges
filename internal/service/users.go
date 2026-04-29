package service

import (
	"context"

	"github.com/jackc/pgx/v5/pgtype"
	"github.com/overhustler/running-challenges/internal/repository/db"
	"golang.org/x/crypto/bcrypt"
)

type UserService struct {
	queries *db.Queries
}

func NewUserService(d *db.Queries) *UserService {
    userService := UserService{queries: d}
	return &userService
}


func(us *UserService)DeleteUser(userID pgtype.UUID) (error){
	err := us.queries.DeleteUser(context.Background(), userID)
	return  err
}

func(us *UserService)UpdateEmail(userID pgtype.UUID, email string) (db.User, error){
	user, err := us.queries.UpdateEmail(context.Background(), db.UpdateEmailParams{Email: email, ID: userID})
	if err != nil{
		return  db.User{}, err
	}
	return user, nil
}

func(us *UserService)UpdatePassword(userID pgtype.UUID, password string) (db.User, error){
	hashed, err := hashPassword(password)
	if err != nil {
		return db.User{}, err
	}
	user, err := us.queries.UpdatePassword(context.Background(), db.UpdatePasswordParams{HashedPassword: hashed, ID: userID})
	if err != nil{
		return  db.User{}, err
	}
	return user, nil
}

func(us *UserService)GetUserByID(userID pgtype.UUID) (db.User, error){
	user, err := us.queries.GetUserByID(context.Background(), userID)
	if err != nil {
		return  db.User{}, err
	}
	return user, nil
}

func(us *UserService)GetUserByUserName(username string) (db.User, error){
	user, err := us.queries.GetUserByUsername(context.Background(), username)
	if err != nil {
		return  db.User{}, err
	}
	return user, nil
}

func(us *UserService)CreateUser(username, firstName, lastName, email, password  string)(db.User, error){
	hashedPassword, err := hashPassword(password)
	if err != nil {
		return db.User{}, err
	}
	user, err := us.queries.CreateUser(context.Background(), 
		db.CreateUserParams{Username: username, FirstName: firstName, LastName: lastName, Email: email, HashedPassword: hashedPassword})
	if err != nil {
		return db.User{}, err
	}
	return user, nil
}

func(us *UserService)Login(email, password string)(db.User, error) {
	user, err := us.queries.GetUserByEmail(context.Background(), email)
	if err != nil {
		return db.User{}, err
	}
	err = checkHashedPassword(password, user.HashedPassword)
	if err != nil {
		return db.User{}, err
	}
	return user, nil
}



func hashPassword(pw string) (string, error){
	 hashedPassword, err := bcrypt.GenerateFromPassword([]byte(pw), bcrypt.DefaultCost)
	if err != nil{
		return "", err
	}
	return string(hashedPassword), nil
}


func checkHashedPassword(pw string, hashed string) error {
	err := bcrypt.CompareHashAndPassword([]byte(hashed), []byte(pw))
    if err != nil {
        return err
	}
	return  nil
}