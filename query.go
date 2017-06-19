package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"strconv"
	"strings"

	"log"

	"net/http"
	"net/url"

	_ "github.com/go-sql-driver/mysql"
	"github.com/gorilla/schema"
)

// Gene Gene structure cut mode
type Gene struct {
	ModeName     string `db:"name"            json:"mode_name"`
	Chromosome   string `db:"chrom"           json:"chromosome"`
	Strand       string `db:"strand"          json:"strand"`
	TxStart      int    `db:"txStart"         json:"tx_start"`
	TxEnd        int    `db:"txEnd"           json:"tx_end"`
	CdsStart     int    `db:"cdsStart"        json:"-"`
	CdsEnd       int    `db:"cdsStart"        json:"-"`
	ExonCount    int    `db:"exonCount"       json:"exon_count"`
	ExonStarts   []byte `db:"exonStarts"      json:"-"`
	ExonEnds     []byte `db:"exonEnds"        json:"-"`
	Score        int    `db:"score"           json:"score"`
	Gene         string `db:"gene"            json:"gene"`
	CdsStartStat string `db:"cdsStartStat"    json:"-"`
	CdsEndStat   string `db:"cdsStartStat"    json:"-"`
	ExonFrames   []byte `db:"exonFrames"      json:"-"`
}

// given Create table to store refGene
func (s *Service) givenGene(w http.ResponseWriter, r *http.Request) {
	params := r.URL.Query()
	q, err := queryParams(params)
	if err != nil {
		log.Fatal(err)
	}
	log.Println(params)
	var geneRows []*Gene
	sql := q.refGeneSQL()
	udb := s.db.Unsafe()
	udb.Select(&geneRows, sql)
	//log.Println(sql)

	body, err := json.MarshalIndent(geneRows, "", "    ")
	if err != nil {
		log.Fatal(err)
	}
	w.Write(body)
}

// Query Parse query refGene data struct
type Query struct {
	Chromosome string `schema:"chrom"`
	Gene       string `schema:"gene"`
	Start      int    `schema:"start"`
	End        int    `schema:"end"`
	MinModes   int    `schema:"min_modes"`
	MaxModes   int    `schema:"max_modes"`
	ExonCount  int    `sechema:"exon_count"`
}

func queryParams(uv url.Values) (q *Query, err error) {
	q = new(Query)
	dec := schema.NewDecoder()
	dec.IgnoreUnknownKeys(true)
	if err = dec.Decode(q, uv); err != nil {
		log.Fatal(err)
		return
	}
	return
}

func (q *Query) refGeneSQL() (sql string) {
	var whereConds []string
	var where string
	if q.Start != 0 {
		whereConds = append(whereConds, "txStart>"+strconv.Itoa(q.Start))
	}
	if q.End != 0 {
		whereConds = append(whereConds, "txEnd>"+strconv.Itoa(q.End))
	}
	if q.Gene != "" {
		whereConds = append(whereConds, "name2='"+q.Gene+"'")
	}
	if len(whereConds) >= 1 {
		where = "where " + strings.Join(whereConds, " and ")
	}
	sql = fmt.Sprintf(`select name,
							  chrom,
							  strand,
							  txStart,
							  txEnd,
							  cdsStart,
							  cdsEnd,
							  exonCount,
							  exonStarts,
							  exonEnds,
                              score,
							  name2 gene,
							  exonFrames 
					   from hg.refGene
                       %s`, where)
	//limit 1,5`, where)
	return
}

// TruncateTable Truncate data in the table
func TruncateTable(table string, db *sql.DB) {

	truncate, err := db.Prepare("Truncate " + table) // ? = placeholder
	if err != nil {
		panic(err.Error())
	}
	defer truncate.Close()
	_, err = truncate.Exec()
	if err != nil {
		panic(err.Error())
	}
	fmt.Printf("Truncate table chr successfully!\n")
}

// dumpLoad Truncate data in the table
func dumpLoad(refGene string, db *sql.DB) {
	/*
		readerName := "r" + strconv.Itoa(rand.Int())
		mysql.RegisterReaderHandler(readerName,
			func() io.Reader {
				return bytes.NewBufferString(refGene)
			})
		defer mysql.DeregisterReaderHandler(readerName)
		cmd := "LOAD DATA LOCAL INFILE 'Reader::" + readerName + "' " +
			"IGNORE INTO TABLE chr "
		_, err := db.Exec(cmd)
		if err != nil {
			panic(err.Error())
		}*/
}
