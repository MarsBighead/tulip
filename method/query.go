package method

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"strconv"
	"strings"

	"log"

	"net/http"
	"net/url"

	"github.com/gorilla/schema"
)

//GivenGene given Create table to store refGene
func (s *Service) GivenGene(w http.ResponseWriter, r *http.Request) {
	params := r.URL.Query()
	q, err := queryParams(params)
	if err != nil {
		log.Fatal(err)
	}
	log.Println(params)
	var geneRows []*Gene
	sql := q.refGeneSQL()
	udb := s.db.Unsafe()
	err = udb.Select(&geneRows, sql)
	if err != nil {
		log.Fatal(err)
	}
	log.Println("Query result is on the way...")

	var body []byte
	if len(geneRows) <= 1 {
		body, err = json.MarshalIndent(geneRows[0], "", "    ")
		if err != nil {
			log.Fatal(err)
		}
	} else {
		body, err = json.MarshalIndent(geneRows, "", "    ")
		if err != nil {
			log.Fatal(err)
		}
	}
	w.Header().Add("Access-Control-Allow-Origin", "*")
	w.Write(body)
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
	if q.ModeName != "" {
		whereConds = append(whereConds, "name='"+q.ModeName+"'")
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
					   from hg38.refGene
                       %s`, where)
	//limit 1,5`, where)
	//fmt.Println(sql)
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
