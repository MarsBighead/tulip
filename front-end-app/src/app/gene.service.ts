import { Injectable } from '@angular/core';

import { Observable, of } from 'rxjs';

import { Gene } from './gene';
import { GENES } from './mock-genes';
import { MessageService } from './message.service';

import { HttpClient, HttpHeaders } from '@angular/common/http';
import { catchError, map, tap } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class GeneService {
  private genesUrl = 'http://localhost:8010/api/v1/gene';  // URL to web api
  private name ="BRCA1";
  //private genesUrl = 'api/genes';  // URL to web api
  constructor(
    private http: HttpClient,
    private messageService: MessageService) { }
 
  getGenes(): Observable<Gene[]> {
    // TODO: send the message _after_ fetching the heroes
    this.messageService.add('GeneService: fetched genes');
    //return of(GENES);
    console.log(`${this.genesUrl}?gene=${this.name}`);
    return this.http.get<Gene[]>(`${this.genesUrl}?gene=${this.name}`)
    .pipe(
      tap(genes => this.log(`fetched genes`)),
      catchError(this.handleError('getGenes', []))
    );
  }

   /** GET hero by id. Return `undefined` when id not found */
   getGeneNo404<Data>(mode_name: string): Observable<Gene> {
    const url = `${this.genesUrl}/${mode_name}`;
    return this.http.get<Gene[]>(url)
      .pipe(
        map(heroes => heroes[0]), // returns a {0|1} element array
        tap(h => {
          const outcome = h ? `fetched` : `did not find`;
          this.log(`${outcome} gene mode_name=${mode_name} failed`);
        }),
        catchError(this.handleError<Gene>(`getGene mode_name=${mode_name}`))
      );
  }

  getGene(mode_name: string): Observable<Gene> {
    // TODO: send the message _after_ fetching the hero
    const url = `${this.genesUrl}/?mode_name=${mode_name}`;
    console.log(url)
    return this.http.get<Gene>(url).pipe(
      tap(_ => this.log(`fetched hero mode_name=${mode_name}`)),
      catchError(this.handleError<Gene>(`getHero mode_name=${mode_name}`))
    );
    /*this.messageService.add(`GeneService: fetched gene mode_name=${mode_name}`);
    return of(GENES.find(gene => gene.mode_name === mode_name));*/
    
  }
  /** Log a HeroService message with the MessageService */
  private log(message: string) {
    this.messageService.add('GeneService: ' + message);
  }
  /**
 * Handle Http operation that failed.
 * Let the app continue.
 * @param operation - name of the operation that failed
 * @param result - optional value to return as the observable result
 */
private handleError<T> (operation = 'operation', result?: T) {
  return (error: any): Observable<T> => {
 
    // TODO: send the error to remote logging infrastructure
    console.error(error); // log to console instead
 
    // TODO: better job of transforming error for user consumption
    this.log(`${operation} failed: ${error.message}`);
 
    // Let the app keep running by returning an empty result.
    return of(result as T);
  };
}
}
