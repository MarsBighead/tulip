import { Component, OnInit } from '@angular/core';

import { Gene } from '../gene';
import { GeneService } from '../gene.service';
// import { GENES } from '../mock-genes';
@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {
  genes: Gene[];
  
  constructor(private geneService: GeneService) { }

  ngOnInit() {
    this.getGenes();
  }

  getGenes(): void {
    this.geneService.getGenes()
        .subscribe(genes => this.genes = genes.slice(0,4));
  }

}

