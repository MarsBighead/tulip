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

  constructor(private geneService: GeneService) { }

  ngOnInit() {
    this.getGenes();
  }


  getGenes(): void {
    this.geneService.getGenes()
        .subscribe(genes => this.genes = genes);
  }

}

