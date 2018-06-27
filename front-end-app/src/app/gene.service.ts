import { Injectable } from '@angular/core';

import { Observable, of } from 'rxjs';
import { Gene } from './gene';
import { GENES } from './mock-genes';
import { MessageService } from './message.service';

@Injectable({
  providedIn: 'root'
})
export class GeneService {

  constructor(private messageService: MessageService) { }
 
  getGenes(): Observable<Gene[]> {
    // TODO: send the message _after_ fetching the heroes
    this.messageService.add('HeroService: fetched heroes');
    return of(GENES);
  }
}
