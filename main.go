package main

import (
	"log"
	"net/http"
	"os"
	"path/filepath"

	"github.com/BurntSushi/toml"
	_ "github.com/go-sql-driver/mysql"
	"github.com/jmoiron/sqlx"
)

func main() {
	cfg, err := getConfig()
	if err != nil {
		log.Fatal(err)
	}
	db, err := sqlx.Open("mysql", cfg.Databases.MySQL)
	if err != nil {
		log.Fatal(err)
	}
	s := Service{
		db:  db,
		cfg: cfg,
	}
	http.HandleFunc("/v1/gene", s.givenGene)
	log.Printf("Test Gene on http://localhost:8002/v1/gene?gene=DMD")
	err = http.ListenAndServe(":8002", nil) //设置监听的端口
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
	log.Printf("Running Server on http://localhost:8002")
	select {}
}

type Service struct {
	cfg *Config
	db  *sqlx.DB
}

// Config  configure file for application
type Config struct {
	Application string `toml:"application"`
	Databases   struct {
		MySQL string `toml:"mysql"`
	} `toml:"databases"`
	Hg          string `toml:"hg"`
	RefGeneSQL  string `toml:"sql"`
	RefGeneData string `toml:"data"`
}

// getConfig  Extract configure information from .toml
func getConfig() (cfg *Config, err error) {
	dir, err := filepath.Abs(filepath.Dir(os.Args[0]))
	if err != nil {
		log.Fatal(err)
	}
	_, err = toml.DecodeFile(dir+"/config.toml", &cfg)
	return
}
