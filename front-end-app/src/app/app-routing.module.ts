import { NgModule } from '@angular/core';

import { RouterModule, Routes } from '@angular/router';

import { GenesComponent }      from './genes/genes.component';
import { HomeComponent }   from './home/home.component';
import { GeneDetailComponent }  from './gene-detail/gene-detail.component';

const routes: Routes = [
  { path: '', redirectTo: '/home', pathMatch: 'full' },
  { path: 'home', component: HomeComponent },
  { path: 'genes/:mode_name', component: GeneDetailComponent },
  { path: 'genes', component: GenesComponent },
];


@NgModule({
  imports: [
    RouterModule.forRoot(routes)
  ],
  exports: [ RouterModule ]
})

export class AppRoutingModule { }
