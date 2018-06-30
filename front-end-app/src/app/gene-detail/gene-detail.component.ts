import { Component, OnInit, Input } from '@angular/core';
import { Gene } from '../gene';

@Component({
  selector: 'app-gene-detail',
  templateUrl: './gene-detail.component.html',
  styleUrls: ['./gene-detail.component.css']
})
export class GeneDetailComponent implements OnInit {
  @Input() gene: Gene;
  constructor() { }

  ngOnInit() {
  }

}
