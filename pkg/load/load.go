package load

import (
	"database/sql"
	"fmt"
	"io/ioutil"

	_ "github.com/go-sql-driver/mysql"
)

type DataFilename struct {
	Table string
	Data  string
}

func (df *DataFilename) Load(dns string) error {
	db, err := sql.Open("mysql", dns)
	if err != nil {
		return err
	}
	defer db.Close()

	return createTable(db, df.Table)
}
func createTable(db *sql.DB, filename string) error {
	content, err := ioutil.ReadFile(filename)
	if err != nil {
		return err
	}
	//fmt.Println(string(content))
	result, err := db.Exec(string(content))
	if err != nil {
		return err
	}
	fmt.Println(result)
	return nil
}

func loadData(db *sql.DB, filename string) error {

	return nil
}
