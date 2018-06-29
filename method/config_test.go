package method

import (
	"fmt"
	"testing"
)

func TestGetConfig(t *testing.T) {
	cfg, err := GetConfig("../config.yaml")
	if err != nil {
		t.Fatal(err)
	}
	fmt.Printf("%#v\n", cfg.Data)
}
