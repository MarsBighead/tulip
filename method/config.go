package method

import (
	"log"
	"os"
	"path/filepath"

	"github.com/BurntSushi/toml"
	"github.com/jmoiron/sqlx"
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
func GetConfig() (cfg *Config, err error) {
	dir, err := filepath.Abs(filepath.Dir(os.Args[0]))
	if err != nil {
		log.Fatal(err)
	}
	_, err = toml.DecodeFile(dir+"/config.toml", &cfg)
	return
}
