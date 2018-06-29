package main

import (
	"log"
	"net/http"
	"tulip/method"

	_ "github.com/go-sql-driver/mysql"
	"github.com/jmoiron/sqlx"
)

func main() {
	cfg, err := method.GetConfig()
	if err != nil {
		log.Fatal(err)
	}
	db, err := sqlx.Open("mysql", cfg.Databases.MySQL)
	if err != nil {
		log.Fatal(err)
	}
	s := cfg.NewService(db)
	http.HandleFunc("/v1/gene", s.GivenGene)
	//http.Handle("/home/", http.FileServer(http.Dir("static/ui")))
	http.Handle("/", http.FileServer(http.Dir("static/ui")))
	log.Printf("Test Gene on http://localhost:8010/v1/gene?gene=DMD")
	err = http.ListenAndServe(":8010", nil) //设置监听的端口
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
	log.Printf("Running Server on http://localhost:8010")
	select {}
}
