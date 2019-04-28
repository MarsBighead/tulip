import { Component, OnInit } from '@angular/core';

import { Gene } from '../gene';
import { GeneService } from '../gene.service';

@Component({
  selector: 'app-genes',
  templateUrl: './genes.component.html',
  styleUrls: ['./genes.component.css']
})
export class GenesComponent implements OnInit {
  //genes=GENES;
 
  selectedGene: Gene;
  
  genes: Gene[];
  genesColumns: string[] = ['gene', 'mode_name', 'chromosome', 'score', 'strand','exon_count', 'tx_start', 'tx_end' ];
  constructor(private geneService: GeneService) { }

  ngOnInit() {
    this.getGenes();
  }


  getGenes(): void {
    this.geneService.getGenes()
        .subscribe(genes => this.genes = genes);
  }

}

