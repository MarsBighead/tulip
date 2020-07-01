package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"path/filepath"
	"tulip/method"

	_ "github.com/go-sql-driver/mysql"
	"github.com/jmoiron/sqlx"
)

func main() {
	configPath, err := getConfigPath()
	if err != nil {
		log.Fatal(err)
	}

	cfg, err := method.GetConfig(configPath)
	if err != nil {
		log.Fatal(err)
	}
	log.Println(cfg.GetDSN())
	db, err := sqlx.Open("mysql", cfg.GetDSN())
	if err != nil {
		log.Fatal(err)
	}
	err = db.Ping()
	if err != nil {
		log.Fatal(err)
	}
	s := cfg.NewService(db)

	http.HandleFunc("/api/v1/gene", s.GivenGene)
	//http.Handle("/home/", http.FileServer(http.Dir("static/ui")))
	http.Handle("/", http.FileServer(http.Dir("static/ui")))
	log.Printf("Test Gene on http://localhost:" + cfg.HTTP.PORT + "/api/v1/gene?gene=DMD")
	err = http.ListenAndServe(":"+cfg.HTTP.PORT, nil) //设置监听的端口
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
	log.Printf("Running Server on http://localhost:" + cfg.HTTP.PORT)
	select {}
}

func getConfigPath() (string, error) {
	currentPath, _ := os.Getwd()
	dir, _ := filepath.Abs(filepath.Dir(os.Args[0]))

	fmt.Println(dir)

	path := currentPath + "/config.yaml"
	ok, err := isPathExists(path)
	if ok {
		return path, nil
	} else {
		path = dir + "/config.yaml"
		ok, err = isPathExists(path)
		if ok {
			return path, nil
		}
	}
	return "", err
}

func isPathExists(path string) (bool, error) {
	_, err := os.Stat(path)
	if err == nil {
		return true, nil
	}
	if os.IsNotExist(err) {
		return false, nil
	}
	return false, err
}
