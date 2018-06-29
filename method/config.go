package method

import (
	"io/ioutil"
	"log"

	"github.com/jmoiron/sqlx"
	yaml "gopkg.in/yaml.v2"
)

//Service  for connect db and other components
type Service struct {
	cfg *Config
	db  *sqlx.DB
}

//NewService build service data struct
func (cfg *Config) NewService(db *sqlx.DB) *Service {
	return &Service{
		db:  db,
		cfg: cfg,
	}
}

// GetConfig  Extract configure information from .toml
func GetConfig(file string) (cfg *Config, err error) {

	body, err := ioutil.ReadFile(file)
	if err != nil {
		log.Fatal(err)
	}
	cfg = new(Config)
	err = yaml.Unmarshal(body, cfg)
	if err != nil {
		log.Fatal(err)
	}
	return
}
