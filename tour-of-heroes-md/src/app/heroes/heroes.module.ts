import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {HeroesRoutingModule} from './heroes-routing.module';
import {SharedModule} from '../shared/shared.module';
import {HeroListComponent} from './hero-list/hero-list.component';

@NgModule({
  imports: [
    CommonModule,
    HeroesRoutingModule,
    SharedModule
  ],
  declarations: [
    HeroListComponent
  ],
  entryComponents: []
})
export class HeroesModule {
}
