package load

import (
	"fmt"
	"testing"
)

func TestGetConfig(t *testing.T) {
	dns := "root:togerme@(localhost:3306)/hg38"
	df := &DataFilename{
		Table: "../../hg38/refGene.sql",
	}
	err := df.Load(dns)
	if err != nil {
		t.Fatal(err)
	}
	fmt.Printf("%#v\n", dns)
}
