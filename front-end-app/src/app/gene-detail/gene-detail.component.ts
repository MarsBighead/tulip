import { Component, OnInit, Input } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Location } from '@angular/common';

import { Gene } from '../gene';
import { GeneService } from '../gene.service';

@Component({
  selector: 'app-gene-detail',
  templateUrl: './gene-detail.component.html',
  styleUrls: ['./gene-detail.component.css']
})
export class GeneDetailComponent implements OnInit {
  @Input() gene: Gene;
  constructor(
    private route: ActivatedRoute,
    private geneService: GeneService,
    private location: Location
  ) { }

  ngOnInit() {
    this.getGene();
  }
  getGene(): void {
    const mode_name = this.route.snapshot.paramMap.get('mode_name');
    this.geneService.getGene(mode_name)
      .subscribe(gene => this.gene = gene);
  }

  goBack(): void {
    this.location.back();
  }

}
