import { Component, OnInit } from '@angular/core';
import { Gene } from '../gene';

@Component({
  selector: 'app-genes',
  templateUrl: './genes.component.html',
  styleUrls: ['./genes.component.css']
})
export class GenesComponent implements OnInit {
gene: Gene = {
    mode_name: "NM_004009",
    chromosome: "chrX",
    strand: "-",
    tx_start: 31119227,
    tx_end: 33128428,
    exon_count: 79,
    score: 0,
    gene: "DMD"
}


  constructor() { }

  ngOnInit() {
  }

}

