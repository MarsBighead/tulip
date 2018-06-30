package method

// Config  configure file for application
type Config struct {
	Application string     `yaml:"application"`
	Databases   []Database `yaml:"databases"`
	HTTP        struct {
		PORT string `yaml:"port"`
	} `yaml:"http"`
	Data *Data `yaml:"data"`
}

//Database configure structure
type Database struct {
	DSN    string `yaml:"dsn"`
	Switch string `yaml:"switch"`
}

//Data refGene data file information
type Data struct {
	SQL     string `yaml:"sql"`
	RefGene string `yaml:"refGene"`
	DBNAME  string `yaml:"dbname"`
}

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

// Query Parse query refGene data struct
type Query struct {
	Chromosome string `schema:"chrom"`
	Gene       string `schema:"gene"`
	ModeName   string `schema:"mode_name"`
	Start      int    `schema:"start"`
	End        int    `schema:"end"`
	MinModes   int    `schema:"min_modes"`
	MaxModes   int    `schema:"max_modes"`
	ExonCount  int    `sechema:"exon_count"`
}
