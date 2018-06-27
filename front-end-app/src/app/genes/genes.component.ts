import { Component, OnInit } from '@angular/core';
import { Gene } from '../gene';
import { GeneService } from '../gene.service';
import { GENES } from '../mock-genes';
@Component({
  selector: 'app-genes',
  templateUrl: './genes.component.html',
  styleUrls: ['./genes.component.css']
})
export class GenesComponent implements OnInit {
  genes=GENES;

  selectedGene:Gene;
  
  constructor(private geneService: GeneService) { }

  ngOnInit() {
    this.getGenes();
  }
  onSelect(gene: Gene): void {
    this.selectedGene = gene;
  }
  getGenes(): void {
    this.geneService.getGenes()
        .subscribe(heroes => this.genes = this.genes);
  }

}

